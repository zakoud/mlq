// Neural Networks Function Scripts
// Machine Learning for Q Library - (MLQ-lib)

 
activateDerivative:{
	: (1 - tanh[x] xexp 2) % 2;
 };
 
activate:{
	: (1 + tanh[x]) % 2;
 };
 
evalNetwork:{[data;weights]
	n : feedForward[data[`inputs];weights;data[`bias]];
	outputs:n[0];
	regressionError:(sum[sum[(outputs - data[`outputs])xexp 2]])% ((count data[`inputs]) * (count flip data[`outputs]));
	
	classes : raze{1+where x = max x} each outputs;

	classificationError : (sum[ classes<>data[`classes]]) % (count data[`inputs]);
	
	:(regressionError;classificationError);
 };
 
feedForward:{[inputs;weights;bias]
	$[1=count inputs;
		net:mmu[(raze raze inputs,bias);weights];
		net:mmu[(inputs,'bias);weights]];
	:(activate net; net);
 };
 
makeOutputsFromClasses:{[classes]
	sampleCount : count classes;
	outputs : (sampleCount;max[classes])#0;
	outputs[x;classes[x]] : 1;
	outputs
 };
 
classesFromOutputs:{
	: first 1f+where not x=0;
 };

initialiseWeights:{[maxWeight; rowCount; colCount]
	: (1-2*rand_[rowCount; colCount]) * maxWeight;
 };
 
randInt:{[m; n; range]
	: floor[rand_[m;n]*range]; 
 };

pmax:{
	times:count x;
	l:raze x,y;
	u:();
	do[times;p:max l;u,:p;l:l except p];
	:u;
 };
 
standardiseData:{[inputs]
	x : size[inputs];
	
	newInputs : (x[0];x[1])#0;
	newInputs : inputs -\: avg[inputs];
	
	minData : min[newInputs];
	maxData : max[newInputs];

	divisors : pmax[abs[minData];abs[maxData]];
	
	: newInputs %\: (0.5 + divisors * 0.475);
 };
 
updateBackPropagation:{[inputs;weights;bias;eta;targetOutputs]
	x : size[inputs];
	sampleIndex : randInt[1;1;x[0]];
	n : feedForward[inputs[sampleIndex];weights;bias[sampleIndex]];
	error : (raze raze targetOutputs[sampleIndex]) - n[0];
	delta : error * activateDerivative each n[1];
	weightsDelta : eta * kron[raze raze (inputs[sampleIndex],bias[sampleIndex]);delta];
	: weights + weightsDelta;
 };
