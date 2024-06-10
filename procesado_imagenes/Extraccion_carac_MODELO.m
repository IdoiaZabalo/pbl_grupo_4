
%EN ESTE ARCHIVO SE PROCESA LA EXTRACCIÓN DE CARACTERÍSTICAS AL COMPLETO.
%DADO QUE LA CARACTERÍSTICAS SE SACAN DE CARPETAS DISTINTAS (DISCO/COPA/ROI), ES
%CRUCIAL CAMBIAR EL DIRECTORIO DE MATLAB Y CAMBIAR LA CARPETA A LA QUE SE
%LE ACCEDE "PATH"

Caracteristicas=table; 
% Leer las tablas desde los archivos CSV
tabla1 = readtable('T_revisada_BuenaCalidad.csv')
tabla2 = readtable('SVM_buena_calidad.csv')
tabla1.glaucoma=[];
tabla2.Prediccion=[];
% Fusionar las tablas
tablaFusionada = [tabla1; tabla2];

% Extraer el número de imagen desde el nombre del archivo
% Suponemos que la columna con los nombres de las imágenes se llama 'imagen'
numerosImagen = regexp(tablaFusionada.image, '\d+', 'match');
numerosImagen = cellfun(@(x) str2double(x{1}), numerosImagen);

% Añadir los números de imagen a la tabla fusionada
tablaFusionada.numeroImagen = numerosImagen;

% Ordenar la tabla fusionada por el número de imagen
tablaFusionada = sortrows(tablaFusionada, 'numeroImagen');

% Eliminar la columna con los números de imagen si no la necesitas
tablaFusionada.numeroImagen = [];

% Guardar la tabla fusionada y ordenada en un nuevo archivo CSV si es necesario
writetable(tablaFusionada, 'TablaFusionadaOrdenada.csv');
Nombres=tablaFusionada.image
Caracteristicas=addvars(Caracteristicas,Nombres,'NewVariableNames', {'image'})

entropias_rojo = zeros(height(Caracteristicas), 1);
entropias_verde = zeros(height(Caracteristicas), 1);
entropias_azul = zeros(height(Caracteristicas), 1);

for i = 1:height(Caracteristicas)
    ROI= imread(Caracteristicas.image{i});
    canal_rojo= ROI(:,:,1);
    canal_verde= ROI(:,:,2);
    canal_azul= ROI(:,:,3);

    entropias_rojo(i) = entropy(canal_rojo);
    entropias_verde(i) = entropy(canal_verde);
    entropias_azul(i) = entropy(canal_azul);
end 
Caracteristicas=addvars(Caracteristicas,entropias_rojo,entropias_verde,entropias_azul,'NewVariableNames', {'Entropia_CR','Entropia_CV','Entropia_CA'})
%% 
area_disco = zeros(height(Caracteristicas), 1);
diameter_max=zeros(height(Caracteristicas), 1);
diameter_min=zeros(height(Caracteristicas), 1);
for i = 1:height(Caracteristicas)
    Disco= imread(Caracteristicas.image{i});
    area_disco(i) = bwarea(Disco);
    props = regionprops(Disco, 'MajorAxisLength', 'MinorAxisLength');
    if ~isempty(props)
        % Calcular el diámetro máximo (usando la longitud del eje mayor)
        diameter_max(i) = max([props.MajorAxisLength]);
        
        % Calcular el diámetro mínimo (usando la longitud del eje menor)
        diameter_min(i) = max([props.MinorAxisLength]);
    else
        % Si no se encontraron propiedades, asignar NaN o algún valor predeterminado
        diameter_max(i) = 0;
        diameter_min(i) = 0;
    end
 
end 

Caracteristicas=addvars(Caracteristicas,area_disco,diameter_max,diameter_min,'NewVariableNames', {'Area_Disco','Diametro_Disco_MAX','Diametro_Disco_MIN'})
Caracteristicas.Diametro_Disco_MAX=diameter_max;
Caracteristicas.Diametro_Disco_MIN=diameter_min;
%% 

area_copa = zeros(height(Caracteristicas), 1);
diameter_max=zeros(height(Caracteristicas), 1);
diameter_min=zeros(height(Caracteristicas), 1);
for i = 1:height(Caracteristicas)
    Copa= imread(Caracteristicas.image{i});
    area_copa(i) = bwarea(Copa);
    props = regionprops(Disco, 'MajorAxisLength', 'MinorAxisLength');
    if ~isempty(props)
        % Calcular el diámetro máximo (usando la longitud del eje mayor)
        diameter_max(i) = max([props.MajorAxisLength]);
        
        % Calcular el diámetro mínimo (usando la longitud del eje menor)
        diameter_min(i) = max([props.MinorAxisLength]);
    else
        % Si no se encontraron propiedades, asignar NaN o algún valor predeterminado
        diameter_max(i) = 0;
        diameter_min(i) = 0;
    end
end 
Caracteristicas=addvars(Caracteristicas,area_copa,diameter_max,diameter_min,'NewVariableNames', {'Area_Copa','Diametro_Copa_MAX','Diametro_Copa_MIN'})

