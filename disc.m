function [NL,EL] = disc(i, d1, d2, p, m, element_type)

PD = 2;


x = 1 + 3*i;
eff_x = x+x-1;
y = i+1;
eff_y = y+y-1;
NoN = ((x+(x-1))*(y+(y-1)) - (((2*i)*(2*i+1))/2));
%NoE = 2*((x*(y-1)+y*(x-1)+(x-1)*(y-1)) - (2*((i*(i+1))/2)+((1*(i-1)+(1*(i-1)+1))/2)))+1;
NoE = 4*i*i + i*i;
NPE = 6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NL = zeros(NoN,PD);

w_nodes = 12/(eff_x-1);
h_nodes = 2/(eff_y-1);

cnt=1;

for a=1:eff_y
    for b=1:eff_x
        NL(cnt,1)=(b-1)*w_nodes;
        NL(cnt,2)=(a-1)*h_nodes;
        cnt=cnt+1;
    end
    eff_x=eff_x-1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eff_x = x+x-1;
cnt=1;
cnt_new=1;
EL = zeros(NoE,NPE);
x_var = x;
max_x = x+x-1;
for i=1:y-1
    for j=1:eff_x-2
        if j==1
            EL(cnt,1)=((max_x)*(max_x+1)/2-(max_x-2*(i-1))*(max_x-2*(i-1)+1)/2)+j;
            EL(cnt,2)=EL(cnt,1)+1;
            EL(cnt,3)=EL(cnt,1)+2;
            EL(cnt,4)=EL(cnt,1)+eff_x+1;
            EL(cnt,5)=EL(cnt,1)+2*eff_x-1;
            EL(cnt,6)=EL(cnt,1)+eff_x;
        elseif (rem(cnt,2)==0&&rem(i,2)==1)||(rem(cnt,2)==1&&rem(i,2)==0)
            EL(cnt,1)=EL(cnt-1,3);
            EL(cnt,2)=EL(cnt-1,4)+1;
            EL(cnt,3)=EL(cnt-1,5)+2;
            EL(cnt,4)=EL(cnt-1,5)+1;
            EL(cnt,5)=EL(cnt-1,5);
            EL(cnt,6)=EL(cnt-1,4);
        elseif (rem(cnt,2)==1&&rem(i,2)==1)||(rem(cnt,2)==0&&rem(i,2)==0)
            EL(cnt,1)=EL(cnt-1,1);
            EL(cnt,2)=EL(cnt-1,1)+1;
            EL(cnt,3)=EL(cnt-1,1)+2;
            EL(cnt,4)=EL(cnt-1,2)+1;
            EL(cnt,5)=EL(cnt-1,3);
            EL(cnt,6)=EL(cnt-1,2);
        end
        cnt=cnt+1;
    end
    eff_x=eff_x-2;
    x_var=x_var-1;
end



