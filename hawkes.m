function [T_k, allapot, nodeColors, h] = hawkes(T_k, T_new, tau, allapot, fert1,fokszam, mu,p, nodeColors, h)
xi=exprnd(3);
if xi ==0
    xi=exprnd(1);
end
szumma=zeros(1,length(fert1));
stop = 0;
ttt=0;
fertj=[];
    while stop<1
    %for ttt =0:0.001:10  
    for i=1:length(fert1)
     if allapot(2,fert1(i))+tau<T_new(1,:)
     allapot(1,fert1(i))=0;
      allapot(2,fert1(i))=0;
      fertj=[fertj i];
      nodeColors(fert1(i), :) = [0 0 1];
       h.NodeColor = nodeColors;
       title(sprintf('t = %.2f', T_new(1,:)));
     end
    end
    
    fert1(fertj)=[];
    fertj=[];
        for n = 1:1:length(fert1)
            deg_j=fokszam(fert1);
            cn_i =allapot(2,fert1);
            cn = cn_i(n)-(T_new(1,:)-tau);            
        if cn<0        
        cn=0;
        end
            minimum = [ttt cn];
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