.globl main
.text

// program start
main:
    addi a0, a0, 9
    jal fib
    ebreak


// f(0) => 0
// f(1) => 1
// f(2) => 1
// f(n) => f(n-2) + f(n-1)
 
// in:
//    a0: n
// out:
//    a0: result
fib:
    addi t0, zero, 1
    addi t1, zero, 2
    blt a0, t0, doneZero
    beq a0, t0, doneOne
    beq a0, t1, doneOne
    
    addi sp, sp, -16
    sw ra, 0(sp)
    sw a0, 4(sp)

    // first rec
    addi a0, a0, -1
    jal fib

    // save first result to stack
    sw a0, 8(sp)

    // restore a0
    lw a0, 4(sp)

    addi a0, a0, -2
    // second rec
    jal fib

    // load prev result
    lw t0, 8(sp)
    // f(n-2) + f(n-1)
    add a0, a0, t0

    // load return address
    lw ra, 0(sp)

    addi sp, sp, 16
   
    ret

    doneZero:
        add a0, zero, zero
        ret
    doneOne:
        addi a0, zero, 1
        ret