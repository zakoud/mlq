// K-Means clustering algorithm implementation in kdb+/q
// Machine Learning for Q Library - (MLQ-lib)

// DOCUMENTATION:


result:()!();
result[`accuracyRate]:`float$();
result[`iterations]:`long$();
result[`centroids]:();
result[`labels]:();

/ K-means function
/ @param data (Table|List) training data
/ @param labels (List) labels
/ @param k (Int) number of centroids
kmeans:{[data;labels;k];

  if[.Q.qt[data]; 
    data:raze each data];

  finalresult:result;

  / dimensions of data
  size:mdim data;
  n:size[0];
  m:size[1];
    
  / allocating variables
  g0:(n,1)#1;
  gIdx:(n,1)#0;
  iterations:0;

  / create k random centroids
  ctrds:(k;m)#(k*m)?(til (max/)data);
  listCentroids:();

  while[not (g0~gIdx);
    g0:gIdx;
    d:(n,k)#0;
    d:sqrt(((sum each data) -/:\:sum each ctrds) xexp 2);
    gIdx:where each d = min each d;
    ctrds:{[cnt;dataX;idx] avg dataX[where idx[;0]=cnt]}[;data;gIdx]each til k;
    listCentroids,:ctrds;
    iterations:iterations+1];
    
  $[count labels;
    acc_rate:(count where labels=gIdx[;0])%(count labels);
    acc_rate:`NA];
    
  finalresult[`accuracyRate]:acc_rate;
  finalresult[`labels]:gIdx[;0];
  finalresult[`iterations]:iterations;
  finalresult[`centroids]:listCentroids;
  finalresult
 };
