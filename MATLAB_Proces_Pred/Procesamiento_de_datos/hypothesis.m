%% EXPLANATION
% The aim of this function is to do hypothesis testing on the categorical
% variables.
function [n,H1,p1,ANOVATAB, stats,m1,H2,H3,H4,H5,H6,H7,p2,p3,p4,p5,p6,p7,p8,H8] =hypothesis(ProcessedData,categorical_vars1,dataN1,dataN2,dataN3,dataN4,f)
%[n,H1,p1,ANOVATAB, stats,m1,H2,H3,H4,H5,H6,H7,p2,p3,p4,p5,p6,p7,p8,H8] =hypothesis(ProcessedData,categorical_vars1,dataN1,dataN2,dataN3,dataN4,f)
% Returns the results of the test that have been performed as well as the
% number of categories that a variable has.

%  Input:
%      Processed_data: A table that contains all the datapoints without 
%      inconsistent data.  
%      categorical_vars1: 205x6 categorical containing all the values of
%      the categorical vars (without variable 'drug')
%      DataN2:Empty table to save values
%      DataN3:Empty table to save values
%      DataN4:Empty table to save values
%      DataN5:Empty table to save values
%      f:Iteration number
%
%  Output:
%      n: number of categories that a variable has.
%      H: hypotheis result (0 or 1)
%      p: p-value
%      ANOVATAB: cell with the results of the ANOVA test
%      stats: struct with ANOVA test information


[m1,n1]= size(ProcessedData);
for i = 1:m1
    A=categorical_vars1(:,f);
    B=removecats(A);
    C=categories(B);
    n=length(C);

  if n==2
    if categorical_vars1(i,f) == C(1,1)
        dataN1 = [dataN1 i];
    end
    if categorical_vars1(i,f) == C(2,1)
        dataN2 = [dataN2 i];
    end
  end
    
  if n==3
    if categorical_vars1(i,f) == C(1,1)
        dataN1 = [dataN1 i];
    end
    if categorical_vars1(i,f) == C(2,1)
        dataN2 = [dataN2 i];
    end
     if categorical_vars1(i,f) == C(3,1)
        dataN3 = [dataN3 i];
     end 
  end
  if n==4
    if categorical_vars1(i,f) == C(1,1)
        dataN1 = [dataN1 i];
    end
    if categorical_vars1(i,f) == C(2,1)
        dataN2 = [dataN2 i];
    end
     if categorical_vars1(i,f) == C(3,1)
        dataN3 = [dataN3 i];
     end 
    if categorical_vars1(i,f) == C(4,1)
        dataN4 = [dataN4 i];
    end
  end
end
if n==2
    optA=ProcessedData(dataN1,8);
    optB=ProcessedData(dataN2,8);
    optA1=table2array(optA);
    optB1=table2array(optB);
    optA2=transpose(optA1);
    optB2=transpose(optB1);
    [H1,p1] = ttest2(optA2,optB2)
    stats=0;
    ANOVATAB=0;
     
            H2=0;
            H3=0;
            p2=0;
            p3=0;
            p4=0;
            H4=0;
            H5=0;
            H6=0;
            H7=0;
            H8=0;
            p5=0;
            p6=0;
            p7=0;
            p8=0;
end
if n==3
    optA=ProcessedData(dataN1,8);
    optB=ProcessedData(dataN2,8);
    optC=ProcessedData(dataN3,8);
    optA1=table2array(optA);
    optB1=table2array(optB);
    optC1=table2array(optC);
    optA2=transpose(optA1);
    optB2=transpose(optB1);
    optC2=transpose(optC1);
    DataAnova=[optA2 optB2 optC2];
    A=ones(1,length(optA2));
    B=2*ones(1,length(optB2));
    C=3*ones(1,length(optC2));
    GroupsAnova=[A B C];
    [p1,ANOVATAB,stats] =anova1(DataAnova,GroupsAnova)
    if p1<=0.05
            [H2,p2] = ttest2(optA2,optB2);
            [H3,p3] = ttest2(optA2,optC2);
            [H4,p4] = ttest2(optC2,optB2);
            H1=0;
            H5=0;
            H6=0;
            H7=0;
            p5=0;
            p6=0;
            p7=0;
         if H4==1 
             if p4<=0.05
             [H8,p8] = ttest2(optC2,optB2, 'tail', 'left')
             else
                 H8=0;
                 p8=0;
             end
          if H3==1
                if p3<=0.05
             [H8,p8] = ttest2(optC2,optB2, 'tail', 'left')
             else
                 H8=0;
                 p8=0;
             end
          end 
              if H2==1
                if p2<=0.05
             [H8,p8] = ttest2(optC2,optB2, 'tail', 'left')
             else
                 H8=0;
                 p8=0;
             end
          end 
             
         else
             H8=0;
             p8=0;
        end
    else
            H1=0;
            H2=0;
            H3=0;
            p2=0;
            p3=0;
            p4=0;
            H4=0;
            H5=0;
            H6=0;
            H7=0;
            H8=0;
            p5=0;
            p6=0;
            p7=0;
            p8=0;
    end
    
end
if n==4
    optA=ProcessedData(dataN1,8);
    optB=ProcessedData(dataN2,8);
    optC=ProcessedData(dataN3,8);
    optD=ProcessedData(dataN4,8);
    optA1=table2array(optA);
    optB1=table2array(optB);
    optC1=table2array(optC);
    optD1=table2array(optD);
    optA2=transpose(optA1);
    optB2=transpose(optB1);
    optC2=transpose(optC1);
    optD2=transpose(optD1);
    DataAnova=[optA2 optB2 optC2 optD2];
    A=ones(1,length(optA2));
    B=2*ones(1,length(optB2));
    C=3*ones(1,length(optC2));
    D=4*ones(1,length(optD2));
    GroupsAnova=[A B C D];
    [p1,ANOVATAB,stats] =anova1(DataAnova,GroupsAnova)
        if p1<=0.05
            [H2,p2] = ttest2(optA2,optB2)
            [H3,p3] = ttest2(optA2,optC2)
            [H4,p4] = ttest2(optC2,optB2)
            [H5,p5] = ttest2(optA2,optD2)
            [H6,p6] = ttest2(opt2D,optB2)
            [H7,p7] = ttest2(optC2,optD2)
            H1=0;
            H8=0;
            p8=0;
    else
        H1=0;
        H2=0;
        H3=0;
        p2=0;
        p3=0;
        p4=0;
        H4=0;
        H5=0;
        H6=0;
        H7=0;
        p5=0;
        p6=0;
        p7=0;
        H8=0;
        p8=0;
        end
end
    dataN1 = [];
    dataN2 = [];
    dataN3 = [];
    dataN4 = [];
end