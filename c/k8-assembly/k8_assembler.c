#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE    256
#define MAX_TOKEN   5
#define OUTPUT_MOD  8

int pos = 0;
unsigned char TEXT[MAX_LINE];
unsigned char DATA[MAX_LINE];

void fail(int n, char flag) {
    printf("Assembler failed at line %d\n\t", n - 1);
    switch(flag) {
        case 'a':
            printf("Illegal Argument Error\n");
            break;
            
        case 'd':
            printf("Data Expected Error\n");
            break;
            
        case 'e':
            printf("Argument Expected Error\n");
            break;
        
        case 'f':
            printf("Data Format Error\n");
            break;
            
        case 'o':
            printf("Illegal Operation Error\n");
            break;
            
        case 't':
            printf("Text Expected Error\n");
            break;
    }
    exit(1);
}

unsigned char argument(char *token, int n) {
    if(strlen(token) > 2) {
        fail(n, 'a');
    }
    
    if(token[1] == '\0') {
        if(token[0] == '1') {
            return 0x00;
        } else if(token[0] == '2') {
            return 0x04;
        } else if(token[0] == '3') {
            return 0x08;
        } else if(token[0] == '4') {
            return 0x0C;
        }
    } else if(!strncmp(token, "r0", 3)) {
        return 0x00;
    } else if(!strncmp(token, "r1", 3)) {
        return 0x04;
    } else if(!strncmp(token, "r2", 3)) {
        return 0x08;
    } else if(!strncmp(token, "pc", 3)) {
        return 0x0C;
    }
    
    fail(n, 'a');
}

unsigned char operation(char *token, int n) {
    if(strlen(token) > 3) {
        fail(n, 'o');
    }
    
    switch(token[0]) {
        case 'a':
            if(!strncmp(token, "add", 4)) {
                return 0x20;
            } else if(!strncmp(token, "and", 4)) {
                return 0x40;
            }
            break;
            
        case 'c':
            if(!strncmp(token, "clr", 4)) {
                return 0x70;
            }
            break;
            
        case 'd':
            if(!strncmp(token, "dec", 4)) {
                return 0xD0;
            }
            break;
            
        case 'i':
            if(!strncmp(token, "ife", 3)) {
                return 0x80;
            } else if(!strncmp(token, "ifn", 4)) {
                return 0x90;
            } else if(!strncmp(token, "ifl", 4)) {
                return 0xA0;
            } else if(!strncmp(token, "ifg", 4)) {
                return 0xB0;
            } else if(!strncmp(token, "inc", 4)) {
                return 0xC0;
            } 
            break;
        
        case 'l':
            if(!strncmp(token, "ld", 3)) {
                return 0x10;
            }
            break;
        
        case 'n':
            if(!strncmp(token, "not", 4)) {
                return 0x60;
            }
            break;
        
        case 'o':
            if(!strncmp(token, "or", 4)) {
                return 0x50;
            }
            break;
        
        case 's':
            if(!strncmp(token, "st", 3)) {
                return 0x00;
            } else if(!strncmp(token, "sub", 4)) {
                return 0x30;
            } else if(!strncmp(token, "shl", 4)) {
                return 0xE0;
            } else if(!strncmp(token, "shr", 4)) {
                return 0xF0;
            } 
            break;
    }
    
    fail(n, 'o');
}

void parse(char *tokens[], int n) {
    unsigned char op = 0x00;
    
    op |= operation(tokens[0], n);
    op |= argument(tokens[1], n); 
    
    if(tokens[2]) {
        if(!strncmp(tokens[2], "//", 2)) {
            op |= 0x03;
        } else {
            op |= argument(tokens[2], n) >> 2;
        }
    } else if(!strncmp(tokens[0], "clr", 4) || !strncmp(tokens[0], "not", 4)) {
        op |= 0x03;
    } else {
        fail(n, 'e');
    }
    
    printf("%d\t%x\n", n - 1, op);
    TEXT[pos++] = op;
}

