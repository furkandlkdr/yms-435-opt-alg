function deger = amac_fonksiyonu(x)
    % Amaç Fonksiyonu: -x^2 + 4*x + 10
    % Bu fonksiyonu maksimize etmeye çalışıyoruz.
    % Girdi: x (vektör veya skaler)
    % Çıktı: Fonksiyon değeri
    
    % x'in karesini alırken eleman eleman işlem yapmak için .^ kullanılır
    deger = -x.^2 + 4.*x + 10;
end
