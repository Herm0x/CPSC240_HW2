;****************************************************************************************************************************
;Program name: "Array of Integers Program". This program demonstrates arrays that are created based on user input. These arrays*
;only accept floating point values. It also calculates the magnitude for each array, and displays it.                       *
;Copyright (C) 2023 Samuel Vo.                                                                                              *
;                                                                                                                           *
;This file is part of the software program "Array of Integers Program".                                                     *
;"Array of Integers Program" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public *
;License version 3 as published by the Free Software Foundation.                                                            *
;Array of Integers Program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the    *
;implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more      *
;details. A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                   *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Samuel Vo
;  Author email: samvo@csu.fullerton.edu
;
;Program information
;  Program name: Array of Integers Program
;  Programming languages: Two modules in C and five modules in X86
;  Date program began: 2023-Feb-15
;  Date of last update: 2023-Feb-21
;  Date comments upgraded: 2023-Feb-21
;  Files in this program: main.c, manager.asm, magnitude.asm, append.asm, isfloat.asm, input_array.asm, display.c, r.sh
;  Status: Finished. Alot of testing for cases where ints, strings, and characters were used to check if the input is only 64-bit
;  floating point values to make sure it had consistent results. 
;  References consulted: Professor Holliday's lecture, Professor Holliday's Examples, Johnson Tong (SI Session), Textbook
;  Future upgrade possible: none
;
;Purpose
;  This program asks the user to store 64-bit floating point values into arrays. Then the arrays will be displayed, and a magnitude for 
;  each array will be calculated based on the values entered into the arrays. Then a final array will be created based on the first two arrays
;  that will be combined. Finally, the magnitude for the third array is calculated and displayed. 
;
;This file
;  File name: append.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l append.lis -o append.o append.asm


;========= Begin Code ===========

global append

segment .data

segment .bss

segment .text
append:

;Prolog ===== Insurance for any caller of this assembly module ====================================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.

push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags




push qword 0        ;Staying in the boundary
;mov rax, 0

;Setting up the append function prototype append(arr1, s1, arr2, s2, arr3)
;Taking information from parameters
mov r15, rdi        ;pass first array as the first parameter
mov r14, rsi        ;pass the number of elements for the first array in the second parameter
mov r13, rdx        ;pass the second array as the third parameter 
mov r12, rcx        ;pass the number of elements for the second array as the fourth parameter
mov r11, r8         ;pass the third array as the fifth parameter


mov r10, 0  ;counter for the loop

;Loop the first array and second array to store the elements into the third array
initiateLoop:
cmp r10, r14        ;condition which compares the counter if it reaches the size of the first array 
je finishLoop       ;If the condition is met then jump to the end of the loop

movsd xmm15, [r15 + 8 * r10]        ;copy the first array elements into xmm15
movsd [r11 + 8 * r10], xmm15        ;copy the xmm15 elements into the third array
inc r10                            ;increment the loop counter
jmp initiateLoop

finishLoop:

mov r9, 0               ;initialize a new loop counter for the second loop

initiateLoop2:
cmp r9, r12         
je finishLoop2

movsd xmm15, [r13 + 8 * r9]     ;copy all the elements in the second array with r9 as the index into xmm15
movsd [r11 + 8 * r10], xmm15       ;copy all elements in xmm15 into the third array with r10 as the index from the first loop
inc r9                              ;increment the loop counter
inc r10                             ;increment the index for the third array to update the new elements added
jmp initiateLoop2

finishLoop2:

pop rax                     ;reverses the push qword 0 at the beginning of the program

mov rax, r10                   ;stores the number of elements for the third array and return it to the manager module


;===== Restore original values to integer registers ===============================================================================

popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret


;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**