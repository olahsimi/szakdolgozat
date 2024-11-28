%geografikus grafbol sima grafot fuggveny
function [G,A, Px, Py] = geograf(ember_num,fert_tav,meret)

Px = zeros(1,ember_num);
Py = zeros(1,ember_num);
elek = [];

for j = 1: ember_num
    x1 = round(rand(1)*meret);
    y1 = round(rand(1)*meret);
    Px(1,j) = x1;
    Py(1,j) = y1;
end

for k = 1:ember_num
    for  l =k:ember_num
    
    dist = sqrt((Px(k)-Px(l))^2+(Py(k)-Py(l))^2);
        if dist<fert_tav && k~=l
        elek = [elek; k l];
        end
    end
end

 A = zeros(ember_num);
 for m = 1:size(elek(:,1))
    A(elek(m,1),elek(m,2)) = 1;
     A(elek(m,2),elek(m,1)) = 1;
 end
 G = graph(A);
