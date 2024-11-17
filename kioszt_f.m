function [allapot, T_k] = kioszt_f(allapot, T_k, kapcsolat, ember_num, mu,p)
a=ember_num;
intenzitas=zeros(1,a);
for j =1:1:a
c= allapot(1,kapcsolat{j})==1;
intenzitas(j)=mu/a + p*sum(c);
end

val=zeros(1,ember_num);
for j =1:1:a
    
    val(j)=intenzitas(j)/sum(intenzitas);
    
end
jeloles= find(allapot(1,:)==0);
val=val(1,allapot(1,:)==0);
val(2,:)=jeloles;
val(1,:)=val(1,:)./sum(val(1,:));
 hatarok=cumsum(val(1,:));
    hatarok = [0,hatarok];
    intervals = cell(1, length(hatarok)-1);
    for i = 1:length(hatarok)-1
    intervals{i} = [hatarok(i), hatarok(i+1)];
    end
random_number = rand;

    for i = 1:length(hatarok)-1
        if random_number >= intervals{i}(1) && random_number <= intervals{i}(2)  
            allapot(1,val(2,i))=1;
            allapot(2,val(2,i)) = T_k(1, end);
            T_k(2, end)=val(2,i);
            
        break;

        end
    end
end