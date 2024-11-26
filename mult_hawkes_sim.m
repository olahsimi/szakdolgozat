clear
close all
meret = 100;
ember_num = 400;
fert_tav = 9;

[G,A, Px, Py] = geograf(ember_num,fert_tav, meret);
fig=figure();
pl1=subplot(1,2,1);

h = plot(G,'XData',Px,'YData',Py);
title(pl1,sprintf('t = %.2f', 0));
nodeColors = repmat([0 0 1], numnodes(G), 1); %csúcsok színének tetszőleges beállítása: S:kék, I:piros, r:zöld
h.NodeColor = nodeColors;
h.MarkerSize = 4;
 xlim([-1,meret+1]);
 ylim([-1,meret+1]);
xticks([]);
yticks([]);

B = norm(A,2);
c_max = 1000; 
mu = 0.01;
p=1/(B+2);
%p=0.15;
tau = 2; 

fert_szam=zeros(1,c_max);
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
pl2=subplot(1,2,2);
hold on
xlabel('Idő')
ylabel('Fertőzöttek aránya')
waitforbuttonpress;
fertozesek=[length(fert1);0];
gyogyultak=[0;0];

c=0;
while  c < c_max
     
    T_new = [T_k(1, end);0];
    
   if c ==15
    [T_k, allapot, nodeColors, h,fertozesek,gyogyultak] = hawkes3(T_k, T_new, tau, allapot, fert1,fokszam, mu,p, nodeColors, h,fertozesek,gyogyultak);
   else
    [T_k, allapot, nodeColors, h,fertozesek,gyogyultak,pl1] = hawkes(T_k, T_new, tau, allapot, fert1,fokszam, mu,p, nodeColors, h,fertozesek,gyogyultak,pl1);
   end
    [allapot, T_k] = kioszt_f(allapot, T_k, kapcsolat, ember_num, mu,p);
    title(pl1,sprintf('t = %.2f', T_k(1,end)));
    fert1= find(allapot(1,:)==1);
             for i = 1:length(fert1)
                nodeColors(fert1(i), :) = [1 0 0];
             end            
              h.NodeColor = nodeColors;
                          pause(0.01);
                          seged= [length(fert1);T_k(1,end)];
fertozesek=[fertozesek seged];
plot(pl2,fertozesek(2,:),fertozesek(1,:)./ember_num,"LineWidth",1,"Color",'r')
     c= c+1;
end

figure()
hold on
plot(fertozesek(2,:),fertozesek(1,:)./ember_num,"LineWidth",1,"Color",'r')
plot(fertozesek(2,:),1-(fertozesek(1,:)./ember_num),"LineWidth",1,"Color",'b')

gyogyultak(:,1)=[];
egeszek1 = floor(gyogyultak(2,:));
uniqueInts1 = unique(egeszek1); % Find unique integer parts
count1 = histcounts(egeszek1, [uniqueInts1, max(uniqueInts1) + 1]); % Count occurrences
bar(uniqueInts1,count1./ember_num,"green");
%plot(gyogyultak(2,:),gyogyultak(1,:)./ember_num,"LineWidth",1,"Color",'g')

figure()
egeszek = floor(T_k(1,:));
uniqueInts = unique(egeszek); % Find unique integer parts
count = histcounts(egeszek, [uniqueInts, max(uniqueInts) + 1]); % Count occurrences
bar(uniqueInts,count,"red");
title('Események bekövetkezésének száma időegységenként')
xlabel('Idő')
ylabel('Események száma')
%tengely=0:1:uniqueInts(end);
%xticks(tengely)
 
