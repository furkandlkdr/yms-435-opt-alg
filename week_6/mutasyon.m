function [ pop ] = mutasyon ( pop )

global n m rm sinir_alt sinir_ust delta

mut_matris = unifrnd(0, 1, [n, m]);

for i = 1:n
    for j = 1:m
        if mut_matris(i, j) < rm
            deger = unifrnd(-1, 1);
            pop(i, j) = pop(i, j) + ( deger * delta * (sinir_ust - sinir_alt));
            % Sınırlar dışında kalmayı önlemek için kırpma
            if pop(i, j) < sinir_alt
                pop(i, j) = sinir_alt;
            elseif pop(i, j) > sinir_ust
                pop(i, j) = sinir_ust;
            end
            % AI yazdı aşağıyı, ama dersteki üstteki.
            % pop(i, j) = pop(i, j) + delta * (rand() * (sinir_ust - sinir_alt) + sinir_alt);
        end
    end
end