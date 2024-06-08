function cropped_image = crearROI(I_origen)
    I_gray = rgb2gray(I_origen);
    I_thresholded = imbinarize(I_gray, 0.1);
    se = strel('disk', 40);
    I_sinpunto = imopen(I_thresholded, se);
    I_double = im2double(I_origen);

    I_double(:,:,1) = I_double(:,:,1) .* I_sinpunto;
    I_double(:,:,2) = I_double(:,:,2) .* I_sinpunto;
    I_double(:,:,3) = I_double(:,:,3) .* I_sinpunto;

    se = strel('disk', 90);
    I_encogido = imerode(I_sinpunto, se);

    I_double(:,:,1) = I_double(:,:,1) .* I_encogido;
    I_double(:,:,2) = I_double(:,:,2) .* I_encogido;
    I_double(:,:,3) = I_double(:,:,3) .* I_encogido;

    I_gray_2 = rgb2gray(I_double);
    I_gaussian = imgaussfilt(I_gray_2, 2); % Sigma = 2 para suavizar
    I_iluminadomejor = adapthisteq(I_gaussian);

    [~, max_index] = max(I_iluminadomejor(:));
    [max_row, max_col] = ind2sub(size(I_iluminadomejor), max_index);
    square_size = 1300;

    % Calcular las coordenadas del cuadrado de recorte
    row_start = max(1, max_row - square_size / 2);
    row_end = min(size(I_iluminadomejor, 1), max_row + square_size / 2 - 1);
    col_start = max(1, max_col - square_size / 2);
    col_end = min(size(I_iluminadomejor, 2), max_col + square_size / 2 - 1);

    % Recortar la imagen
    cropped_image = I_origen(row_start:row_end, col_start:col_end, :);
end