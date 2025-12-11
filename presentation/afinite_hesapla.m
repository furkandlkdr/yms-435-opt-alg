function afinite = afinite_hesapla(x)
    % Afinite Hesaplama
    % Amaç fonksiyonu değerini afiniteye dönüştürür.
    % Yüksek amaç fonksiyonu değeri -> Yüksek afinite
    % Negatif değerlerden kaçınmak ve mutasyon oranını dengelemek için exp kullanılır.
    
    deger = amac_fonksiyonu(x);
    
    % Afiniteyi hesapla (e^deger)
    % Maksimum değer 14 olduğu için e^14 hesaplanabilir bir sayıdır.
    afinite = exp(deger);
end
