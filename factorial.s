#PURPOSE: Given a number, this program computes the factorial.
#This program uses recursion

.section .data

#This program has no global data

.section .text

.globl _start
.globl factorial

_start:
pushl $4          #This program takes one argument. The number we want the factorial of.
call factorial    #run the factorial function

addl $4, %esp     #removes the parameter that was pushed on the stack
movl %eax, %ebx   #factorial returns the answer in %eax, but we want it in %ebx to send it as our exit status

movl $1, %eax     #call the kernel's exit function
int $0x80

#define the factorial function
.type factorial, @function
factorial:
pushl %ebp       #restore base pointer to its prior state by pushing it
movl %esp, %ebp  #we use %ebp since we don't want to modify the stack pointer
movl 8(%ebp), %eax  #This is a pointer to the first argument and moves it to %eax

cmpl $1, %eax   #if the number is one then we end the function here
je end_factorial

decl %eax       #decrease the value of the argument
pushl %eax      #push it on to the stack for our call to factorial
call factorial

movl 8(%ebp), %ebx  #%eax holds the return value so we reload our argument into %ebx
imull %ebx, %eax    #multiply that by the result of the last call to factorial

end_factorial:
movl %ebp, %esp     #restore %ebp and %esp to where they were before the function started
popl %ebp

ret
