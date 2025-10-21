function [ pop ] = caprazlama ( pop )

global n m rc

% Çiftler belirleniyor
ciftler = randperm(n);
cap_sayisi = ( n / 2 );
for i = 1:cap_sayisi
    % Randperm'deki index numaralarına ulaşmak için
    eve1inx = ciftler(2 * i - 1);
    eve2inx = ciftler(2 * i);
    
    % İndekslerdeki çözümler alınıyor.
    eve1 = pop(eve1inx, :);
    eve2 = pop(eve2inx, :);

    cap_rs = unifrnd(0, 1);

    if cap_rs < rc
        ara = eve1(2 : end);
        eve1(2: end) = eve2(2 : end);
        eve2(2: end) = ara;

        pop(eve1inx, :) = eve1;
        pop(eve2inx, :) = eve2;

        % Matematiksel doğru hali bu, ama eski ve 2li halini yazdı hoca. 
        % crossoverPoint = randi([1, m-1]); % Random crossover point
        % % Perform crossover between eve1 and eve2
        % offspring1 = [eve1(1:crossoverPoint), eve2(crossoverPoint+1:end)];
        % offspring2 = [eve2(1:crossoverPoint), eve1(crossoverPoint+1:end)];
        % pop(2 * i - 1, :) = offspring1; % Store first offspring
        % pop(2 * i, :) = offspring2;     % Store second offspring
    end
    

end


end