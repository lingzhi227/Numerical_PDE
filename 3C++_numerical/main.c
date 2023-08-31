#include <stdio.h>

int main() {
	long double start;
	long double end;
	long double step;
	
	printf("please enter start: ");
	scanf("%Lf", &start);
	printf("please enter end:");
	scanf("%Lf", &end);
	printf("please enter step size: ");
	scanf("%Lf", &step);
	
	while (start != end) {
		
		printf("%Lf\n", start);
		start = start+step;
	}
	
	return 0;
}