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
writetable(tablaFusionada, 'tablaFusionadaOrdenada.csv');
tablaFusionada