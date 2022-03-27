#include<stdio.h>

#define printexp(x)  printf("-> %s = %d\n",  #x, x)
#define printcode(x)  printf("%s\n",  #x); x
#define sprintexp(s,x)  char s[] = #x;  x
#define sprintcode(s,x)  char s[] = #x;  x



int main()
{
  
  printcode(int y = 23;);
  printexp(y+5);

  printcode( int w = 56; w++;);
  printexp(w);

  return 0;
}