C_D_Ratio=zeros(height(Caracteristicas), 1);
Area_disco=Caracteristicas.Area_Disco;
Area_copa=Caracteristicas.Area_Copa;
for i = 1:height(Caracteristicas)
    C_D_Ratio(i)=Area_copa(i)/Area_disco(i);
end

Caracteristicas=addvars(Caracteristicas,C_D_Ratio,'NewVariableNames', {'C/D Ratio'})
%% 
T=readtable("metadata.csv")
[isInT1, idxInT1] = ismember(Caracteristicas.image, T.image);

% Agregar la columna 'Glaucoma' a T2
Caracteristicas.glaucoma = zeros(height(Caracteristicas), 1);  % Inicializar con NaN o algún valor predeterminado
Caracteristicas.glaucoma(isInT1) = T.glaucoma(idxInT1(isInT1));

output_filename = 'Caracteristicas_MODELO.csv';
writetable(Caracteristicas, output_filename);

%% 

Caracteristicas=readtable("Caracteristicas_MODELO.csv")

contrast_red = zeros(height(Caracteristicas), 1);
homogeneity_red = zeros(height(Caracteristicas), 1);
correlation_red = zeros(height(Caracteristicas), 1);
energy_red = zeros(height(Caracteristicas), 1);

contrast_green = zeros(height(Caracteristicas), 1);
homogeneity_green = zeros(height(Caracteristicas), 1);
correlation_green = zeros(height(Caracteristicas), 1);
energy_green = zeros(height(Caracteristicas), 1);

contrast_blue = zeros(height(Caracteristicas), 1);
homogeneity_blue = zeros(height(Caracteristicas), 1);
correlation_blue= zeros(height(Caracteristicas), 1);
energy_blue = zeros(height(Caracteristicas), 1);

for i = 1:height(Caracteristicas)
    ROI= imread(Caracteristicas.image{i});
    canal_rojo= ROI(:,:,1);
    canal_verde= ROI(:,:,2);
    canal_azul= ROI(:,:,3);

    glcm_red = graycomatrix(canal_rojo, 'NumLevels', 256, 'Offset', [0 1], 'Symmetric', true);
    glcm_green = graycomatrix(canal_verde, 'NumLevels', 256, 'Offset', [0 1], 'Symmetric', true);
    glcm_blue = graycomatrix(canal_azul, 'NumLevels', 256, 'Offset', [0 1], 'Symmetric', true);
    
    % Para el canal rojo
    props_red = graycoprops(glcm_red);
    contrast_red(i) = props_red.Contrast;
    homogeneity_red(i) = props_red.Homogeneity;
    correlation_red(i) = props_red.Correlation;
    energy_red(i) = sum(canal_rojo(:).^2);
    
    % Para el canal verde
    props_green = graycoprops(glcm_green);
    contrast_green(i) = props_green.Contrast;
    homogeneity_green(i) = props_green.Homogeneity;
    correlation_green(i) = props_green.Correlation;
    energy_green(i) = sum(canal_verde(:).^2);
    
    % Para el canal azul
    props_blue = graycoprops(glcm_blue);
    contrast_blue(i) = props_blue.Contrast;
    homogeneity_blue(i) = props_blue.Homogeneity;
    correlation_blue(i) = props_blue.Correlation;
    energy_blue(i) = sum(canal_azul(:).^2);
end 

Caracteristicas=addvars(Caracteristicas,contrast_red,homogeneity_red,correlation_red,energy_red,contrast_green,homogeneity_green,correlation_green,energy_green,contrast_blue,homogeneity_blue,correlation_blue,energy_blue,'NewVariableNames', {'contrast_red','homogeneity_red','correlation_red','energy_red','contrast_green','homogeneity_green','correlation_green','energy_green','contrast_blue','homogeneity_blue','correlation_blue','energy_blue'})
%% 

% Inicialización de matrices para almacenar características
mean_wavelet = zeros(height(Caracteristicas), 10); % 10 sub-bandas
variance_wavelet = zeros(height(Caracteristicas), 10);
energy_wavelet = zeros(height(Caracteristicas), 10);

for i = 1:height(Caracteristicas)
    ROI = imread(Caracteristicas.image{i});
    
    % Convertir la imagen a escala de grises
    grayROI = rgb2gray(ROI);
    
    % Realizar la Transformada Wavelet en la imagen
    [cA, cH, cV, cD] = dwt2(grayROI, 'db1'); % Usando 'db1' como ejemplo
    
    % Concatenar las sub-bandas en un solo vector
    wavelet_coeffs = [cA(:); cH(:); cV(:); cD(:)];
    
    % Calcular características de primer orden
    mean_wavelet(i, :) = mean(wavelet_coeffs);
    variance_wavelet(i, :) = var(wavelet_coeffs);
    energy_wavelet(i, :) = sum(wavelet_coeffs.^2);
end 


Caracteristicas = addvars(Caracteristicas, mean_wavelet, variance_wavelet, energy_wavelet, ...
    'NewVariableNames', {'mean_wavelet', 'variance_wavelet', 'energy_wavelet'});

%% 

T=readtable("Caracteristicas_MODELO.csv")
glauco=T.glaucoma;
T.glaucoma=[];
T.glaucoma=glauco; 

writetable(T,'Caracteristicas_MODELO.csv')
