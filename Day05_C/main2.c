#include <stdio.h>
#include <stdint.h>
#include "main.h"
#include <limits.h>

#define MAX_LINE_LENGTH 256
#define SOIL_START 3
#define SOIL_LENGTH 2
#define FERT_START 7
#define FERT_LENGTH 3

struct Range {
    int64_t a;
    int64_t b;
    int64_t c;
};

int64_t readFileMode = 0;
int64_t seeds[20];
char lines[200][256];

struct Range mapping[7][50];

void lineToNumArr(char line[256], int64_t * arr, int64_t startIndex, int pr) {
    int64_t num = 0;
    int64_t numCounter = 0;
    int64_t i = startIndex;

    while(1) {
        char ch = line[i++];
        if(ch == ' ' || ch == '\n') {
            arr[numCounter++] = num;
            num = 0;
            
            if(ch == '\n') break;
            continue;
        }

        int64_t x = ch - '0';
        num = num * ((int64_t) 10) + x;
        // if(pr == 1) {
        //     // Use the correct format specifier for int64_t
        //     printf("%ld %c %ld\n", x, ch, num);
        // }
    }
}

void parseSeeds(char line[256]) {
    // printf("--seed");
    lineToNumArr(line, seeds, 7, 1);
}

void parseMappings(char line[256], FILE *file) {
    int64_t i = 0;
    int64_t skip = 0;
    int64_t mappingIndex = 0;
    int64_t rangeIndex = 0;

    while (fgets(line, 256, file) != NULL)
    {
        *lines[i] = *line;
        // printf("%d: %s\n", i, line);

        if (skip > 0)
        {
            // printf("\tskipped\n");
            skip--;
            i++;
            continue;
        }

        if (i == 0)
        {
            parseSeeds(line);
            // printf("%s\n", line);
            skip = 2;
            i++;
            continue;
        }

        char ch = line[0];
        if (ch == '\n')
        {
            mappingIndex++;
            rangeIndex = 0;
            skip = 1;
            i += 2;
            continue;
        }
        else if(ch == 'e') {
            break;
        }

        // printf("%d %d %c\n", mappingIndex, rangeIndex, ch);
        int64_t arr[3];
        lineToNumArr(line, arr, 0, 0);
        struct Range range;
        range.a = arr[0];
        range.b = arr[1];
        range.c = arr[2];
        mapping[mappingIndex][rangeIndex] = range;
        rangeIndex++;
        i++;
    }
}
    
int64_t main() {
    FILE *file;
    char line[MAX_LINE_LENGTH];

    file = fopen("input.txt", "r");

    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    parseMappings(line, file);

    // printf("Print64_t seeds\n");
    // for(int64_t i = 0; i < 20; i++) {
    //     if(seeds[i] == 0) break;
    //     printf("%d\n", seeds[i]);
    // }
    
    // printf("Print64_t last mapping\n");
    // for(int64_t m = 0; m < 7; m++) {
    //     printf("-----------------------\n");
    //     for(int64_t i = 0; i < 3; i++) {
    //         printf("%d %d %d\n", mapping[m][i].a, mapping[m][i].b, mapping[m][i].c);
    //     }
    // }
    int64_t minimum = INT_MAX;
    int64_t value = 0;
    int64_t from = 0;
    int64_t to = 0;

    for(int64_t i = 0; i < 20; i+=2) {
        // value = seeds[i];
        from = seeds[i];
        to = seeds[i] + seeds[i + 1];

        for(int64_t m = from; m < to; m++) {
            value = m; // <= right
            // printf("seed %ld - ", m);
            for(int64_t j = 0; j < 7; j++) {
                struct Range *map = mapping[j];
                
                for(int64_t k = 0; k < 50;k++) {

                    struct Range range = map[k];
                    if((range.a + range.b + range.c) == 0) break;
                    
                    int64_t lower = range.b;
                    int64_t high = range.b + range.c;

                    if(value >= lower && value < high) {
                        value = value + range.a - range.b;
                        // printf("value: %ld\n", value);
                        break;
                    }
                }
            }

            
            if(value < minimum) {
                minimum = value;
            }
        }
        
        printf("Minimum: %d\n", minimum);
    }

    printf("Minimum: %d\n", minimum);

    fclose(file);

    return 0;
}
