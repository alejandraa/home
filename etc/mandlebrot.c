#include <stdio.h>
#define GRID_SIZE 100 
#define MAX_ITER 1000


int grid[GRID_SIZE][GRID_SIZE] = {0};

void printGrid(void) {
    int i, j;
    for(i = 0; i<GRID_SIZE; i++) {
        for(j = 0; j<GRID_SIZE; j++) {
            int iter = grid[i][j];
            if(iter == -1) {
                putchar(' ');
            }
            else if(iter < 20) {
                putchar('/');
            }
            else if(iter < 50) {
                putchar('^');
            }
            else if(iter < 100) {
                putchar('/');
            }
            else {
                putchar('(');
            }
        }
        putchar('\n');
    }

}

int main (void) {
    int i, j, iter;

    for(i = 0; i<GRID_SIZE; i++) {
        for(j = 0; j<GRID_SIZE; j++) {  
            double x_0 = i/(GRID_SIZE/3.5)-2.5;
            double y_0 = j/(GRID_SIZE/2.0)-1.0;
            double x = 0, y = 0;
            
            for (iter = 0; x*x + y*y < 4 && iter < MAX_ITER; iter++) {
                double xtemp = x*x - y*y + x_0;
                y = 2*x*y + y_0;
                x = xtemp;
            }

            if(x*x + y*y < 4)
                grid[i][j] = -1;
            else {
                grid[i][j] = iter;
            }
        }
    }

    printGrid();
    return 0;
}