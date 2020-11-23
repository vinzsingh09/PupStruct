function foldresult = PerformanceAssessment( traindata, testdata)
    dataX=cell2mat(traindata(:,1));
	labelY = cell2mat(traindata(:,2));

    weight_vector = randn (length(labelY), 1);
    model = svmtrain([], labelY, dataX, '-s 0 -t 2 -c 3 -g 0.50');

	testX = cell2mat(testdata(:,1));

	testlabelY = cell2mat(testdata(:,2));
    [predict_label, accuracy, score_svm] = svmpredict(testlabelY, testX, model);

	confumat = confusionmat(testlabelY, predict_label);

	TN = confumat(1,1);
	FP = confumat(1,2);
	FN = confumat(2,1);
	TP = confumat(2,2);

	Sensitivity = (TP / (TP + FN)) * 100;
	Specificity = (TN / (TN + FP)) * 100;
	Precision = (TP / (TP + FP)) * 100;
	Accuracy = ((TP + TN)/ (TP + FN + FP + TN))*100;
	MCC = ((TN * TP) - (FN * FP)) / sqrt((TP + FP)*(TP + FN)*(TN + FP)*(TN + FN));


	%folds	TP	FN	FP	TN	Sensitivity (Sn)	Specificity (Sp)	Precision (Pre)	Accuracy (ACC)	MCC	AUC

	foldresult = [TP FN	FP TN Sensitivity Specificity Precision Accuracy MCC];
    %foldresult = [TP FN	FP	TN	 Accuracy ];
end

