%% EXPLANATION
% The aim of this function is to delate the inconsistent data that was 
% collected from the questionaire.
function [dataN1,response_var1,independent_vars1,categorical_vars1] =inconsistent_data(dataN,a,b,c)
% [dataN1,response_var1,independent_vars1,categorical_vars1] =inconsistent_data(dataN,a,b,c)

% Returns a table with no inconsistent data and some structureds containing
% the different variable types (response, categorical and independent or 
% numerical separetely.

%  Input:
%      dataN: A table that contains all the preprocessed datapoints.
%      a: array containing the positions of the numerical variables.
%      b:array containing the positions of the categorical variables except
%      of the drug that after cleaning the inconsistent data will only have
%      one option ('No')
%      c:array containing the positions of the numerical variables.
%
%  Output:
%      dataN1: A table without inconsistent data.
%      response_var1: 205x1 double array containing all the values of the
%      response var
%      independent_vars1: 205x3 double array containing all the values of
%      the numerical vars
%      categorical_vars1: 205x6 categorical containing all the values of
%      the categorical vars (without variable 'drug')

response_var = dataN.("Tipo de cáncer");
independent_vars = dataN(:,a);
independent_vars = table2array(independent_vars);
l = 1;
categorical_vars=dataN(:,c);
categorical_vars = table2array (categorical_vars);
categorical_vars=categorical(categorical_vars);
% In this loop only are being saved the datapoints that sleep more than 4
% hours, the sum of sleeping hours and mobile usage ours is smaller than 24
% and the datapoints that do not use drug for sleeping.
% for p = 1:height(dataN)
%     conclusion = independent_vars(p,2)+independent_vars(p,3);
%     if conclusion<=24 && independent_vars(p,3)>=4 && categorical_vars(p,5)=="No"
%         dataN1(l,:) = dataN(p,:);
%         l = l+1;
%     end
% end
height(unique(dataN,'rows'));
response_var1 = dataN.("Tipo de cáncer");
independent_vars1 = dataN(:,a);
independent_vars1 = table2array(independent_vars1);
categorical_vars1=dataN(:,b);
categorical_vars1 = table2array (categorical_vars1);
categorical_vars1=categorical(categorical_vars1);
dataN1=dataN;

end