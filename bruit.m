%on définit la fonction
function bruit(N,sigma,class)

bruit=sigma*randn(1,N);

% figure(1)
% représentation tempo
% plot(gaussienne)
% 
% figure(2)
% on trace l'histogramme
% hist(gaussienne,class)
% titre
% title ('Histogramme de la gaussienne')
%déclaration de notre fonction


figure(1)

%on découpe la fenêtre en deux lignes, une colonne en pointant l'indice 1
subplot(2,1,1)
%on trace le graphique de la gaussienne 
plot(bruit)
%titre
title('Graphique du bruit gaussien')
xlabel(['Nombre de points N = ',int2str(N)])
ylabel('Amplitude')

%on découpe la fenêtre en deux lignes, une colonne en pointant l'indice 2
subplot(2,1,2)
%on trace l'histogramme de la gaussienne
histfit(bruit,class)
%titre
title('Histogramme gaussien')
%légendes
xlabel(['Découpage en classe = ',int2str(class)])
ylabel('Amplitude')
end
