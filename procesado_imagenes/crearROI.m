function cropped_image = crearROI(I_origen)
    I_gray = rgb2gray(I_origen);
    %Binarizar la imagen usando umbral de 0.1
    I_thresholded = imbinarize(I_gray, 0.1);
    se = strel('disk', 40);
    % Aplicar operación de apertura morfológica para eliminar puntos pequeños
    I_sinpunto = imopen(I_thresholded, se);
    % Convertir la imagen de origen a tipo double para realizar operaciones aritméticas
    I_double = im2double(I_origen);
    % Aplicar la máscara binarizada a cada canal de la imagen de color
    I_double(:,:,1) = I_double(:,:,1) .* I_sinpunto;
    I_double(:,:,2) = I_double(:,:,2) .* I_sinpunto;
    I_double(:,:,3) = I_double(:,:,3) .* I_sinpunto;

    se = strel('disk', 90);
    % Aplicar la erosión morfológica para reducir el tamaño de las áreas binarizadas
    I_encogido = imerode(I_sinpunto, se);
    % Aplicar la máscara erosionada a cada canal de la imagen de color
    I_double(:,:,1) = I_double(:,:,1) .* I_encogido;
    I_double(:,:,2) = I_double(:,:,2) .* I_encogido;
    I_double(:,:,3) = I_double(:,:,3) .* I_encogido;

    I_gray_2 = rgb2gray(I_double);
    % Aplicar un filtro gaussiano para suavizar la imagen (sigma = 2)
    I_gaussian = imgaussfilt(I_gray_2, 2); % Sigma = 2 para suavizar
     % Mejorar el contraste de la imagen utilizando ecualización adaptativa de histograma
    I_iluminadomejor = adapthisteq(I_gaussian);
    % Encontrar el índice del píxel con el valor máximo en la imagen mejorada
    [~, max_index] = max(I_iluminadomejor(:));
    [max_row, max_col] = ind2sub(size(I_iluminadomejor), max_index);
    %Tamaño del cuadrado de recorte
    square_size = 1300;

    % Calcular las coordenadas del cuadrado de recorte
    row_start = max(1, max_row - square_size / 2);
    row_end = min(size(I_iluminadomejor, 1), max_row + square_size / 2 - 1);
    col_start = max(1, max_col - square_size / 2);
    col_end = min(size(I_iluminadomejor, 2), max_col + square_size / 2 - 1);

    % Recortar la imagen
    cropped_image = I_origen(row_start:row_end, col_start:col_end, :);
end