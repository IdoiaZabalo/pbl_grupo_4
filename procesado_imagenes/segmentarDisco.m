function Disco_corregido = segmentarDisco(ROI_origen)

   %Separar los canales de color
    canal_rojo= ROI_origen(:,:,1);
    canal_verde= ROI_origen(:,:,2);
    canal_azul= ROI_origen(:,:,3);

    %Calcular entropias de cada canal
    entropias_rojo = entropy(canal_rojo);
    entropias_verde = entropy(canal_verde);
    entropias_azul = entropy(canal_azul);

    se = strel('disk', 20);
    % Aplicar la operación de cierre morfológico para eliminar los vasos sanguíneos
    I_vessels_rojo = imclose(canal_rojo, se);
    I_vessels_verde = imclose(canal_verde, se);
    I_vessels_azul = imclose(canal_azul, se);

    % Ajustar el contraste de las imágenes sin venas
    I_sinvenas_rojo=imadjust(I_vessels_rojo); 
    I_sinvenas_verde=imadjust(I_vessels_verde);
    I_sinvenas_azul=imadjust(I_vessels_azul);

     % Ordenar los valores de píxeles de cada canal en orden descendente
    sorted_values_rojo = sort(I_sinvenas_rojo(:), 'descend');
    sorted_values_verde = sort(I_sinvenas_verde(:), 'descend');
    sorted_values_azul = sort(I_sinvenas_azul(:), 'descend');

    % Definir los valores de umbral para cada canal y segmentar un disco
    % inicial
    threshold_index_disc_rojo = round(0.03 * numel(sorted_values_rojo));
    threshold_value_disc_rojo = sorted_values_rojo(threshold_index_disc_rojo);
    I_thresholded_disc_rojo_inicial = I_sinvenas_rojo >= threshold_value_disc_rojo;

    threshold_index_disc_verde = round(0.08* numel(sorted_values_verde));
    threshold_value_disc_verde = sorted_values_verde(threshold_index_disc_verde);
    I_thresholded_disc_verde_inicial = I_sinvenas_verde >= threshold_value_disc_verde;

    threshold_index_disc_azul = round(0.03 * numel(sorted_values_azul));
    threshold_value_disc_azul = sorted_values_azul(threshold_index_disc_azul);
    I_thresholded_disc_azul_inicial = I_sinvenas_azul >= threshold_value_disc_azul;

    Disco_corregido_rojo = cell(1, 4);
    Disco_corregido_verde = cell(1, 4);
    Disco_corregido_azul = cell(1, 4);

    Disco_corregido_rojo{1} = I_thresholded_disc_rojo_inicial;
    Disco_corregido_verde{1} = I_thresholded_disc_verde_inicial;
    Disco_corregido_azul{1} = I_thresholded_disc_azul_inicial;

    % Aplicar el algoritmo de contornos activos para ajustar los discos

    for j = 1:3
        Disco_corregido_rojo{j+1} = activecontour(I_sinvenas_rojo, Disco_corregido_rojo{j});
        Disco_corregido_verde{j+1} = activecontour(I_sinvenas_verde, Disco_corregido_verde{j});
        Disco_corregido_azul{j+1} = activecontour(I_sinvenas_azul, Disco_corregido_azul{j});
    end

    resultado_final_rojo = Disco_corregido_rojo{end};
    resultado_final_verde = Disco_corregido_verde{end};
    resultado_final_azul = Disco_corregido_azul{end};

    % Aplicar condiciones basadas en la entropía para seleccionar el resultado final
   
    if entropias_azul>=4.4

       Disco_corregido_final_azul=resultado_final_azul;

    else 

        Disco_corregido_final_azul= ones(size(canal_azul));

    end 

     if entropias_verde<=6.5

       Disco_corregido_final_verde=resultado_final_verde;

    else 

        Disco_corregido_final_verde= ones(size(canal_verde));

     end

     if entropias_rojo>=7

       Disco_segmentado_final=resultado_final_rojo;

    else 

        Disco_segmentado_final=Disco_corregido_final_azul&resultado_final_rojo&Disco_corregido_final_verde;

    end
  
    % Mantener solo la región conectada más grande

   if any(Disco_segmentado_final(:))
        CC_final = bwconncomp(Disco_segmentado_final);
        numPixels_final = cellfun(@numel, CC_final.PixelIdxList);
        [~, idx_final] = max(numPixels_final);
        Disco_segmentado_final = false(size(Disco_segmentado_final));
        Disco_segmentado_final(CC_final.PixelIdxList{idx_final}) = true;
   end 
     
    se = strel('disk', 20);
    Disco_quitando_alrededor=imerode(Disco_segmentado_final,se);
  
    if any(Disco_quitando_alrededor(:))
        CC_corregido = bwconncomp(Disco_quitando_alrededor);
        numPixels_corregido = cellfun(@numel, CC_corregido.PixelIdxList);
        [~, idx_corregido] = max(numPixels_corregido);
        Disco_quitando_alrededor = false(size(Disco_quitando_alrededor));
        Disco_quitando_alrededor(CC_corregido.PixelIdxList{idx_corregido}) = true;
    end 

    Disco_corregido=imdilate(Disco_quitando_alrededor,se);
end