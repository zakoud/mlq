// Utils functions
// Machine Learning for Q Library - (MLQ-lib)

// Documentation:


// Constants
pi:acos -1;



// Random tools 

round:{
	floor x+0.5
 };
 
/ Bubble sorting algorithm
/ @example bubbleSort[(2;24;5;17;39;8;47;6;1)]
bubbleSort:{
	n:-1+count x;
	i:0;
	do[n;j:0;
		do[n;
			if[>/[x k:j+0 1]; x[k]:reverse x[k]];
		j+:1];i+:1];
	x
 };


 
// Trigonometric tools 

/ Hyperbolic sine
sinh:{
	0.5 * exp [x] - exp neg x
 };

/ Hyperbolic cosine
cosh:{
	0.5 * exp [x] + exp neg x
 };

/ Hyperbolic tangent 
tanh:{
	(exp[x] - exp neg x) % (exp[x] + exp neg x)
 };

/ Sigmoid function: f(x)->[0,1] 
sigmoid:{
	1 % (1 + exp neg x)
 };
 
 
 
// Statistical tools

/ Returns root mean squared error
rmse:{
	sqrt sum (x xexp 2) % (count x)
 }; 

/ Exponentially-weighted moving average
ewma:{
	{y+x*z-y}[x:2%1+x]\[y]
 };

/ Generate n x m random variates ~N(0,1)  
rand_:{
	(x;y)#(x*y)?1f
 }; 

/ Generate a n x m matrix of random normally distributed variates
norm:{
	(x;y)#raze sqrt[-2*log (x*y)?1f]*/:(sin;cos)@\:(2*pi)*(x*y)?1f
 };

k).q.var:{avg x*x:$[t&78h>t:@x;x-avg x;x-\:avg x]};


 
// Matrix manipulation tools 

repmat:{[data;w;l] 
	flip w#enlist raze l#enlist flip data
 };

/ Returns an n x m matrix of 1 
ones:{
	(x;y)#1f
 };

/ Returns an n x m matrix of 0 
zeros:{
	(x;y)#0f
 };
 
/ Returns dimensions of a matrix
size:{ 
	(count x;count flip x)
 };

/ Identity matrix generation
id:{
	(x,x)#1,x#0
 };

/ Returns the range range (min/max) of a vector
range:{
	(min x;max x)
 };

/ Returns max values of 2 arrays
pmax:{
	(count x)#(desc raze x,y)
 };

/ Kronecker tensor product 
kron:{
	x*\:\:y
 };

/ Retrieves the diagonal of a matrix
diag:{
	x ./: 2#'(til count x)
 };
