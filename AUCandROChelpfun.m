% ROC functions

function [AUC,ROC] = getAUCandROC(labels,predictions),  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    
    TPR = 0;
    FPR = 0;
    TPRprev = 0;
    FPRprev = 0;
    AUC = 0;
    [pred_sort,idsort] = sort(predictions,'descend');
    labelsort = labels(idsort);

    Pos = size(find(labels==1),1);
    if Pos==0, 
      'ppiFrame: Warning - no positive examples!'
    end;

    Neg = size(find(labels==-1),1);
    if Neg==0, 
      'ppiFrame: Warning - no negative examples!'
    end; 

    %[pred_sort labelsort]

    i=1;
    lprev = -1000;
    ROC = []; 

    while i<=size(pred_sort,1),

    if pred_sort(i)~=lprev,
     ROC = [ROC; FPR/Neg TPR/Pos];
     AUC = AUC + calcarea(FPR,FPRprev,TPR,TPRprev);

     lprev = pred_sort(i);
     TPRprev = TPR;
     FPRprev = FPR;
    end;

    if labelsort(i)==1,
     TPR = TPR+1;
    else
     FPR = FPR+1;
    end;

    i = i+1;
    end;
    ROC = [ROC; FPR/Neg TPR/Pos];
    AUC = AUC + calcarea(FPR,FPRprev,TPR,TPRprev);
    AUC = AUC/(Pos * Neg);
  end

  function [ROCav] = averageROC(ROCset), %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ROCav = [];
   s = 1;

   if size(ROCset,2)>size(ROCset,1),
      ROCset = ROCset';
   end;

   % average ROC 
   for i=0.01:0.01:0.1,
    ROCav(s,1) = i;
    tprsum = 0;
    for k=1:size(ROCset,1),
      tprsum = tprsum + TPR_FOR_FPR(i,ROCset{k},size(ROCset{k},1));
    end;

    ROCav(s,2) = tprsum/size(ROCset,1);
    s = s+1;
   end;


   % average ROC 
   for i=0.15:0.05:1,
    ROCav(s,1) = i;
    tprsum = 0;
    for k=1:size(ROCset,1),
      tprsum = tprsum + TPR_FOR_FPR(i,ROCset{k},size(ROCset{k},1));
    end;

    ROCav(s,2) = tprsum/size(ROCset,1);
    s = s+1;
   end;

  end

   function [tpr] = TPR_FOR_FPR(fprsamp,ROC,npts),
    
    tpr = 0;
    j=1;

    while j<npts & ROC(j+1,1)<fprsamp,
       j=j+1;
    end;
   
    if ROC(j,1) == fprsamp,
      tpr = ROC(j,2);
    else,
      tpr = INTERPOLATE(ROC(j,:),ROC(j+1,:),fprsamp);
    end;

  end

  function [Y] = INTERPOLATE(ROC1,ROC2,X),

    slope = (ROC2(:,2)-ROC1(:,2))/(ROC2(:,1)-ROC1(:,1));
    Y = ROC1(:,2) + slope*(X-ROC1(:,1));
  end


  function A=calcarea(X1,X2,Y1,Y2), %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    base = abs(X1-X2);
    height = (Y1+Y2)/2;
    A = base*height;
  end
