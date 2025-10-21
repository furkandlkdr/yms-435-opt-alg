function [ populasyon_ara ] = seleksiyon( pop )

global fd n fitness_olasilik fitness_tpl fitness_olasilik_b ras_sayi;

% Sıfıra bölmeyi önlemek için küçük bir epsilon ekleyelim
eps_val = 1e-12;

fitness_tpl = 0;
for i = 1:n
    fitness_tpl = (1 / (fd(i) + eps_val)) + fitness_tpl; % Minimizasyon için 1/fitness
end

for j = 1:n
    fitness_olasilik(j, 1) = (100 * (1/(fd(j) + eps_val))) / fitness_tpl;
    % yüzde olarak her bir elemana olasılık dağıttık
end

fitness_olasilik_b = fitness_olasilik;
for i = 2:n
    fitness_olasilik_b(i) = fitness_olasilik_b(i - 1) + fitness_olasilik_b(i);
end
% Kümülatif olasılıklar toplamını  hesapladık, matlabda 0. index yokmuş (?)

populasyon_ara = pop;
for i = 1:n
    ras_sayi = unifrnd(0, 1, [n, 1]) * 100; % Rulet çarkı değeri
    index = find(ras_sayi <= fitness_olasilik_b, 1, 'first'); % Çark içerisindeki değer
    if isempty(index)
        % Sayı üst sınıra denk gelirse son elemanı seç
        index = n;
    end
    populasyon_ara(i, :) = pop(index, :); % Seçilen bireyi yeni popülasyona ekle
end

end