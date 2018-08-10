#include<stdio.h>
#include<stdint.h>
#include<stdlib.h>

#define ONE_MB (1 << 20)
#define BUFFER_SIZE ONE_MB

void readFile(const char file_name[], char buffer[]) {
	FILE* file = fopen(file_name, "r");
	uint32_t k;
	for(k = 0; k < BUFFER_SIZE; k += 1) {
		buffer[k] = 0;
	}

	uint32_t bytes_read = fread(buffer, 1, BUFFER_SIZE, file);
	buffer[bytes_read] = 0;
}

int main() {
	char a[BUFFER_SIZE];
	char b[BUFFER_SIZE];

	readFile("stackVariables.txt", a);

	int i = 0;
	int j = 0;

	while (a[i] != 0) {
		if(a[i] == '#') {
			while(a[i] != '\n') {
				if(a[i] == 0) break;			
				i++;
			}
		} 
		if(a[i] == '\n') a[i] = ' ';  
		b[j] = a[i];
		if(a[i] == 0) break;
		i++;
		j++;	
	}	

	printf("%s", b);
	return 0;
}
