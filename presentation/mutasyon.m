function mutantlar = mutasyon(klonlar, afiniteler, rho)
    % Hipermutasyon fonksiyonu
    % Afiniteye ters orantılı olarak mutasyon uygular.
    
    mutantlar = klonlar;
    [n, boyut] = size(klonlar);
    
    for i = 1:n
        % Mutasyon oranını hesapla: rho * e^(-afinite)
        mutasyon_orani = rho * exp(-afiniteler(i));
        
        for j = 1:boyut
            % Mutasyon olasılığı kontrolü
            if rand() < mutasyon_orani
                % Gaussian (Normal) dağılım ile değişim
                degisim = randn() * mutasyon_orani;
                mutantlar(i, j) = mutantlar(i, j) + degisim;
            end
        end
    end
end
