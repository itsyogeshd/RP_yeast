function[pred_tt,pred_test]=convert(label_train,label_test)
    x=char(label_train);
    pred_tt=str2num(x);
    y=char(label_test);
    pred_test=str2num(y);
end