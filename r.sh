#!/bin/bash

#Author: Samuel Vo
#Program name: Array of Integers Program

rm *.o
rm *.lis
rm *.out

echo "This is program <Array of Integers Program>"

echo "Compile the C module main.c"
gcc -c -Wall -no-pie -m64 -std=c2x -o main.o main.c

echo "Compile the C module display_array.c"
gcc -c -Wall -no-pie -m64 -std=c2x -o display_array.o display_array.c

echo "Assemble the module manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm 

echo "Assemble the module input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm 

echo "Assemble the module magnitude.asm"
nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm 

echo "Assemble the module isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm 

echo "Assemble the module append.asm"
nasm -f elf64 -l append.lis -o append.o append.asm 

echo "Link the six object files already created"
g++ -m64 -no-pie -o arrays.out manager.o main.o display_array.o input_array.o magnitude.o append.o isfloat.o -std=c2x

echo "Run the program Array of Integers Program"
./arrays.out

echo "The bash script file is now closing."

rm *.o
rm *.lis
rm *.out