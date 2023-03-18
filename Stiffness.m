function output = Stiffness(x,GPE)
NPE=size(x,1);
PD = size(x,2);
coor=x';
K=zeros(NPE*PD,NPE*PD);
for i=1:NPE
    for j=1:NPE
        k=zeros(PD,PD);
        for gp = 1:GPE
            J = zeros(PD,PD);
            grad = zeros(PD,NPE);
            [xi,eta,alpha] = GaussPoint(NPE,GPE,gp);
            grad_nat = grad_N_nat(NPE,xi,eta);
            J=coor*grad_nat';
            grad = inv(J)'*grad_nat;
            for a = 1:PD
                for c = 1:PD
                    for b = 1:PD
                        for d=1:PD
                            k(a,c)=k(a,c)+grad(b,i)*constitutive(a,b,c,d)*grad(d,j)*det(J)*alpha*(1/2);
                        end
                    end
                end
            end
            K(((i-1)*PD+1):i*PD,((j-1)*PD+1):j*PD)=k;
        end
    end
    output = K;
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function result = grad_N_nat(NPE,xi,eta)
    PD =2;
    result = zeros(PD,NPE);
    if(NPE==3)
        result(1,1)=1;
        result(1,2)=0;
        result(1,3)=-1;

        result(2,1)=0;
        result(2,2)=1;
        result(2,3)=-1;

%     elseif (NPE==4)
%         result(1,1)=-1/4*(1-eta);
%         result(1,2)=1/4*(1-eta);
%         result(1,3)=1/4*(1+eta);
%         result(1,4)=-1/4*(1+eta);
% 
%         result(2,1)=-1/4*(1-xi);
%         result(2,2)=-1/4*(1+xi);
%         result(2,3)=1/4*(1+xi);
%         result(2,4)=1/4*(1-xi);
    elseif (NPE==6)
        result(1,1)=-3+4*eta+4*xi;
        result(1,2)= 4*xi-1;
        result(1,3)= 0;
        result(1,4)= 4*(1-2*xi-eta);
        result(1,5)= 4*eta;
        result(1,6)=-4*eta;

        result(2,1)=-3+4*eta+4*xi;
        result(2,2)= 0;
        result(2,3)= 4*eta-1;
        result(2,4)=-4*xi;
        result(2,5)= 4*xi;
        result(2,6)= 4*(1-xi-2*eta);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [xi,eta,alpha] = GaussPoint(NPE,GPE,gp)
    if(NPE ==6)
%         if(GPE==1)
%             xi = 0; eta=0; alpha=4;
%         elseif(GPE==4)
%             if(gp==1)
%                 xi=-1/sqrt(3); eta=-1/sqrt(3); alpha=1;
%             elseif(gp==2)
%                 xi=1/sqrt(3); eta=-1/sqrt(3); alpha=1;
%             elseif(gp==3)
%                 xi=1/sqrt(3); eta=1/sqrt(3); alpha=1;
%             elseif(gp==4)
%                 xi=-1/sqrt(3); eta=1/sqrt(3); alpha=1;
%             end
        if(GPE==4)
            if(gp==1)
                xi=-1/sqrt(3); eta=-1/sqrt(3); alpha=3/2;
            elseif(gp==2)
                xi=1/sqrt(3); eta=-1/sqrt(3); alpha=3/2;
            elseif(gp==3)
                xi=1/sqrt(3); eta=1/sqrt(3); alpha=3/2;
            elseif(gp==4)
                xi=-1/sqrt(3); eta=1/sqrt(3); alpha=3/2;
            end
        elseif(GPE==1)
            xi=1/3; eta=1/3; alpha=1;
%             elseif(gp==5)
%                 xi=1/sqrt(3); eta=1/sqrt(3); alpha=1;
%             elseif(gp==6)
%                 xi=-1/sqrt(3); eta=1/sqrt(3); alpha=1;
%             end
        end
    end
    if(NPE==3)
        xi=1/3; eta=1/3; alpha=1;
    end
end

                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function C = constitutive(i,j,k,l)
    E=6900000000000000000000;
    nu=0.3333;

    C = (E/(2*(1+nu)))*(delta(i,l)*delta(j,k)+delta(i,k)*delta(j,l))+((E*nu)/(1-nu^2))*delta(i,j)*delta(k,l);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function delta = delta(i,j)
    if(i==j)
        delta=1;
    else
        delta=0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A = dyad(u,v)
    PD=2;
    A=zeros(PD,PD);
    for i=1:PD
        for j=1:PD
            A(i,j)=u(i)*v(j);
        end
    end
end
