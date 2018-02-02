# Copyright (c) 2017 
#   Authors: Daniel Garcia Vaglio, Javier Peralta Saenz
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.

#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.

#   You should have received a copy of the GNU General Public License
#   along with this program. If not, see <http://www.gnu.org/licenses/>

#// R29 stack pointer	
#// R31 return address

INITIAL_STACK_POINTER = 511	
	
init:
	NOP
	NOP
	NOP
	NOP
	#// Set inital stack pointer
	ADDI, R29, R0, INITIAL_STACK_POINTER
	#// SET initial value of loop
	ADDI, R6, R0, 0
	ADDI, R1, R0, 0
	#// Set loop limit
	ADDI, R2, R0, 65534
	ADDI, R7, R0, 100
	#// Set inital value to display
	ADDI, R3, R0, 1
	#// Set previous value displayed
	ADDI, R4, R0, 1
	NOP
	NOP

big_wait_loop:
	ADDI, R1, R0, 0
	NOP
	NOP
	NOP
	NOP
	NOP
	

wait_loop:
	ADDI, R1, R1, 1
	NOP
	NOP
	NOP
	NOP
	NOP
	
	BNE, R1, R2, wait_loop
#// out of the loop
	NOP
	ADDI, R6, R6, 1
	NOP
	NOP
	NOP
	NOP
	NOP
	BNE, R6, R7, big_wait_loop
	NOP

	#// calculate next fibonacci
	ADDI, R5, R3, 0
	#// Reset counter
	ADDI, R1, R0, 0
	ADDI, R6, R0, 0
	NOP
	ADD, R3, R3, R4
	NOP
	NOP
	ADDI, R4, R5, 0

	NOP
	NOP
	NOP
	NOP
	NOP
	#// Display value
	LED, R3
	NOP
	NOP
	J, big_wait_loop
	NOP
	NOP
	NOP
	NOP
	NOP
	
	
