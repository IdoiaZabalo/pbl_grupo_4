function [Uniquedata,nRepeatedPoints] =repeated_data(Originaldata)
% [Uniquedata, nRepeatedPoints] = repeated_data(Originaldata)
% Returns a table with no repeated datapoints and the number of datapoints
% that have been delated from the input table to reach the desired output.

%  Input:
%      Originaldata: A table that contains all the datapoints.
%
%  Output:
%      Uniquedata: A table containing only unique datapoints.
% 
%      nRepearedPoints: a integer that represents the number of repeated
%       datapoints that were in the input table.

    nRepeatedPoints= height(Originaldata)-height(unique(Originaldata,'rows'))
    [~, ind] = unique(Originaldata,'rows'); 
    duplicate_ind = setdiff(1:size(Originaldata, 1), ind);
    duplicate_value =Originaldata(duplicate_ind, :);
    Originaldata(duplicate_ind,:)=[];
    Uniquedata=Originaldata
    
end