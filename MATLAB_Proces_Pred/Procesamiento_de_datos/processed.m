%% EXPLANATION
% The aim of this function is to adequate the data that was collected from
% the questionaire, this includes translating, adapting the format or
% reducing the explanation of the categories.

function dataN = processed(data_processed)
% dataN = processed(data_processed)
% Returns a table with processed values, this includes translations
% chaning the format of some variables or reducing the explanations.

%  Input:
%      data_processed: A table that contains all the unique datapoints.
%
%  Output:
%      dataN: A table containing the preprocessed variables.

    % Determine the number of rows (r) and columns (c) of the input dataset
    [r,c]=size(data_processed);
    %With this loop the aim is to modify the format of the variable 
    %'mobile usage hours' from datatime to double.
    
    %With this loop the aim is to modify the format of the variable 
    %'sleeping hours' from datatime to double.         
   
    

    %With this loop the aim is to translate and reduce the names of the
    %categories of the  variable 'Application group'
   
    
    %With this loop the aim is to translate the names of the categories
    %of the  variable 'gender'


    %After adequating each column of the input data and saving it in different
    %arrays, an output table is being generated and it will be filled with
    %the arrays that have just been generated
    dataN=table ('Size',[r c],'VariableTypes',["double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","double","categorical"],'VariableNames',{'Área', 'Longitud eje mayor', 'Longitud eje menor', 'Área convexa','Circularidad', 'Perímetro', 'Distancia mínima entre núcleos', 'Varianza área','Varianza área convexa','Varianza circularidad','Varianza perímetro','Varianza longitud eje mayor','Ratio medio distancia ejes','Porcentaje de núcleos','Varianza de la distancia del eje menor','Compactabilidad de núcleos','Distancia media entre núcleos','Varianza distancia entre núcleos','Varianza del ratio de distancia ejes','Contraste','Correlación', 'Homogenidad','Energía','Tipo de cáncer'});
    dataN(:,:)=data_processed(:,:);
%     dataN(:,2)=array2table(categorical((Gender1)));
%     dataN(:,3)=table(Hours);
%     dataN(:,4)=array2table(categorical((App1)));
%     dataN(:,5)=array2table(categorical((Usage1)));
%     dataN(:,6)=array2table(categorical((SleepingUse1)));
%     dataN(:,7)=array2table(categorical((Drug1)));
%     dataN(:,8)=table(Hours1);
%     dataN(:,9)=array2table(categorical((Protector1)));
%     dataN(:,10)=array2table(categorical((Brightness1)));
end