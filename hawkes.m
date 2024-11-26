function [T_k, allapot, nodeColors, h,fertozesek,gyogyultak,pl1] = hawkes(T_k, T_new, tau, allapot, fert1,fokszam, mu,p, nodeColors, h,fertozesek,gyogyultak,pl1)
xi=exprnd(1);
if xi ==0
    xi=exprnd(1);
end
T = T_k(1,end);
szumma=zeros(1,length(fert1));
stop = 0;
ttt=0;
fertj=[];
cn=zeros(1,length(fert1));
  for n = 1:1:length(fert1)
            deg_j=fokszam(fert1);
            cn_i =allapot(2,fert1);
            cn(n) = cn_i(n)-(T-tau);            
        if cn(n)<0        
        cn(n)=0;
        end     
   end
    while stop<1
    %for ttt =0:0.001:10  
    w=0;
    for i=1:length(fert1)
     if allapot(2,fert1(i))+tau<T_new(1,:)
         seged= [length(fert1)-w;allapot(2,fert1(i))+tau];
         gyogy=gyogyultak(1,end)+1;
      seged2=[gyogy;allapot(2,fert1(i))+tau];
     allapot(1,fert1(i))=0;
      allapot(2,fert1(i))=0;
      
      gyogyultak=[gyogyultak seged2];
      fertozesek=[fertozesek seged];
      fertj=[fertj i];
      nodeColors(fert1(i), :) = [0 0 1];
       h.NodeColor = nodeColors;
       title(pl1,sprintf('t = %.2f', T_new(1,:)));
     end
    end
    
    fert1(fertj)=[];
    fertj=[];
    if isempty(fert1)==1
        vzd=1;
    end
    for n =1:1:length(szumma)
       minimum = [ttt cn(n)];
            m = min(minimum);
            szumma(n) = p*deg_j(n)*m;   
    end  
        eq = mu*ttt + sum(szumma);
        if eq ==xi || eq>=xi
            if isempty(T_k) ==1
            T_k = [T_new; 0];
            else
            T_k = [T_k T_new];
            
            end  
            stop=2;
            break
           
        end
         T_new(1,:)=T_new(1,:)+0.001;
         ttt=ttt+0.001;
       % disp(T_new);
    end

end