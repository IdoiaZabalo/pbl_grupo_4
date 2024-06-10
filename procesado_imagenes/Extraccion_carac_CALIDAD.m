T=readtable('metadata.csv')
% 
% Preprocesamiento- Separación entrenamiento/validación
T_no_revisada=table(T.image(T.quality==0), T.quality(T.quality==0), 'VariableNames', {'image', 'quality'})
T_revisada=table(T.image(T.quality~=0),T.quality(T.quality~=0) , 'VariableNames', {'image', 'quality'})

[M N]=size(T_revisada)
contraste=zeros(M,1);
entropia=zeros(M,1);
MSE=zeros(M,1);
sobel_max=zeros(M,1);
sobel_med=zeros(M,1);
sobel_std=zeros(M,1);
laplace_max=zeros(M,1);
laplace_med=zeros(M,1);
laplace_std=zeros(M,1);
rango_dinamico=zeros(M, 1);
varianza=zeros(M,1); 
min_intensity=zeros(M,1); 
max_intensity=zeros(M,1);
filtro_sobel_y = [-1 0 1; -2 0 2; -1 0 1];
filtro_sobel_x = [-1 -2 -1; 0 0 0; 1 2 1];

for i = 1:M
    I = imread(T_revisada.image{i});
    %if size(img, 3) == 3
    entropia(i) = entropy((I));
    I = double(rgb2gray(I));
   % end
    % Extraer características de imagenes
     
    
    Gx = imfilter(double(I), filtro_sobel_x, 'conv');
    Gy = imfilter(double(I), filtro_sobel_y, 'conv');
    G = Gx + Gy;
    absG = abs(Gx) + abs(Gy);

    Laplaziarra=[0 1 0; 1 -4 1; 0 1 0]; 
    L = imfilter(double(I),Laplaziarra, 'conv'); 
    % 
    img_filtrada = medfilt2(double(I));
    MSE(i) = immse(I, img_filtrada);

    varianza(i) = var(I(:));
   
    contraste(i) = std2(I);  

    min_intensity(i)=min(I(:));
    max_intensity(i)=max(I(:));
    
    sobel_max(i) = max(abs(absG(:))); 
    sobel_med(i) = mean(abs(absG(:))); 
    sobel_std(i) = std(abs(absG(:))); 
    laplace_max(i)=max(abs(L(:)));
    laplace_med(i)=mean(abs(L(:)));
    laplace_std(i)=std(abs(L(:)));

end
T_revisada=addvars(T_revisada,MSE,varianza,contraste,min_intensity,max_intensity, entropia,sobel_max, laplace_med,sobel_med,sobel_std,laplace_max,laplace_std,'NewVariableNames', {'MSE','varianza','contraste','min_intensity','max_intensity',' entropia','sobel_max', 'laplace_med','sobel_med','sobel_std','laplace_max','laplace_std'})
variables = T_revisada.Properties.VariableNames;
writetable(T_revisada,'T_revisadaENTERACaracteristicas.csv')

% X = T_revisada{:, 2:end};
% R = corrcoef(X, 'Rows', 'pairwise'); % pairwise to ignore NaN values
% 
% figure;
% imagesc(R); clim([-1 1]);
% xticks(1:30);
% xticklabels(variables(:,2:end));
% yticks(1:30);
% yticklabels(variables(:,2:end));
% colormap(jet); colorbar;
%% TRAS COMPROBAR LA CORRELACIÓN CON LAS CARACTERÍSTICAS ELEGIDAS INICIALMENTE, 
% SE HA LLEVADO A CABO UNA ELECCIÓN DE CARACTERÍSTICAS RELEVANTES, SIN REDUNDANCIA
[M N]=size(T_revisada)
contraste=zeros(M,1);
entropia=zeros(M,1);
laplace_med=zeros(M,1);

for i = 1:M
    I = imread(T_revisada.image{i});
    %if size(img, 3) == 3
    entropia(i) = entropy((I));
    I = double(rgb2gray(I));
   % end

    % Extraer características de imagenes
    
    Laplaziarra=[0 1 0; 1 -4 1; 0 1 0]; 
    L = imfilter(double(I),Laplaziarra, 'conv'); 
    contraste(i) = std2(I);  
    laplace_med(i)=mean(abs(L(:)));
  
end
T_revisada=addvars(T_revisada,contraste, entropia, laplace_med,'NewVariableNames', {'Contraste', 'Entropia','Laplace_media'})
variables = T_revisada.Properties.VariableNames;
% writetable(T_revisada,'T_revisadaCaracteristicas.csv')
