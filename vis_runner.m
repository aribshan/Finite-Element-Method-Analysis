clc;
clear all;
clf;

d1=1;
d2=2;
p=5;
m=3;
i=4;
element_type='T';

[NL,EL]=disc(i,d1,d2,p,m,element_type);

NoN = size(NL,1);
NoE = size(EL,1);
NPE = size(EL,2);

for i=1:NoE
    hold on;
    plot([NL(EL(i,1),1),NL(EL(i,2),1)],[NL(EL(i,1),2),NL(EL(i,2),2)]);
    plot([NL(EL(i,2),1),NL(EL(i,3),1)],[NL(EL(i,2),2),NL(EL(i,3),2)]);
    plot([NL(EL(i,3),1),NL(EL(i,4),1)],[NL(EL(i,3),2),NL(EL(i,4),2)]);
    plot([NL(EL(i,4),1),NL(EL(i,5),1)],[NL(EL(i,4),2),NL(EL(i,5),2)]);
    plot([NL(EL(i,5),1),NL(EL(i,6),1)],[NL(EL(i,5),2),NL(EL(i,6),2)]);
    plot([NL(EL(i,6),1),NL(EL(i,1),1)],[NL(EL(i,6),2),NL(EL(i,1),2)]);
    x = (NL(EL(i,1),1)+NL(EL(i,2),1)+NL(EL(i,3),1)+NL(EL(i,4),1)+NL(EL(i,5),1)+NL(EL(i,6),1))/6;
    y = (NL(EL(i,1),2)+NL(EL(i,2),2)+NL(EL(i,3),2)+NL(EL(i,4),2)+NL(EL(i,5),2)+NL(EL(i,6),2))/6;
    %plot(x,y,'.','markersize',8,'MarkerFaceColor','b');
    text(x,y,num2str(i));
end
for i=1:NoN
    hold on;
    plot(NL(i,1),NL(i,2),'o','markersize',6,'markeredgecolor','k');
end
