%fonction extraction
function [b0,b1,s0,s1,R2,Sr]=extrafi(x,yb,AFF)
% AFF=1
%Entrée:x,yb
%Sortie: b0,b1,s0,s1,R2,sigmaest

% %Importation
% load('resultat.mat');

%graphique
if AFF
% figure(1)
plot(x,yb,'.r')
%titre et légendes
title('Sortie du système linéaire bruité')
xlabel('Nombre de points')
ylabel('Quantité de bruit')
end
%U
U=[ones(length(x),1) x'];
%Transposée de U 
U_t= U';
%Matrice A
A=U_t*U;
%Vecteur C
C=U_t*yb';
%Vecteur B
B=inv(A)*C;

b0=B(1,1)%ordonnée à l'origine
b1=B(2,1)%coeff pente

% Nouveau Y
yREG=b0+b1*x;%régression linéaire avec la pente b1 et b0 l'ordonné à l'origine 
%figure(1)

if AFF
hold on 
plot(x,yREG,'-b')
%title+légendes
hold off
end

%Estimation du sigma
bruitm=yb-yREG; %bruit de mesure
Sr=std(yb-yREG) %ecart-type résiduel

%Matrice de variance
Vr=Sr^2;

%Matrice de Covariance
V=Vr*inv(A);

%écart-type
s0=sqrt(V(1,1))
s1=sqrt(V(2,2))

%Analyse de la variance
ymoy=mean(yb);

%somme expliquée des carrés des écarts
SSe=sum((yREG-ymoy).^2);

%somme totale des carrés des écarts
SSt=sum((yb-ymoy).^2);

%coeff de détermination
R2=SSe/SSt
end
