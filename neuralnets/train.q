// Neural Networks Training Script
// Machine Learning for Q Library - (MLQ-lib)

// Documentation:

\l ../utils.q
\l nn.q

loadData:{[data]
	data:("FFFF*";",") 0: `$raze string `:,data;
	dataSet:()!();
	outputs:{"F"$enlist each x} each last data;
	dataSet[`bias]:(count flip data)#1f;
	dataSet[`inputs]:standardiseData flip 4#data;
	dataSet[`outputs]:outputs;
	dataSet[`classes]:classesFromOutputs each outputs;
	:dataSet;
 };	

maxWeight:0.5;
maxIterations:500;
validationStopThreshold:eta:0.1;


epochCount:1;

trainingSet:loadData[`iris_training.dat];
validationSet:loadData[`iris_validation.dat];
testingSet:loadData[`iris_testing.dat];

weights_: initialiseWeights[maxWeight;5;3];

p:1;
trainingError:();
validationError:();
testingError:();
while[not (p < validationStopThreshold) or (epochCount >= maxIterations);
	weights_:updateBackPropagation[trainingSet[`inputs];weights_;trainingSet[`bias];eta;trainingSet[`outputs]];
	trainingError:evalNetwork[trainingSet;weights_];
	validationError:evalNetwork[validationSet;weights_];
	testingError:evalNetwork[testingSet;weights_];
	epochCount:epochCount + 1;
	p:validationError[0];
	if[(epochCount>9) and (mod[epochCount;10] = 0);
		-1 "Epochs: ", string[epochCount];
		-1 "Training: ", raze string each trainingError[0]," ", trainingError[1];
		-1 "Validation: ", raze string each validationError[0]," ", validationError[1];
		-1 "Test: ", raze string each testingError[0]," ", testingError[1];
		-1 "";
		];
	];
