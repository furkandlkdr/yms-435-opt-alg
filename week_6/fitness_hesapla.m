function [ ] = fitness_hesapla( )
% (x^2) + (y^2) - 11 = 0
global populasyon n fd

for i = 1: n
    x = populasyon(i, 1);
    y = populasyon(i, 2);
    fd(i,:) = abs((x^2) + (y^2) - 11); % Burada i,: diyerek sütun yapıyoruz verileri
end
end