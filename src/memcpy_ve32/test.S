    .text
    .global     copy_data_vec
// void *memcpy(void* dest, const void* src, size_t n)
// a0=dest, a1=src, a2=n
//
copy_data_vec:
    mv      a3, a0          // Copy destination
_loop:
    vsetvli t0, a2, e32,m1,ta,ma  // Vectors of 8b
    slli    t1, t0, 2       // shift 2-bit
    vle32.v v0, (a1)        // Load bytes
    add     a1, a1, t1  	// Bump pointer
    sub     a2, a2, t0  	// Decrement count
    vse32.v v0, (a3)    	// Store bytes
    add     a3, a3, t1  	// Bump pointer
    bnez    a2, _loop    	// Any more?
    ret                 	// Return


    .global     copy_data_mask_vec
// void copy_data_mask_vec(int16_t *dest_data, int16_t *source_data, int16_t *mask, int data_num);
// a0=dest, a1=src, a2=n
//
copy_data_mask_vec:
    li      t1, 2           // calculate element length of mask, VLEN=512 / ELEN=32 / 8-bit
_loop_mask:
    vsetvli t0, t1, e8,m1,ta,ma   // Vectors of 8b
    vle8.v  v0, (a2)
    add     a2, a2, t0

    vsetvli t0, a3, e32,m1,ta,ma  // Vectors of 8b
    slli    t2, t0, 2
    vle32.v v1, (a1), v0.t  // Load bytes
    add     a1, a1, t2  	// Bump pointer
    sub     a3, a3, t0  	// Decrement count
    vse32.v v1, (a0), v0.t 	// Store bytes
    add     a0, a0, t2  	// Bump pointer
    bnez    a3, _loop_mask 	// Any more?
    ret                 	// Return
