//****************************************************************************************************************************
//Program name: "Array of Integers Program". This program demonstrates arrays that are created based on user input. These arrays*
//only accept floating point values. It also calculates the magnitude for each array, and displays it.                       *
//Copyright (C) 2023 Samuel Vo.                                                                                              *
//                                                                                                                           *
//This file is part of the software program "Array of Integers Program".                                                     *
//"Array of Integers Program" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public *
//License version 3 as published by the Free Software Foundation.                                                            *
//Array of Integers Program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the    *
//implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
//details. A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                   *
//****************************************************************************************************************************

//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
// Author name: Samuel Vo
// Author email: samvo@csu.fullerton.edu
//
//Program information
//  Program name: Array of Integers Program
//  Programming languages: Two modules in C and five modules in X86
//  Date program began: 2023-Feb-15
//  Date of last update: 2023-Feb-21
//  Date comments upgraded: 2023-Feb-21
//  Files in this program: main.c, manager.asm, magnitude.asm, append.asm, isfloat.asm, input_array.asm, display.c, r.sh
// Status: Finished. Alot of testing for cases where ints, strings, and characters were used to check if the input is only 64-bit
//  floating point values to make sure it had consistent results. 
//  References consulted: Professor Holliday's lecture, Professor Holliday's Examples, Johnson Tong (SI Session), Textbook
//  Future upgrade possible: none
//
//Purpose
//  This program asks the user to store 64-bit floating point values into arrays. Then the arrays will be displayed, and a magnitude for 
//  each array will be calculated based on the values entered into the arrays. Then a final array will be created based on the first two arrays
//  that will be combined. Finally, the magnitude for the third array is calculated and displayed. 
// 
//
//This file
//  File name: main.c
//  Language: C
//  Max page width: 132 columns  [132 column width may not be strictly adhered to.]
//  Compile this file: gcc -c -Wall -no-pie -m64 -std=c2x -o main.o main.c  
//  Link this program: g++ -m64 -no-pie -o arrays.out manager.o main.o display_array.o input_array.o magnitude.o append.o isfloat.o -std=c2x


//=================Begin code area ===============================================================================


#include <stdio.h>
#include <stdlib.h>



extern double myArray();

int main()
{
    double arr_Data = 0.0;

    printf("Welcome to Arrays of Integers \n");
    printf("Bought to you by Samuel Vo \n");
    printf("\n");

    arr_Data = myArray();

    printf("Main received %.10lf, and will keep it for future use. \n", arr_Data);
    printf("Main will return 0 to the operating system. Bye.");
    printf("\n");

}

//============================ end of code =========================================================================