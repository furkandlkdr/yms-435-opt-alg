function populasyon = populasyon_olustur(pop_buyuklugu, boyut, sinirlar)
    % Rastgele popülasyon oluşturma fonksiyonu
    % Girdiler:
    % pop_buyuklugu: Oluşturulacak birey sayısı
    % boyut: Her bireyin gen sayısı (değişken sayısı)
    % sinirlar: [alt_sinir, ust_sinir] dizisi
    
    alt_sinir = sinirlar(1);
    ust_sinir = sinirlar(2);
    
    % rand fonksiyonu 0 ile 1 arasında rastgele sayılar üretir.
    % Bunu istenilen aralığa genişletiyoruz.
    populasyon = (ust_sinir - alt_sinir) * rand(pop_buyuklugu, boyut) + alt_sinir;
end
