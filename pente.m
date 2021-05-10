%déclaration de notre fonction
function [x,y]=pente(N,a,b)

%vecteur x[début:pas:fin]
x=[0:1:N-1];

% fonction affine qui représente l'équation linéaire
y=a*x+b;

%on affiche le graphique x en fonction de y
plot(x,y,'+b-')
%titre
title(['Régression linéaire Y = ', num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Y = ', num2str(a),'X+',num2str(b)])
end
%fin du script
