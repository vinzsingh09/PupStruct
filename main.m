clear 

load 'pupData.mat'

count_k=2471;
summax = 48;

for j=1:length(PupData)
    
    if(PupData{j,3} == 1)
		PupData{j,15} = 1;
    else
        
		sumzero = sum(PupData{j,16}(1:summax,2));
		
		if (sumzero >= 1)
			PupData{j,15} = 0;
		else
			PupData{j,15} = 1;
        end
    end
end
	
	
s=0;
for j=1:length(PupData)
s  = s + PupData{j,15};

end
s

%sample data
postive_s = 181;
negative_s = s - 181;

postive_s_i = 1;
negative_s_i = 1;
s_i = 1;

SamplePupData = cell(s, 5);
PostiveSamplePupData = cell(postive_s, 5);
NegativeSamplePupData = cell(negative_s, 5);

for j=1:count_k
    
    if(PupData{j,15} == 1)
		SamplePupData(s_i,1:3) = PupData(j,1:3);
        %for compare with other result, index is needed
		SamplePupData{s_i,4} = j;
		SamplePupData{s_i,5} = PupData{j,14};
		
        if (PupData{j,3} == 1)
			PostiveSamplePupData(postive_s_i,1:3) = PupData(j,1:3);
			%for compare with other result, index is needed
			PostiveSamplePupData{postive_s_i,4} = j;
			PostiveSamplePupData{postive_s_i,5} = PupData{j,14};
            postive_s_i = postive_s_i + 1;
		else
			NegativeSamplePupData(negative_s_i,1:3) = PupData(j,1:3);
			%for compare with other result, index is needed
			NegativeSamplePupData{negative_s_i,4} = j;
			NegativeSamplePupData{negative_s_i,5} = PupData{j,14};
            negative_s_i = negative_s_i + 1;
        end
        
        s_i = s_i + 1;
    end
end

% k fold
foldsvalue = [6 8 10];
foldResult = [];
% Xsvm = [];
% Ysvm = [];
ComparefoldResult = [];
ComparefoldResult_Extractedfeature = [];
resultindex=1; % fill in the result matlab
	
 for foldsloop = 1:3
	k = foldsvalue(foldsloop);
	% k=6;
	k_p = PostiveSamplePupData;
	k_n = NegativeSamplePupData;

	pos_kfold = kfolddiv( k, k_p );
	neg_kfold = kfolddiv( k, k_n );

	% Xsvm = cell(k, 1);
	% Ysvm = cell(k, 1);

	TestData = cell(k, 1);

	for i=1:k
		foldpositive = PostiveSamplePupData(pos_kfold{i,3}(1):pos_kfold{i,3}(2), 5);
		foldpositive(:,2) = PostiveSamplePupData(pos_kfold{i,3}(1):pos_kfold{i,3}(2), 3);
		%for compare with other result, index is needed
		foldpositive(:,3) = PostiveSamplePupData(pos_kfold{i,3}(1):pos_kfold{i,3}(2), 4);

		foldnegative = NegativeSamplePupData(neg_kfold{i,3}(1):neg_kfold{i,3}(2), 5);
		foldnegative(:,2) = NegativeSamplePupData(neg_kfold{i,3}(1):neg_kfold{i,3}(2), 3);
		%for compare with other result, index is needed
		foldnegative(:,3) = NegativeSamplePupData(neg_kfold{i,3}(1):neg_kfold{i,3}(2), 4);

		testfold = [foldpositive; foldnegative];
		TestData{i,1} = testfold;

	end
	
	if (k == 6)
		TrainData = cell(k, 1);
		TrainData{1,1} = [TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}];
		TrainData{2,1} = [TestData{1,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}];
		TrainData{3,1} = [TestData{1,1}; TestData{2,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}];
		TrainData{4,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{5,1}; TestData{6,1}];
		TrainData{5,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{6,1}];
		TrainData{6,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}];
	end

	%8 folds
	if (k == 8)
		TrainData = cell(k, 1);
		TrainData{1,1} = [TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}];
		TrainData{2,1} = [TestData{1,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}];
		TrainData{3,1} = [TestData{1,1}; TestData{2,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}];
		TrainData{4,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}];
		TrainData{5,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}];
		TrainData{6,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{7,1}; TestData{8,1}];
		TrainData{7,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{8,1}];
		TrainData{8,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}];
	end

	%10 folds
	if (k == 10)
		TrainData = cell(k, 1);
		TrainData{1,1} = [TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}; TestData{9,1}; TestData{10,1}];
		TrainData{2,1} = [TestData{1,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}; TestData{9,1}; TestData{10,1}];
		TrainData{3,1} = [TestData{1,1}; TestData{2,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}; TestData{9,1}; TestData{10,1}];
		TrainData{4,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}; TestData{9,1}; TestData{10,1}];
		TrainData{5,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}; TestData{9,1}; TestData{10,1}];
		TrainData{6,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{7,1}; TestData{8,1}; TestData{9,1}; TestData{10,1}];
		TrainData{7,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{8,1}; TestData{9,1}; TestData{10,1}];
		TrainData{8,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{9,1}; TestData{10,1}];
		TrainData{9,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}; TestData{10,1}];
		TrainData{10,1} = [TestData{1,1}; TestData{2,1}; TestData{3,1}; TestData{4,1}; TestData{5,1}; TestData{6,1}; TestData{7,1}; TestData{8,1}; TestData{9,1}];
	end

	initial_index = resultindex;
	%train and test using Matlab
	for i=1:k
		traindata = TrainData{i,1};
		testdata = TestData{i,1};
		foldResult(resultindex,:) = PerformanceAssessment( traindata, testdata);
				
		resultindex = resultindex + 1;
	end
		
	finalindex = resultindex-1;
	for j=5:9
		foldResult(resultindex, j) = mean(foldResult(initial_index:finalindex, j));

	end

	resultindex = resultindex + 2;

 end
