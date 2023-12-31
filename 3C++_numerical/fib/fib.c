/**********************************************
The Fibonacci numbers are defined by the following
rule:

f_0 = 0
f_1 = 1
f_n = f_(n-1) + f_(n-2)

Write a program that computes Fibonacci numbers.
 **********************************************/
#include <stdio.h>

int fibonacci(int n);

int main() {
  // Get integer n
  int n;
  printf("Enter integer: ");
  scanf(" %i", &n);

  // Print out number of characters in n
  printf("Fibonacci %i is %i\n", n, fibonacci(n));

  return 0;
}

int fibonacci(int n) {
  if (n == 0 || n == 1) {
    return n;
  } else {
    return fibonacci(n-1) + fibonacci(n-2);
  }
}