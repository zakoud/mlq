// Utils functions
// Machine Learning for Q Library - (MLQ-lib)

// Documentation:


/ Returns dimensions of a matrix
/ @param mat (Matrix|Table|List) 
mdim:{[mat] 
  (count mat;count flip mat)
 };

/ Retrieves the diagonal of a matrix
/ @param mat (Matrix|Table|List)
diag:{[mat]
  i:count mat[0];
  x:(til i)+i*til i;
  (raze mat)[i]
 };

/ Identity matrix generation
id:{
  i:til x*x;
  "i" $ (x;x)#raze 0=i mod (x+1)
 };

/ Returns the range range (min/max) of a vector
/ @param vec (List) vector
range:{[vec]
  (min vec;max vec)
 };
 
/ Bubble sorting algorithm
/ @param list (List) list of numbers to sort
/ @example bubbleSort[(2;5;24;17;39;8;47;6;1)]
bubbleSort:{[list]
  n:-1+count list;
  i:0;
  do[n;j:0;
    do[n;
      if[>/[list k:j+0 1]; list[k]:reverse list[k]];
    j+:1];i+:1];
  list
 };
 
/ Returns root mean squared error
rmse:{
  sqrt sum (x xexp 2) % (count x)
 }; 

/ Exponentially-weighted moving average
ewma:{
  {y+x*z-y}[x:2%1+x]\[y]
 };

