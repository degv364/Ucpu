#ifdef TESTING
#include <stdio.h>
#endif

// Last fibonacci that fits in 32 bits
#define LAST_FIBONACCI 6
#define PERIOD 6553500

typedef struct fibonacci_result{
  int prev_result;
  int current_result;
} fibonacci_result;

fibonacci_result fibonacci(int n){
  fibonacci_result result;
  int temp;
  if (n == 1){
    result.prev_result = 1;
    result.current_result = 2;
    return result;
  }
  else{
    result = fibonacci(n-1);
    temp = result.current_result;
    result.current_result = result.current_result+
      result.prev_result;
    result.prev_result = temp;
    return result;
  }
}

#ifndef ICARUS
void wait(int n){
  for (int j=0; j<10; j++){
    for (int i=0; i<n; i++){
      asm volatile("nop");    
    }
  }
}
#endif

void main(){
  fibonacci_result result;
  for(int i=2; i<LAST_FIBONACCI;i++){
    result = fibonacci(i);
    asm volatile("led %0" : : "r" (result.current_result));
#ifndef ICARUS
    wait(PERIOD);
#endif
#ifdef TESTING
    printf("int: %d  hex: %x \n",
	   result.current_result,
	   result.current_result);
#endif
  }
}
