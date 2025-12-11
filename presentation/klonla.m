function klonlar = klonla(antikorlar, afiniteler, beta)
    % Seçilen antikorları afinitelerine göre klonlar.
    % Girdiler:
    % antikorlar: Seçilen antikor matrisi
    % afiniteler: Seçilen antikorların afinite değerleri
    % beta: Klonlama katsayısı
    
    toplam_afinite = sum(afiniteler);
    klonlar = [];
    
    [n, ~] = size(antikorlar);
    
    for i = 1:n
        % Klon sayısını formüle göre hesapla
        % n_clones = round(beta * affinity / total_affinity)
        oran = afiniteler(i) / toplam_afinite;
        klon_sayisi = round(beta * oran);
        
        % En az 1 klon olmasını garanti et
        klon_sayisi = max(1, klon_sayisi);
        
        % Klonları oluştur ve listeye ekle
        for k = 1:klon_sayisi
            klonlar = [klonlar; antikorlar(i, :)];
        end
    end
end
