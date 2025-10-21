clc; clear all; close all;

global n m rc rm populasyon fd sinir_alt sinir_ust ras_sayi delta

% x^2 + y^2 = 11'i veren x ve y değerlerini bul
% 1. Adım Başlangıç Parametrelerini Ayarlar

n = 10; % popülasyon sayısı
m = 2; % Popülasyon boyutu
sinir_alt = -5; % parametre alt değeri
sinir_ust = 5; % parametre üst değeri
delta = 0.05; % Mutasyondaki komşuluk büyüklüğü
iterasyon = 11; % Normalde yüz ama test amaçlı 1 bıraktık
rc = 0.9; % Çaprazlama oranı
rm = 0.03; % Mutasyon oranı

populasyon_olustur; % Fonksiyon çağırırken parantez kullanmadı dikkat et

%% Adım 2 Fitness Hesapla
% Fitness (uygunluk) fonksiyonu, benim fonksiyonumun sıfır olmuş hali.
% x^2 + y^2 - 11 = 0
populasyon_baslangic = populasyon;
j = 1;
while (j < iterasyon)
    fitness_hesapla;
    % Adım 3 Seleksiyon
    pop_selek = seleksiyon(populasyon);
    % Adım 4 Çarpazlama
    pop_cap = caprazlama(pop_selek);
    % Adım 5 Mutasyon
    populasyon = mutasyon(pop_cap);
    fprintf('İterasyon: %d\n', j);
    fprintf('En iyi değer: %d\n', min(fd));
    
j = j + 1;
end

fitness_hesapla;
en_iyi_deger = min(fd);
ind = find(en_iyi_deger == fd);
gx= populasyon(ind(1, 1), 1);
gy = populasyon(ind(1, 1), 2);
sonuc = [gx, gy];
disp('En iyi çözüm:');
disp(sonuc);