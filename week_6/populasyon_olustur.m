function [ ] = populasyon_olustur( )

global n m populasyon sinir_alt sinir_ust

for i = 1:n
    for j = 1:m
        populasyon(i, j) = sinir_alt + rand(1)*(sinir_ust - sinir_alt); % Bu formülü bil
    end
end

end
