function Cup_segmentado_final = segmentarCopa(ROI_origen)

    % Separar los canales de color
    canal_rojo = ROI_origen(:,:,1);
    canal_verde = ROI_origen(:,:,2);
    canal_azul = ROI_origen(:,:,3);
    % Calcular la entropía de cada canal
    entropias_rojo = entropy(canal_rojo);
    entropias_verde = entropy(canal_verde);
    entropias_azul = entropy(canal_azul);

    se = strel('disk', 20);
    % Aplicar la operación de cierre morfológico para eliminar los vasos sanguíneos
    I_vessels_rojo = imclose(canal_rojo, se);
    I_vessels_verde = imclose(canal_verde, se);
    I_vessels_azul = imclose(canal_azul, se);
    % Ajustar el contraste
    I_sinvenas_rojo = imadjust(I_vessels_rojo); 
    I_sinvenas_verde = imadjust(I_vessels_verde);
    I_sinvenas_azul = imadjust(I_vessels_azul);

    % Ordenar los valores de píxeles de cada canal en orden descendente
    sorted_values_rojo = sort(I_sinvenas_rojo(:), 'descend');
    sorted_values_verde = sort(I_sinvenas_verde(:), 'descend');
    sorted_values_azul = sort(I_sinvenas_azul(:), 'descend');

    % Definir los valores de umbral para cada canal y hacer una
    % segmentación inicial
    threshold_index_cup_rojo = round(0.01 * numel(sorted_values_rojo));
    threshold_value_cup_rojo = sorted_values_rojo(threshold_index_cup_rojo);
    I_thresholded_cup_rojo_inicial = I_sinvenas_rojo >= threshold_value_cup_rojo;

    threshold_index_cup_verde = round(0.03 * numel(sorted_values_verde));
    threshold_value_cup_verde = sorted_values_verde(threshold_index_cup_verde);
    I_thresholded_cup_verde_inicial = I_sinvenas_verde >= threshold_value_cup_verde;

    threshold_index_cup_azul = round(0.01 * numel(sorted_values_azul));
    threshold_value_cup_azul = sorted_values_azul(threshold_index_cup_azul);
    I_thresholded_cup_azul_inicial = I_sinvenas_azul >= threshold_value_cup_azul;

    % Aplicar condiciones basadas en la entropía para seleccionar el resultado final
    if entropias_azul >= 4.4 
        Cup_corregido_final_azul = I_thresholded_cup_azul_inicial;
    else 
        Cup_corregido_final_azul = ones(size(canal_azul));
    end 
    % Combinar los resultados de los canales azul y verde
    Cup_segmentado_final = I_thresholded_cup_azul_inicial & I_thresholded_cup_verde_inicial;
    
    % Mantener solo la región conectada más grande
    if any(Cup_segmentado_final(:))
        % Encuentra y selecciona el contorno con más píxeles
        CC_Cup_final = bwconncomp(Cup_segmentado_final);
        numPixels_final = cellfun(@numel, CC_Cup_final.PixelIdxList);
        [~, idx_final_cup] = max(numPixels_final);
        Cup_segmentado_final = false(size(Cup_segmentado_final));
        Cup_segmentado_final(CC_Cup_final.PixelIdxList{idx_final_cup}) = true;
    end
end