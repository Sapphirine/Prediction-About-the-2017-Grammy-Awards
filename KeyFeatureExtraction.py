#!/usr/bin/env python
# -*- coding: utf-8 -*-
import numpy as np
from pycuda import driver, compiler, gpuarray, tools
import time
# initialize the device
import pycuda.autoinit

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt 




data = np.memmap('us_billboad.psv', dtype=np.uint16)




kernel = """
__global__ void func1(unsigned int *raw, unsigned int *Library){
	// input the constant
    const unsigned int P = %(P)s;
    unsigned int k;
    // use shred memory to accelerate the speed
    volatile __shared__ unsigned int library_loc[100];
    unsigned int i = blockIdx.x*blockDim.x+threadIdx.x;

    for (k=0; k<100; k++)
        library_loc[k] = 0;
    for (k=0; k<P; k++)
        ++bins_loc[img[i*P+k]];
    // Set the barrier for all the threads
    __syncthreads();
    for (k=0; k<256; k++)
        // Use atomic addition.
        atomicAdd(&bins[k],bins_loc[k]);
}


__global__ void BP(unsigned int *chart, unsigned int *bin, unsigned int *back){
	int FH;
	int Pvalue;
    int x = blockIdx.y * TILE_SIZE + threadIdx.x;
    int y = blockIdx.x * TILE_SIZE + threadIdx.y;
    if (x < MATRIX_LENGTH && y < MATRIX_WIDTH)
	    FH = chart[y*(MATRIX_LENGTH)+x];
    __syncthreads();

	if (x < MATRIX_LENGTH && y < MATRIX_WIDTH)
	    Pvalue = bin[FH];
	__syncthreads();

	if (x < MATRIX_LENGTH && y < MATRIX_WIDTH)
	    back[y*(MATRIX_LENGTH)+x] = Pvalue;
	__syncthreads();

}


"""


P = 100
C = 1000
N = R*C

kernel_code = kernel %{
        'N':N,
        'P':P,
    }

    # Compile the kernel code
mod = compiler.SourceModule(kernel_code)
    # Get the kernel function from the compile module
func1 = mod.get_function("func1")
func2 = mod.get_function("BP")


    #########################################################
    # Initialize input memory for later GPU calculation. 
img_gpu = gpuarray.to_gpu(img)


    #########################################################
bins_gpu = gpuarray.zeros(256, np.uint32)
func1(
    # inputs
    img_gpu,
    # output
    bins_gpu,
    # Define the grid and block   
    grid = (N/P,1,1),
    block = (1,1,1),
    )

    #########################################################
func2(
    # inputs
    img_gpu,
    # output
    bins_gpu,  
    grid = (N/500,1,1),
    block = (500,1,1),
    )

    #########################################################
func2(
    # inputs
    img_gpu,
    # output
    bins_gpu,
    # Define the grid and block   
    grid = (N/750,1),
    block = (750,1,1),
    )


    #########################################################
func2(
    # inputs
    img_gpu,
    # output
    bins_gpu,
    # Change the grid & block size in op3  
    grid = (N/1000,1,1),
    block = (1000,1,1),
    )

# plotPict()

