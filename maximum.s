#Purpose: This program finds the maximum number of a set of data items
#Variables: The registers have the following uses:
# %edi - Holds the index of the data item being examined
# %ebx - Largest data item found
# %eax - Current data item

#The following memory locations are used:
#data_items - contains the item data. A 0 is used to terminate the data

.section .data

data_items:
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

.section .text

.globl _start
_start:
  movl $0, %edi                   #move 0 into the index register
  movl data_items(,%edi,4),%eax   #load the first byte of data
  movl %eax, %ebx                 #since this is the first item, %eax is the biggest

start_loop:
  cmpl $0, %eax                   #check to see if we've hit the end
  je loop_exit                    #if 0 and %eax are equal jump to loop_exit
  incl %edi                       #increment the index
  movl data_items(,%edi,4),%eax   #
  cmpl %ebx, %eax                 #compare values
  jle start_loop                  #jump to loop beginning if the new value is less than or bigger
  movl %eax, %ebx                 #move the value as the largest
  jmp start_loop                  #go back to the start

loop_exit:
  movl $1, %eax
  int $0x80


