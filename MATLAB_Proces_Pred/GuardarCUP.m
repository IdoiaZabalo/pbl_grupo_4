%SEGMENTACIÓN DE LOS ROI
close all; 
clear all;
T_ROI=readtable('SVM_buena_calidad.csv')

% directorio_origen = 'C:\Users\zabal\OneDrive - Mondragon Unibertsitatea\Escritorio\BIO6\PBL6\MATLAB_Proces_Pred\ROI';
% Carpeta de destino para guardar las imágenes de buena calidad
carpeta_destino = 'C:\Users\zabal\OneDrive - Mondragon Unibertsitatea\Escritorio\BIO6\PBL6\MATLAB_Proces_Pred\SEGMENTACION_CUP_COMPLETA';

nombres_cup = cell(height(T_ROI), 1);
parfor i = 1:height(T_ROI)

    %SEGMENTACIÓN DEL CUP

     nombre_imagen = T_ROI.image{i};

    ROI_origen= imread(T_ROI.image{i});

    canal_rojo= ROI_origen(:,:,1);
    canal_verde= ROI_origen(:,:,2);
    canal_azul= ROI_origen(:,:,3);

    entropias_rojo(i) = entropy(canal_rojo);
    entropias_verde(i) = entropy(canal_verde);
    entropias_azul(i) = entropy(canal_azul);

    se = strel('disk', 20);
    I_vessels_rojo = imclose(canal_rojo, se);
    I_vessels_verde = imclose(canal_verde, se);
    I_vessels_azul = imclose(canal_azul, se);

    I_sinvenas_rojo=imadjust(I_vessels_rojo); 
    I_sinvenas_verde=imadjust(I_vessels_verde);
    I_sinvenas_azul=imadjust(I_vessels_azul);


    sorted_values_rojo = sort(I_sinvenas_rojo(:), 'descend');
    sorted_values_verde = sort(I_sinvenas_verde(:), 'descend');
    sorted_values_azul = sort(I_sinvenas_azul(:), 'descend');

    % Aplicar umbral para seleccionar el % de los píxeles de máxima calidad
    threshold_index_cup_rojo = round(0.01 * numel(sorted_values_rojo));
    threshold_value_cup_rojo = sorted_values_rojo(threshold_index_cup_rojo);
    I_thresholded_cup_rojo_inicial = I_sinvenas_rojo >= threshold_value_cup_rojo;

    threshold_index_cup_verde = round(0.03* numel(sorted_values_verde));
    threshold_value_cup_verde = sorted_values_verde(threshold_index_cup_verde);
    I_thresholded_cup_verde_inicial = I_sinvenas_verde >= threshold_value_cup_verde;

    threshold_index_cup_azul = round(0.01 * numel(sorted_values_azul));
    threshold_value_cup_azul = sorted_values_azul(threshold_index_cup_azul);
    I_thresholded_cup_azul_inicial = I_sinvenas_azul >= threshold_value_cup_azul;

    
    if entropias_azul (i)>=4.4 

       Cup_corregido_final_azul=I_thresholded_cup_azul_inicial;

    else 

        Cup_corregido_final_azul= ones(size(canal_azul));

    end 

    Cup_segmentado_final=I_thresholded_cup_azul_inicial&I_thresholded_cup_verde_inicial;

    if any(Cup_segmentado_final(:))
        % Encuentra y selecciona el contorno con más píxeles
        CC_Cup_final = bwconncomp(Cup_segmentado_final);
        numPixels_final = cellfun(@numel, CC_Cup_final.PixelIdxList);
        [~, idx_final_cup] = max(numPixels_final);
        Cup_segmentado_final = false(size(Cup_segmentado_final));
        Cup_segmentado_final(CC_Cup_final.PixelIdxList{idx_final_cup}) = true;
    end

    nombre_imagen_2 = sprintf('%s', nombre_imagen); % Crear nombre con índice
    nombres_cup{i}=nombre_imagen_2;
    nombre_completo_2 = fullfile(carpeta_destino, nombre_imagen_2);
    imwrite(Cup_segmentado_final, nombre_completo_2);
    
end

