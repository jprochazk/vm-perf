pub mod goto;
pub mod switch;
pub mod tail;

/* fn fib(n):
  if n <= 1:
    return n
  else:
    return fib(n - 2) + fib(n - 1)

fib(20) */

/*

# register

ldi #dst, #n
tlt #lhs, #rhs
jif #label
jl #header
add #dst, #lhs, #rhs
addc #dst, #lhs, #n
mov #src, #dst
ret #src

  ldi r1, 0
  ldi r2, 1
  ldi r3, 0
loop:
  tlt r3, r0
  jif end
  add r4, r1, r2
  mov r2, r1
  mov r4, r2
  addc r3, r3, 1
  jl loop
end:
  ret r1

# register with accumulator

ldr #reg
str #reg
ldi #n
tlt #rhs
jif #label
jl #header
add #rhs
addc #n
mov #src, #dst
ret

  ldi 0
  str r1
  ldi 1
  str r2
  ldi 0
  str r3
loop:
  ldr r3
  tlt r0
  jif end
  ldr r2
  add r1
  str r4
  mov r2, r1
  mov r4, r2
  ldr r3
  addc 1
  str r3
  jl loop
end:
  ldr r1
  ret

# stack

ldi #n
ld #i
st #i
dup #i
pop
tlt
jif #label
jl
add
addc #n

  ldi 0
  ldi 1
  ldi 0
loop:
  ld #3
  ld #0
  tlt
  jif end
  ld #1
  ld #2
  add
  dup #2
  st #1
  dup #4
  st #2
  ld #3
  addc 1
  st #3
  pop 1
  jl loop
end:
  ld #1
  ret
*/
