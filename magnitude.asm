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
;  File name: magnitude.asm
;  Language: X86 with Intel syntax.
;  Max page width: 132 columns
;  Assemble: nasm -f elf64 -l magnitude.lis -o magnitude.o magnitude.asm

;========= Begin Code ===========

global magnitude


segment .data

segment .bss

segment .text

magnitude:

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



push qword 0                ;Set the boundary 
;Take information from parameters
mov r14, rdi                ;pass the array as the first parameter
mov r13, rsi                ;pass the number of elements in the array as the second parameter



;Loop the array so each element is squared and added together before taking the square root based on the user's input
mov rax, 2                  ;access two SSE registers for use

mov rdx, 0                  ;copy 0 into rdx
mov rcx, 0                  ;copy 0 into rcx

cvtsi2sd xmm14, rdx         ;converts the 0 in rdx to something xmm14 can read
cvtsi2sd xmm13, rcx         ;converts the 0 in rcx to something xmm13 can read

mov r12, 0 ; for loop counter
startLoop:

cmp r12, r13            ;condition to compare the loop counter to the number of elements in the array
je endLoop
movsd xmm14, [r14 + 8 * r12]        ;copy the elements in the array into xmm14
mulsd xmm14, xmm14                  ;the elements are getting squared and stored into xmm14
addsd xmm13, xmm14                  ;the elements are all added then copied into xmm13
inc r12                             ;increment the loop
jmp startLoop

endLoop:
sqrtsd xmm13, xmm13                 ;take the square root of the value and store it into xmm13

pop rax                                ;reverses the push qword 0 at the beginning of the program

movsd xmm0, xmm13                       ;the magnitude stored in xmm13 is copied into xmm0 for it to be returned to the manager module

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





