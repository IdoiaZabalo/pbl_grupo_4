function Glaucoma = Modelo_glaucoma(Tabla)

T=readtable('Caracteristicas_BALANCED_MODELO_LIMPIO.csv');
T.image=[];
T.glaucoma = cellstr(num2str(T.glaucoma));

for i = 1:height(T)
    if T.glaucoma{i} == '1'
        T.glaucoma{i} = 'Glaucoma';
    elseif T.glaucoma{i} == '0'
        T.glaucoma{i} = 'No glaucoma';
    end
end
% División de data
p = 0.2;
cv_out = cvpartition(T.glaucoma, 'HoldOut', p, 'Stratify', true);
T_train = T(cv_out.training, :);


indices_eliminados = readmatrix('indices_eliminados.csv');
T_original = readtable("Caracteristicas_MODELO_actualizado.csv");

% Recuperar las imágenes eliminadas de "No glaucoma"
imagenes_recuperadas = T_original(indices_eliminados, :);

% Convertir la columna glaucoma a numérico si es necesario

imagenes_recuperadas.glaucoma = cellstr(num2str(imagenes_recuperadas.glaucoma));

 for i = 1:height(imagenes_recuperadas)
    if imagenes_recuperadas.glaucoma{i} == '1'
        imagenes_recuperadas.glaucoma{i} = 'Glaucoma';
    elseif imagenes_recuperadas.glaucoma{i} == '0'
        imagenes_recuperadas.glaucoma{i} = 'No glaucoma';
    end
end

% Combinar las imágenes recuperadas con los datos balanceados
rng(4);
imagenes_recuperadas.image=[];
imagenes_recuperadas.mean_wavelet_1=[];imagenes_recuperadas.mean_wavelet_2=[];imagenes_recuperadas.mean_wavelet_3=[];imagenes_recuperadas.mean_wavelet_4=[];imagenes_recuperadas.mean_wavelet_5=[];imagenes_recuperadas.mean_wavelet_6=[];imagenes_recuperadas.mean_wavelet_7=[];imagenes_recuperadas.mean_wavelet_8=[];imagenes_recuperadas.mean_wavelet_9=[];imagenes_recuperadas.mean_wavelet_10=[];
imagenes_recuperadas.variance_wavelet_1=[];imagenes_recuperadas.variance_wavelet_2=[];imagenes_recuperadas.variance_wavelet_3=[];imagenes_recuperadas.variance_wavelet_4=[];imagenes_recuperadas.variance_wavelet_5=[];imagenes_recuperadas.variance_wavelet_6=[];imagenes_recuperadas.variance_wavelet_7=[];imagenes_recuperadas.variance_wavelet_8=[];imagenes_recuperadas.variance_wavelet_9=[];imagenes_recuperadas.variance_wavelet_10=[];
imagenes_recuperadas.energy_wavelet_1=[];imagenes_recuperadas.energy_wavelet_2=[];imagenes_recuperadas.energy_wavelet_3=[];imagenes_recuperadas.energy_wavelet_4=[];imagenes_recuperadas.energy_wavelet_5=[];imagenes_recuperadas.energy_wavelet_6=[];imagenes_recuperadas.energy_wavelet_7=[];imagenes_recuperadas.energy_wavelet_8=[];imagenes_recuperadas.energy_wavelet_9=[];imagenes_recuperadas.energy_wavelet_10=[];

p = 0.2;
cv_out = cvpartition(imagenes_recuperadas.glaucoma, 'HoldOut', p, 'Stratify', true);
T_train_recuperada = imagenes_recuperadas(cv_out.training, :);

updated_data_train = [T_train; T_train_recuperada];


% Test final con el mejor modelo
mdl_final_knn = fitcknn(updated_data_train, 'glaucoma');
Glaucoma = predict(mdl_final_knn, Tabla);
end 
