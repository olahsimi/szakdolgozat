clear
close all
ember_num = 300;
fert_tav = 9;
[G,A, Px, Py] = geograf(ember_num,fert_tav);
figure()
h = plot(G,'XData',Px,'YData',Py);
title(sprintf('t = %.2f', 0));
nodeColors = repmat([0 0 1], numnodes(G), 1); %csúcsok színének tetszőleges beállítása: S:kék, I:piros, r:zöld
h.NodeColor = nodeColors;
h.MarkerSize = 4;
pause(1);

c_max = 300; 
mu = 0.01;
p=0.2;
tau = 7; 

allapot = zeros(2,ember_num);
elso= 0;
fert = randperm(ember_num,1);
allapot(1,fert)=1;
fert1=fert;
allapot(2,fert) = elso;
T_k = [elso; fert]; 
[fokszam, kapcsolat] = deg_f(A, ember_num);

for i = 1:length(fert)
              nodeColors(fert(i), :) = [1 0 0];
 end
              h.NodeColor = nodeColors;

waitforbuttonpress;
c=0;
while  c < c_max
     
    T_new = [T_k(1, end);0];
     for i = 1:length(allapot(1,:))
           if allapot(1,i)==1 && allapot(2,i) + tau < T_new(1) 
                    nodeColors(i, :) = [0 0 1];
                    allapot(1,i) = 0;
          end
     end  
     h.NodeColor = nodeColors;
    [T_k, allapot, nodeColors, h] = hawkes(T_k, T_new, tau, allapot, fert1,fokszam, mu,p, nodeColors, h);
    [allapot, T_k] = kioszt_f(allapot, T_k, kapcsolat, ember_num, mu,p);
    title(sprintf('t = %.2f', T_k(1,end)));
    fert1= find(allapot(1,:)==1);
             for i = 1:length(fert1)
                nodeColors(fert1(i), :) = [1 0 0];
             end            
              h.NodeColor = nodeColors;
                          pause(0.1);

     c= c+1;
end

figure()
 pl = 0:1:T_k(1,end);
 [f, ki] = ksdensity(T_k(1, :), pl);
 plot(ki, f);
 R=sum(fokszam);
 R=(R/ember_num)*p;
 