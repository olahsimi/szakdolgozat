function [fokszam, kapcsolat] = deg_f(A, ember_num) %fokszám számító függvény
    fokszam = sum(A);
    kapcsolat={};
   for i=1:1:ember_num
       
       kapcsolat{i} = find(A(i,:)==1);
   end
end