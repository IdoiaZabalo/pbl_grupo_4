function Carac_calidad = Carac_calidad(I_origen)

Carac_calidad=table; 
   entropia = entropy((I_origen));
        I = double(rgb2gray(I_origen));
        Laplaziarra=[0 1 0; 1 -4 1; 0 1 0]; 
        L = imfilter(double(I),Laplaziarra, 'conv'); 
        contraste = std2(I);  
        laplace_med=mean(abs(L(:)));

    Carac_calidad=addvars(Carac_calidad,contraste, entropia, laplace_med,'NewVariableNames', {'Contraste', 'Entropia','Laplace_media'});

end