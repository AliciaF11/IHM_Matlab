%code pente+signal bruité
function [x,y]=fusion(N,a,b,sigma)

%vecteur x[début:pas:fin]
x=[0:1:N-1];

% fonction affine qui représente l'équation linéaire
y=a*x+b;

bruit=sigma*randn(1,N);

%on somme la pente de la fonction linéaire avec le bruit de la gaussienne
yb= y+bruit;
%on représente cette somme sous forme de graphique 
plot(x,yb,'+b')
%titre
title(['Graphique du signal bruité avec Y = ',num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['fonction Y =', num2str(a),'X+',num2str(b),' avec le bruit gaussien'])
end
