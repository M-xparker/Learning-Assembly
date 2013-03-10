#PURPOSE: this program computes the square of a given number

.section .data
#no global data

.section .text

.globl _start
.globl square

_start:
pushl $3        #parameter being squared
call square

addl $4, %esp
movl %eax, %ebx

movl $1, %eax
int $0x80

.type square, @function
square:
pushl %ebp
movl %esp, %ebp
movl 8(%ebp), %eax

imull %eax, %eax

movl %ebp, %esp
pop %ebp
ret
