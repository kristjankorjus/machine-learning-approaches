%% Train model
model = svmtrain(CLASSES, DATA, ['-c ', num2str(10)])

%% Predict
predictions = svmpredict(CLASSES, DATA, model)

%% Acc
sum(predictions == CLASSES)