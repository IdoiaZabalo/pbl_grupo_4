function Relevantes = Carac_relevantes(~)

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

% Test final con el mejor modelo
mdl_final_tree = fitctree(T_train, 'glaucoma');

Relevantes = predictorImportance(mdl_final_tree);
end