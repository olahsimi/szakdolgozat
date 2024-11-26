function [allapot, T_k] = kioszt_f2(allapot, T_k, kapcsolat, ember_num, mu,p,tau)
a=ember_num;
b=T_k(1,end-1)-tau;
intenzitas=zeros(1,a);
jelenlegi=find(T_k(1,:)>=b);
T_most=T_k(:,jelenlegi);
T_most(:,end)=[];
for j =1:1:a
    indices = kapcsolat{j};         % Indices in the current cell
    count = zeros(1,length(indices));
    for k = 1:length(indices)
        count(k) = sum(T_most(2, :) == indices(k));
    end

c= sum(count);
intenzitas(j)=mu/a + p*c;
end

val=zeros(1,ember_num);
for j =1:1:a
    
    val(j)=intenzitas(j)/sum(intenzitas);
    
end


 hatarok=cumsum(val(1,:));
    hatarok = [0,hatarok];
    intervals = cell(1, length(hatarok)-1);
    for i = 1:length(hatarok)-1
    intervals{i} = [hatarok(i), hatarok(i+1)];
    end
random_number = rand;

    for i = 1:length(hatarok)-1
        if random_number >= intervals{i}(1) && random_number <= intervals{i}(2)  
            allapot(1,i)=1;
            allapot(2,i) = T_k(1, end);
            T_k(2, end)=i;
            
        break;

        end
    end
end