    .text
    .global     min_data_vec_8
// void min_data_vec_8(int8_t *dest_data, int8_t *src1, int8_t *src2, int data_num);
// a0=dest, a1=src1, a2=src2, a3=n
//
min_data_vec_8:
    // mv      a3, a0          // Copy destination
.loop_8:
    vsetvli t0, a2, e8,m1,ta,ma   // Vectors of 8b
    vle8.v  v0, (a1)        // Load bytes
    add     a1, a1, t0  	// Bump pointer
    vle8.v  v1, (a2)        // Load bytes
    add     a2, a2, t0  	// Bump pointer
    sub     a3, a3, t0  	// Decrement count
    vmin.vv v2, v1, v0      // Vector Sub
    vse8.v  v2, (a0)    	// Store bytes
    add     a0, a0, t0  	// Bump pointer
    bnez    a3, .loop_8    	// Any more?
    ret                 	// Return

    .text
    .global     min_data_vec_16
// void min_data_vec_16(int16_t *dest_data, int16_t *src1, int16_t *src2, int data_num);
// a0=dest, a1=src1, a2=src2, a3=n
//
min_data_vec_16:
.loop_16:
    vsetvli t0, a2, e16,m1,ta,ma   // Vectors of 8b
    slli    t1, t0, 1       // shift 1-bit
    vle16.v v0, (a1)        // Load bytes
    add     a1, a1, t1  	// Bump pointer
    vle16.v v1, (a2)        // Load bytes
    add     a2, a2, t1  	// Bump pointer
    sub     a3, a3, t0  	// Decrement count
    vmin.vv v2, v1, v0      // Vector Sub
    vse16.v v2, (a0)    	// Store bytes
    add     a0, a0, t1  	// Bump pointer
    bnez    a3, .loop_16   	// Any more?
    ret                 	// Return


    .text
    .global     min_data_vec_32
// void min_data_vec_32(int32_t *dest_data, int32_t *src1, int32_t *src2, int data_num);
// a0=dest, a1=src1, a2=src2, a3=n
//
min_data_vec_32:
.loop_32:
    vsetvli t0, a2, e32,m1,ta,ma   // Vectors of 8b
    slli    t1, t0, 2       // shift 2-bit
    vle32.v v0, (a1)        // Load bytes
    add     a1, a1, t1  	// Bump pointer
    vle32.v v1, (a2)        // Load bytes
    add     a2, a2, t1  	// Bump pointer
    sub     a3, a3, t0  	// Decrement count
    vmin.vv v2, v1, v0      // Vector Sub
    vse32.v v2, (a0)    	// Store bytes
    add     a0, a0, t1  	// Bump pointer
    bnez    a3, .loop_32   	// Any more?
    ret                 	// Return


    .text
    .global     min_data_vec_64
// void min_data_vec_64(int64_t *dest_data, int64_t *src1, int64_t *src2, int data_num);
// a0=dest, a1=src1, a2=src2, a3=n
//
min_data_vec_64:
.loop_64:
    vsetvli t0, a2, e64,m1,ta,ma   // Vectors of 8b
    slli    t1, t0, 3       // shift 3-bit
    vle64.v v0, (a1)        // Load bytes
    add     a1, a1, t1  	// Bump pointer
    vle64.v v1, (a2)        // Load bytes
    add     a2, a2, t1  	// Bump pointer
    sub     a3, a3, t0  	// Decrement count
    vmin.vv v2, v1, v0      // Vector Sub
    vse64.v v2, (a0)    	// Store bytes
    add     a0, a0, t1  	// Bump pointer
    bnez    a3, .loop_64   	// Any more?
    ret                 	// Return
