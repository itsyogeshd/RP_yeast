avAUC_tt=sum(AUC_tt)/10;
avAUC_test=sum(AUC_test)/10;
 %% plot
 
     ROCav=averageROC(ROCtest);
     plot(ROCav(:,1),ROCav(:,2))
     hold on

     ROCav=averageROC(ROCtt);
     plot(ROCav(:,1),ROCav(:,2))
     
 title 'RandomForests using all-predictor (physicalPPIs) and Experiment'
 legend((strcat('Test-Test= ',num2str(avAUC_test,3))),(strcat('Test-Train= ',num2str(avAUC_tt,3))),'location','bestoutside')
 legend('boxoff')
