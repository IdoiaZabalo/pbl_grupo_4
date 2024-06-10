function Caracteristicas = Carac_Glaucoma(ROI,Disco,Copa)

    canal_rojo= ROI(:,:,1);
    canal_verde= ROI(:,:,2);
    canal_azul= ROI(:,:,3);

    entropias_rojo = entropy(canal_rojo);
    entropias_verde = entropy(canal_verde);
    entropias_azul = entropy(canal_azul);

    glcm_red = graycomatrix(canal_rojo, 'NumLevels', 256, 'Offset', [0 1], 'Symmetric', true);
    glcm_green = graycomatrix(canal_verde, 'NumLevels', 256, 'Offset', [0 1], 'Symmetric', true);
    glcm_blue = graycomatrix(canal_azul, 'NumLevels', 256, 'Offset', [0 1], 'Symmetric', true);
    
    % Para el canal rojo
    props_red = graycoprops(glcm_red);
    contrast_red= props_red.Contrast;
    homogeneity_red = props_red.Homogeneity;
    correlation_red = props_red.Correlation;
    energy_red = sum(canal_rojo(:).^2);
    
    % Para el canal verde
    props_green = graycoprops(glcm_green);
    contrast_green = props_green.Contrast;
    homogeneity_green = props_green.Homogeneity;
    correlation_green = props_green.Correlation;
    energy_green = sum(canal_verde(:).^2);
    
    % Para el canal azul
    props_blue = graycoprops(glcm_blue);
    contrast_blue= props_blue.Contrast;
    homogeneity_blue = props_blue.Homogeneity;
    correlation_blue = props_blue.Correlation;
    energy_blue= sum(canal_azul(:).^2);

    %Caracteristicas del disco
    
    area_disco = bwarea(Disco);
    props = regionprops(Disco, 'MajorAxisLength', 'MinorAxisLength');
    if ~isempty(props)
        % Calcular el diámetro máximo (usando la longitud del eje mayor)
        diameter_max_disco = max([props.MajorAxisLength]);
        
        % Calcular el diámetro mínimo (usando la longitud del eje menor)
        diameter_min_disco = max([props.MinorAxisLength]);
    else
        % Si no se encontraron propiedades, asignar NaN o algún valor predeterminado
        diameter_max_disco = 0;
        diameter_min_disco= 0;
    end

    %Caracteristicas de la copa
           
    area_copa = bwarea(Copa);
    props = regionprops(Copa, 'MajorAxisLength', 'MinorAxisLength');
    if ~isempty(props)
        % Calcular el diámetro máximo (usando la longitud del eje mayor)
        diameter_max_copa= max([props.MajorAxisLength]);
        
        % Calcular el diámetro mínimo (usando la longitud del eje menor)
        diameter_min_copa= max([props.MinorAxisLength]);
    else
        % Si no se encontraron propiedades, asignar NaN o algún valor predeterminado
        diameter_max_copa= 0;
        diameter_min_copa= 0;
    end
    
    %Relacion de las dos areas
    C_D_Ratio=area_copa/area_disco;

    Caracteristicas=table; 
    Caracteristicas=addvars(Caracteristicas,entropias_rojo,entropias_verde,entropias_azul,area_copa,diameter_max_copa,diameter_min_copa,area_disco,diameter_max_disco,diameter_min_disco,C_D_Ratio,contrast_red,homogeneity_red,correlation_red,energy_red,contrast_green,homogeneity_green,correlation_green,energy_green,contrast_blue,homogeneity_blue,correlation_blue,energy_blue,'NewVariableNames', {'Entropia_CR','Entropia_CV','Entropia_CA','Area_Copa','Diametro_Copa_MAX','Diametro_Copa_MIN','Area_Disco','Diametro_Disco_MAX','Diametro_Disco_MIN','C_DRatio','contrast_red','homogeneity_red','correlation_red','energy_red','contrast_green','homogeneity_green','correlation_green','energy_green','contrast_blue','homogeneity_blue','correlation_blue','energy_blue'})

end