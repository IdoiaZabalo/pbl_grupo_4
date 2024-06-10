function CalidadPred = Calidad(tabla)

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
    rng(4);
    p = 0.2;
    cv_out = cvpartition(T.quality, 'HoldOut', p, 'Stratify', true);
    T_train = T(cv_out.training, :);
    mdl_final = fitcecoc(T_train, 'quality');

   
    CalidadPred = predict(mdl_final, tabla);
end