int text(FILE *infile, int n) {
    char line[MAX_LINE], *tokens[3];
    
    while(fgets(line, MAX_LINE, infile)) {
        n++;
        
        tokens[0] = strtok(line, " \t\n,");
        
        if(tokens[0] == NULL || !strncmp(tokens[0], "//", 2)) {
            continue;
        } else if(!strncmp(tokens[0], "data:", 6)) {
            return n;
        }
        
        tokens[1] = strtok(NULL, " \t\n,");
        tokens[2] = strtok(NULL, " \t\n,");
        
        parse(tokens, n);
    }
    
    fail(n, 'd');
}

void data(FILE *infile, int n) {
    char line[MAX_LINE], *token;
    int loc = -1;
    
    while(fgets(line, MAX_LINE, infile)) {
        n++;
        token = strtok(line, " \t\n");
        
        if(token == NULL || !strncmp(token, "//", 2)) {
            continue;
        } else if(token[0] == '@' && token[1]) {
            loc = atoi(&token[1]);
        } else if(loc != -1 && token[0] != '@') {
            DATA[loc++] = atoi(token);
            printf("%d\t%d\t%d\n", n - 1, loc-1, DATA[loc-1]);
        } else {
            fail(n , 'f');
        }
    }
}

void assemble(FILE *infile) {
    char line[MAX_LINE], *token;
    int n = 1;
    
    while(fgets(line, MAX_LINE, infile)) {
        token = strtok(line, " \t");
        n++;
        
        if(!strncmp(token, "text:\n", 6)) {
            break;
        }
        
        if(strncmp(token, "//", 2)) {
            fail(n, 't');
        }
    }
    
    data(infile, text(infile, n));
}

void build(FILE *outfile) {
    int i;
    
    fprintf(outfile, "#ifndef _K8_PROGRAM_H_\n#define _K8_PROGRAM_H_\n\nconst unsigned char TEXT[%d] = {\n\t", pos);
    
    for(i = 0; i < pos - 1; i++) {
        fprintf(outfile, "0x%02X, ", TEXT[i]);
        
        if(!((i + 1) % OUTPUT_MOD)) {
            fputs("\n\t", outfile);
        }
    }
    // fprintf(outfile, "0x%02X\n};\n\nunsigned char DATA[%d] = {\n\t", TEXT[i], MAX_LINE);
    
    // for(i = 0; i < MAX_LINE - 1; i++) {
        // fprintf(outfile, "0x%02X, ", DATA[i]);
        
        // if(!((i + 1) % OUTPUT_MOD)) {
            // fputs("\n\t", outfile);
        // }
    // }
    
    // fprintf(outfile, "0x%02X\n};\n\n#endif\n", DATA[i]);
    
    fprintf(outfile, "0x%02X\n};\n\nunsigned char DATA[%d];\n\n/* Copy into simulator:\n", TEXT[i], MAX_LINE);
    
    for(i = 0; i < MAX_LINE; i++) {
        if(DATA[i]) {
            fprintf(outfile, "\tDATA[%d] = 0x%02X;\n", i, DATA[i]);
        }
    }
    
    fprintf(outfile, "*/\n\n#endif\n", DATA[i]);
}

int main(int argc, char *argv[]) {
    int i, len;
    
    if(argc != 2) {
        printf("Program requires an input file\n");
        exit(1);
    }
    
    len = strlen(argv[1]);
    
    if(strncmp(&argv[1][len - 2], "k8", 3)) {
        printf("Input file must be a K8 file (*.k8)\n");
        exit(1);
    }
    
    FILE *infile = fopen(argv[1], "r");
    
    // change file extension of input file
    FILE *outfile = fopen("k8_program.h", "w");
    
    // change file extension of input file
    // strncpy(&argv[1][len - 2], "bin", 4);
    // FILE *outfile_bin = fopen(argv[1], "w");
    
    assemble(infile);
    build(outfile);
    
    fclose(infile);
    fclose(outfile);
    //fclose(outfile_bin);
    
    return 0;
}
