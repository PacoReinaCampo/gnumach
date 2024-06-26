###################################################################################
##                                            __ _      _     _                  ##
##                                           / _(_)    | |   | |                 ##
##                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 ##
##               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 ##
##              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 ##
##               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 ##
##                  | |                                                          ##
##                  |_|                                                          ##
##                                                                               ##
##                                                                               ##
##              Peripheral-NTM for MPSoC                                         ##
##              Neural Turing Machine for MPSoC                                  ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2020-2024 by the author(s)                                      ##
##                                                                               ##
## Permission is hereby granted, free of charge, to any person obtaining a copy  ##
## of this software and associated documentation files (the "Software"), to deal ##
## in the Software without restriction, including without limitation the rights  ##
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     ##
## copies of the Software, and to permit persons to whom the Software is         ##
## furnished to do so, subject to the following conditions:                      ##
##                                                                               ##
## The above copyright notice and this permission notice shall be included in    ##
## all copies or substantial portions of the Software.                           ##
##                                                                               ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   ##
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, ##
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     ##
## THE SOFTWARE.                                                                 ##
##                                                                               ##
## ============================================================================= ##
## Author(s):                                                                    ##
##   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           ##
##                                                                               ##
###################################################################################

warning('off','all');

# Package
addpath(genpath('../../../../library/algebra/vector'));
addpath(genpath('../../../../library/algebra/matrix'));
addpath(genpath('../../../../library/algebra/tensor'));
addpath(genpath('../../../../library/math/matrix'));
addpath(genpath('../../../../library/math/vector'));

addpath(genpath('../../../../library/nn/fnn/standard'));

addpath(genpath('../../../../library/nn/ntm/memory'));
addpath(genpath('../../../../library/nn/ntm/read_heads'));
addpath(genpath('../../../../library/nn/ntm/write_heads'));
addpath(genpath('../../../../library/nn/ntm/top'));

# Constants
SIZE_T_IN = 3;
SIZE_X_IN = 3;
SIZE_Y_IN = 3;
SIZE_N_IN = 3;
SIZE_W_IN = 3;
SIZE_L_IN = 3;
SIZE_R_IN = 3;

SIZE_M_IN = SIZE_N_IN + SIZE_W_IN + 3;
SIZE_S_IN = 2*SIZE_W_IN;

# Signals
W_IN = rand(SIZE_L_IN, SIZE_X_IN);
K_IN = rand(SIZE_R_IN, SIZE_L_IN, SIZE_W_IN);
V_IN = rand(SIZE_L_IN, SIZE_S_IN);
D_IN = rand(SIZE_R_IN, SIZE_L_IN, SIZE_M_IN);
U_IN = rand(SIZE_L_IN, SIZE_L_IN);
B_IN = rand(SIZE_L_IN, 1);
P_IN = rand(SIZE_R_IN, SIZE_Y_IN, SIZE_W_IN);
Q_IN = rand(SIZE_Y_IN, SIZE_L_IN);

X_IN = rand(SIZE_T_IN, SIZE_X_IN);

# DUT
[Y_OUT, R_OUT, XI_OUT, RHO_OUT, H_OUT] = ntm_interface_top(W_IN, K_IN, V_IN, D_IN, U_IN, B_IN, P_IN, Q_IN, X_IN);
