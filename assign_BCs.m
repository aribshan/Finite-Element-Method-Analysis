function [ENL, DOFs, DOCs] = assign_BCs(i, NL, BC_type)
NoN = size(NL,1);
PD = size(NL,2);
x = 1 + 3*i;
eff_x = x+x-1;
y = i+1;
eff_y = y+y-1;
ENL = zeros(NoN,PD*6);
ENL(:,1:PD) = NL; %extended node list

Px = sqrt(20)*3000*4/5*1/(6*i)/1000;
Py = sqrt(20)*3000*3/5*1/(6*i)/1000;

for i=1:NoN
    if ENL(i,1)==0
        ENL(i,PD+1)=-1;
        ENL(i,PD+2)=-1;

        ENL(i,4*PD+1)=0;
        ENL(i,4*PD+2)=0;

    else
        ENL(i,PD+1)=1;
        ENL(i,PD+2)=1;

        ENL(i,5*PD+1)=0;
        ENL(i,5*PD+2)=0;
    end
end
t=0;
for i=1:y-1
    t=t+eff_x;
    eff_x=eff_x-1;
    ENL(t,PD+1)=1;
    ENL(t,PD+2)=1;
    ENL(t,5*PD+1)=2*Px;
    ENL(t,5*PD+2)=2*Py;
    t=t+eff_x;
    eff_x=eff_x-1;
    ENL(t,PD+1)=1;
    ENL(t,PD+2)=1;
    ENL(t,5*PD+1)=4*Px;
    ENL(t,5*PD+2)=4*Py;
end
t=t+eff_x;
ENL(t,PD+1)=1;
ENL(t,PD+2)=1;
ENL(t,5*PD+1)=Px;
ENL(t,5*PD+2)=Py;
eff_x = x+x-1;
ENL(eff_x,5*PD+1)=ENL(eff_x,5*PD+1)-Px;
ENL(eff_x,5*PD+2)=ENL(eff_x,5*PD+2)-Py;

        
%     elseif ((ENL(i,1)==eff_x)&&rem(i,2)==1)
%         ENL(i,PD+1)=1;
%         ENL(i,PD+2)=1;
% 
%         ENL(i,4*PD+1)=ENL(i,5*PD+1)+Px;
%         ENL(i,4*PD+2)=ENL(i,5*PD+2)+Py;
%         eff_x=eff_x-1;
%     elseif ((ENL(i,1)==eff_x)&&rem(i,2)==0)
%         ENL(i,PD+1)=1;
%         ENL(i,PD+2)=1;
% 
%         ENL(i,4*PD+1)=ENL(i,5*PD+1)+4*Px;
%         ENL(i,4*PD+2)=ENL(i,5*PD+2)+4*Py;
%         eff_x=eff_x-1;
DOFs=0;
DOCs=0;
for i=1:NoN
    for j=1:PD
        if (ENL(i,(PD+j))==-1)
            DOCs = DOCs-1;
            ENL(i,2*PD+j)=DOCs;
        else
            DOFs = DOFs+1;
            ENL(i,2*PD+j)=DOFs;
        end
    end
end

for i = 1:NoN
    for j = 1:PD
        if (ENL(i,(2*PD+j))<0)
            ENL(i,PD*3+j)=DOFs+abs(ENL(i,(2*PD+j)));
        else
            ENL(i,PD*3+j)=ENL(i,2*PD+j);
        end
    end
end

DOCs = abs(DOCs);

end
        


% for i = 1 : NoN
% 
%     if((ENL(i,1)==0)&&(ENL(i,2)==0))
% 
%         ENL(i,3) = -1;
%         ENL(i,4) = -1;
%         ENL(i,9) = 0;
%         ENL(i,10) = 0;
%     
%     elseif((ENL(i,1)==1)&&(ENL(i,2)==0))
%         ENL(i,3)=1;
%         ENL(i,4)=-1;
%         ENL(i,11)=0;
%         ENL(i,10)=0;
% 
%     elseif((ENL(i,1)==0.5)&&(ENL(i,2)==1))
%         ENL(i,3)=1;
%         ENL(i,4)=1;
%         ENL(i,11)=0;
%         ENL(i,12)=-20;
%     end
% end