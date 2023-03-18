clc;
clear all;
clf;
i = 2;  %times we subdivide the mesh
d1 = 1;
d2 = 2;
p = 5;
m = 3;
element_type = 'T';

[NL,EL] = disc(i,d1,d2,p,m,element_type);

NoN = size(NL,1);
NoE = size(EL,1);
NPE = size(EL,2);
BC_type = 'Fixed&distributed load';
[ENL,DOFs,DOCs ] = assign_BCs(i,NL,BC_type);
K=assemble_stiffness(ENL,EL,NL);
Fp = assemble_forces(ENL,NL);
Up = assemble_displacements(ENL,NL);
Kpu = K(1:DOFs,1:DOFs);
Kpp = K(1:DOFs,DOFs+1:DOFs+DOCs);
Kuu = K(DOFs+1:DOCs+DOFs,1:DOFs);
Kup = K(DOFs+1:DOCs+DOFs,DOFs+1:DOCs+DOFs);
A = det(K);
B = det(Kpu);
D=inv(Kpu);
F = Fp-Kpp*Up;
Uu = D*F;
Fu = Kuu*Uu + Kup*Up;
ENL = update_nodes(ENL,Uu,NL,Fu);

post_process(NL,EL,ENL);