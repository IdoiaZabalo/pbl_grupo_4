%T=imread('C:\pbl_grupo_4\INTERFAZ\imagenes_pbl\image_0009.jpg')

 T=readtable('T_revisadaCaracteristicas.csv');
 T.image=[];
 T.quality = cellstr(num2str(T.quality));
 
 % Convert the values in the 'Quality' column
 for i = 1:height(T)
     if T.quality{i} == '1'
         T.quality{i} = 'Bajo contraste';
     elseif T.quality{i} == '2'
         T.quality{i} = 'Desenfoque';
    
     elseif T.quality{i} == '3'
         T.quality{i} = 'Ruido';
   
     elseif T.quality{i} == '4'
         T.quality{i} = 'Buena calidad';
     end
 end
 %ENTRENAMIENTO
 p = 0.2;
 cv_out = cvpartition(T.quality, 'HoldOut', p, 'Stratify', true);
 T_train = T(cv_out.training, :);
 T_test  = T(cv_out.test, :);
 mdl_final = fitcecoc(T_train, 'quality');
 
 %MODELO TEST
 T_cargada_carac=table; 
 Imagen_cargada=app.ImageData;
     I = imread(Imagen_cargada);
     entropia = entropy((I));
     I = double(rgb2gray(I));
     Laplaziarra=[0 1 0; 1 -4 1; 0 1 0]; 
     L = imfilter(double(I),Laplaziarra, 'conv'); 
     contraste = std2(I);  
     laplace_med=mean(abs(L(:)));
 
 T_cargada_carac=addvars(T_cargada_carac,contraste, entropia, laplace_med,'NewVariableNames', {'Contraste', 'Entropia','Laplace_media'})
 rng(4);
 %T_cargada_carac.quality=[];

 Y_pred_1 = predict(mdl_final, T_cargada_carac)
