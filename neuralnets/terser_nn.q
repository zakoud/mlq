\l ../utils.q
nonlin:{ $[y;x*1-x; sigmoid x] };
x:"f"$(0 0 1;0 1 1;1 0 1;1 1 1);
y:0 0 1 1f;
syn0:-.5+3?1.0;
step:{
  l1:nonlin[x mmu syn0;0];
  l1_error:y-l1;
  l1_delta:l1_error*nonlin[l1;1];
  syn0+:(flip x) mmu l1_delta;
  l1 }
do[10000;l1:step[x;y]];
