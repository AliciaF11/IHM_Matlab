%on définit la fonction
function [x,y,bruit,yb]=simulationfi(N,sigma,class,a,b,AFF,REG)

%Affichage de la régression linéaire
%vecteur x[début:pas:fin]
x=[0:1:N-1];

% fonction affine qui représente l'équation linéaire
y=a*x+b;
%on affiche le graphique x en fonction de y pour la régression linéaire

if AFF 
figure(1)
subplot(2,2,1);
plot(x,y,'+b-')
%titre
title(['Régression linéaire Y = ', num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Y = ', num2str(a),'X+',num2str(b)])
%fin de l'affichage de la régression linéaire
end
%----------------------------------------------------------------
%Affichage du bruit gaussien
bruit=sigma*randn(1,N);
if AFF
subplot(2,2,2)
% on trace le graphique de la gaussienne 
plot(bruit)
% titre
title('Graphique du bruit gaussien')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Amplitude')
end
%----------------------------------------------------------------
%Affichage de l'histogramme
if AFF
subplot(2,2,3)
%on trace l'histogramme de la gaussienne

% utilisation du histfit à condition d'avoir "statistics and Machine Learning Toolbox" 
histfit(bruit,class)
%titre
title('Histogramme gaussien')
%légendes
xlabel(['Découpage en classe = ',int2str(class)])
ylabel('Amplitude')
end
%------------------------------------------------------
%Affichage signal bruité 
yb= y+bruit;
if AFF
subplot(2,2,4)
plot(x,yb,'.r')
%titre
title(['Graphique du signal bruité avec Y = ',num2str(a),'X+',num2str(b)])
%légendes
xlabel(['Nombre de points N = ',int2str(N)])
ylabel(['Fonction Y = ', num2str(a),'X+',num2str(b)])

end

if REG
    save resultat.mat x y yb bruit
end
