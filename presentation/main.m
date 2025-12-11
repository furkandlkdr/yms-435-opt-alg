% CLONALG (Yapay Bağışıklık Sistemi) Ana Dosyası
% Amaç Fonksiyonu: -x^2 + 4*x + 10 (Maksimizasyon)

clear; clc; close all;

% --- Parametreler ---
pop_buyuklugu = 50;      % Popülasyon büyüklüğü
secilen_sayisi = 20;     % Seçilecek antikor sayısı
beta = 1.0;              % Klonlama çarpanı
rho = 2.0;               % Mutasyon sabiti
d = 10;                  % Her iterasyonda yenilenecek (rastgele) antikor sayısı
max_iterasyon = 100;     % Maksimum iterasyon sayısı
boyut = 1;               % Değişken sayısı (x tek değişken)
sinirlar = [-10, 10];    % Arama uzayı sınırları

% --- Başlangıç ---
% Rastgele popülasyon oluştur
populasyon = populasyon_olustur(pop_buyuklugu, boyut, sinirlar);

en_iyi_degerler = [];    % Her iterasyondaki en iyi değerleri saklamak için
hafiza = [];             % En iyi çözümleri saklamak için

tic; % Süre ölçümü başlat

for iter = 1:max_iterasyon
    % 1. Afiniteleri Hesapla
    afiniteler = zeros(pop_buyuklugu, 1);
    for i = 1:pop_buyuklugu
        afiniteler(i) = afinite_hesapla(populasyon(i, :));
    end
    
    % 2. Seçim (En iyi antikorları seç)
    [sirali_afiniteler, sirali_indeksler] = sort(afiniteler, 'descend');
    
    secilen_indeksler = sirali_indeksler(1:secilen_sayisi);
    secilen_populasyon = populasyon(secilen_indeksler, :);
    secilen_afiniteler = sirali_afiniteler(1:secilen_sayisi);
    
    % 3. Klonlama
    klonlar = klonla(secilen_populasyon, secilen_afiniteler, beta);
    
    % Klonların afinitelerini hesapla (Mutasyon için gerekli)
    klon_sayisi = size(klonlar, 1);
    klon_afiniteler = zeros(klon_sayisi, 1);
    for i = 1:klon_sayisi
        klon_afiniteler(i) = afinite_hesapla(klonlar(i, :));
    end
    
    % 4. Hipermutasyon
    mutantlar = mutasyon(klonlar, klon_afiniteler, rho);
    
    % Mutantların afinitelerini hesapla
    mutant_afiniteler = zeros(klon_sayisi, 1);
    for i = 1:klon_sayisi
        mutant_afiniteler(i) = afinite_hesapla(mutantlar(i, :));
    end
    
    % 5. Popülasyon Güncelleme (En iyileri tut)
    % Mevcut popülasyon ve mutantları birleştir
    birlesik_populasyon = [populasyon; mutantlar];
    birlesik_afiniteler = [afiniteler; mutant_afiniteler];
    
    % Hepsini sırala ve en iyi 'pop_buyuklugu' kadarını al
    [~, genel_sirali_indeksler] = sort(birlesik_afiniteler, 'descend');
    en_iyi_indeksler = genel_sirali_indeksler(1:pop_buyuklugu);
    
    populasyon = birlesik_populasyon(en_iyi_indeksler, :);
    
    % Güncel popülasyonun afinitelerini güncelle (sıralı olduğu için tekrar hesaplamaya gerek yok ama indisler karıştı)
    % Basitlik için tekrar hesaplayalım veya diziden çekelim.
    % Diziden çekmek daha hızlıdır.
    afiniteler = birlesik_afiniteler(en_iyi_indeksler);
    
    % 6. Hafıza Güncelleme
    % En iyi bireyi hafızaya ekle
    en_iyi_birey = populasyon(1, :); % Sıralı olduğu için ilki en iyisidir
    hafiza = [hafiza; en_iyi_birey];
    
    % En iyi skoru kaydet (Amaç fonksiyonu değeri)
    en_iyi_skor = amac_fonksiyonu(en_iyi_birey);
    en_iyi_degerler = [en_iyi_degerler; en_iyi_skor];
    
    % 7. Çeşitlilik (Diversity) - En kötüleri rastgele yenileriyle değiştir
    % Popülasyon zaten afiniteye göre azalan sırada (en iyi -> en kötü)
    % Son 'd' tanesini değiştir.
    for k = 0:(d-1)
        indeks = pop_buyuklugu - k;
        populasyon(indeks, :) = populasyon_olustur(1, boyut, sinirlar);
    end
    
    % İlerleme durumunu yazdır
    if mod(iter, 10) == 0
        fprintf('İterasyon %d: En İyi Değer = %.6f\n', iter, en_iyi_skor);
    end
end

sure = toc;

% --- Sonuçlar ---
% Hafızadaki en iyi çözümü bul
hafiza_degerleri = zeros(size(hafiza, 1), 1);
for i = 1:size(hafiza, 1)
    hafiza_degerleri(i) = amac_fonksiyonu(hafiza(i, :));
end
[en_iyi_sonuc_deger, en_iyi_idx] = max(hafiza_degerleri);
en_iyi_cozum = hafiza(en_iyi_idx, :);

fprintf('\n--- Sonuçlar ---\n');
fprintf('Çalışma Süresi: %.4f saniye\n', sure);
fprintf('En İyi Çözüm (x): %.6f\n', en_iyi_cozum);
fprintf('En İyi Değer (f(x)): %.6f\n', en_iyi_sonuc_deger);

% --- Grafik ---
figure;
plot(en_iyi_degerler, 'LineWidth', 2);
xlabel('İterasyon');
ylabel('En İyi Değer');
title(['CLONALG Yakınsama Grafiği - En İyi: ' num2str(en_iyi_sonuc_deger)]);
grid on;
