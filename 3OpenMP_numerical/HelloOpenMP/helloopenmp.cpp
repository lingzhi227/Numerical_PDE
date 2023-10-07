#include <stdio.h>
#include <iostream>
int main(){
  float sum=0;
#pragma omp parallel for
  for(int i=0;i<10000000;i++){
    sum=sum+i;
  }
  std::cout << sum;
  return 0;
}