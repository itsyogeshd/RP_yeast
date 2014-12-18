avAUC_tt=mean(AUC_tt,2);
avAUC_test=mean(AUC_test,2);

%% plot

for i=1:7
    ROC=ROCtest(:,i);
    ROCav=averageROC(ROC);
    plot(ROCav(:,1),ROCav(:,2))
    hold on
end
title 'Experiment with all feature (physicalPPIs) Test-Test using Random Forests'
legend((strcat('CN= ',num2str(avAUC_test(1),3))),(strcat('JI= ',num2str(avAUC_test(2),3))),(strcat('KI= ',num2str(avAUC_test(3),3))),...
    (strcat('PAI= ',num2str(avAUC_test(4),3))),(strcat('RAI= ',num2str(avAUC_test(5),3))),(strcat('SI= ',num2str(avAUC_test(6),3))),...
    (strcat('loc= ',num2str(avAUC_test(7),3))),'Location','east')
legend('boxoff')

figure
for i=1:7
    ROC=ROCtt(:,i);
    ROCav=averageROC(ROC);
    plot(ROCav(:,1),ROCav(:,2))
    hold on
end
title 'Experiment with all feature (physicalPPIs) Train-Test using Random Forests'
legend((strcat('CN= ',num2str(avAUC_tt(1),3))),(strcat('JI= ',num2str(avAUC_tt(2),3))),(strcat('KI= ',num2str(avAUC_tt(3),3))),...
    (strcat('PAI= ',num2str(avAUC_tt(4),3))),(strcat('RAI= ',num2str(avAUC_tt(5),3))),(strcat('SI= ',num2str(avAUC_tt(6),3))),...
    (strcat('loc= ',num2str(avAUC_tt(7),3))),'Location','east')
legend('boxoff')

