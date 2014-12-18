function[training_matrix,tt_matrix,test_matrix,tt_labels,tstlbl,tt_ori,tstlbl_ori]=matrix_generate(ppinteraction_exp,loc,cn, SI, JI, PAI, RAI, KI,ppinteraction)

    % for i=1:length(ppinteraction)
    %     for j=1:length(ppinteraction)
    %         if ppinteraction(i,j)==-1;
    %             ppinteraction(i,j)=0;
    %         end
    %     end
    % end
    % 
    
    clear i j
    %[loc]=localization(localization);
    % Creating Feature matrix and label matrix
    % first construct the random matrix, extract indices of upper triangular
    % elements and vectorize the features with upper triangular indices
    [train,test]=createFold(length(ppinteraction_exp));
    tt_ori=ppinteraction(test,train);
    test_ori=ppinteraction(test,test);test_ori_v=itriu(size(test_ori),1);tstlbl_ori=test_ori(test_ori_v);
    cn_train=cn(train,train);cn_train_v=itriu(size(cn_train),1);cnt=cn_train(cn_train_v);
    JI_train=JI(train,train);JI_train_v=itriu(size(JI_train),1);JIt=JI_train(JI_train_v);
    KI_train=KI(train,train);KI_train_v=itriu(size(KI_train),1);KIt=KI_train(KI_train_v);
    PAI_train=PAI(train,train);PAI_train_v=itriu(size(PAI_train),1);PAIt=PAI_train(PAI_train_v);
    RAI_train=RAI(train,train);RAI_train_v=itriu(size(RAI_train),1);RAIt=RAI_train(RAI_train_v);
    SI_train=SI(train,train);SI_train_v=itriu(size(SI_train),1);SIt=SI_train(SI_train_v);
    label_train=ppinteraction_exp(train,train);label_train_v=itriu(size(label_train),1);labelt=label_train(label_train_v);
    loc_train=loc(train,train);loc_train_v=itriu(size(loc_train),1);loct=loc_train(loc_train_v);
    training_matrix=horzcat(cnt,JIt,KIt,PAIt,RAIt,SIt,loct,labelt);

    % Train and Test matrix
    tt_labels=ppinteraction_exp(test,train);
    tt_cn=cn(test,train);
    tt_JI=JI(test,train);
    tt_KI=KI(test,train);
    tt_PAI=PAI(test,train);
    tt_RAI=RAI(test,train);
    tt_SI=SI(test,train);
    tt_loc=loc(test,train);
    tt_matrix=horzcat(tt_cn(:),tt_JI(:),tt_KI(:),tt_PAI(:),tt_RAI(:),tt_SI(:),tt_loc(:));
    % Test and Test matrix
    test_label=ppinteraction_exp(test,test);test_label_v=itriu(size(test_label),1);tstlbl=test_label(test_label_v);
    test_cn=cn(test,test);test_cn_v=itriu(size(test_cn),1);test_cnt=test_cn(test_cn_v);
    test_JI=JI(test,test);test_JI_v=itriu(size(test_JI),1);test_JIt=test_JI(test_JI_v);
    test_KI=KI(test,test);test_KI_v=itriu(size(test_KI),1);test_KIt=test_KI(test_KI_v);
    test_PAI=PAI(test,test);test_PAI_v=itriu(size(test_PAI),1);test_PAIt=test_PAI(test_PAI_v);
    test_RAI=RAI(test,test);test_RAI_v=itriu(size(test_RAI),1);test_RAIt=test_RAI(test_RAI_v);
    test_SI=SI(test,test);test_SI_v=itriu(size(test_SI),1);test_SIt=test_SI(test_SI_v);
    test_loc=loc(test,test);test_loc_v=itriu(size(test_loc),1);test_loct=test_loc(test_loc_v);
    test_matrix=horzcat(test_cnt,test_JIt,test_KIt,test_PAIt,test_RAIt,test_SIt,test_loct);


    
    
end