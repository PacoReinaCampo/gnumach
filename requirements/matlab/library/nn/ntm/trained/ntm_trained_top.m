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

function Y_OUT = ntm_trained_top(X_IN)
  # Constants
  LENGTH_IN = 3;

  SIZE_T_IN = 3;
  SIZE_X_IN = 3;
  SIZE_Y_IN = 3;
  SIZE_N_IN = 3;
  SIZE_W_IN = 3;
  SIZE_L_IN = 3;
  SIZE_R_IN = 3;

  SIZE_S_IN = 2*SIZE_W_IN;
  SIZE_M_IN = SIZE_N_IN + SIZE_W_IN + 3;

  # Signals
  P_IN = rand(SIZE_R_IN, SIZE_Y_IN, SIZE_W_IN);
  Q_IN = rand(SIZE_Y_IN, SIZE_L_IN);

  w_int = rand(SIZE_L_IN, SIZE_X_IN);
  k_int = rand(SIZE_R_IN, SIZE_L_IN, SIZE_X_IN);
  v_int = rand(SIZE_L_IN, SIZE_S_IN);
  d_int = rand(SIZE_R_IN, SIZE_L_IN, SIZE_M_IN);
  u_int = rand(SIZE_L_IN, SIZE_L_IN);
  b_int = rand(SIZE_L_IN, 1);

  # Body
  [Y_OUT, R_OUT, XI_OUT, RHO_OUT, H_OUT] = ntm_interface_top(w_int, k_int, v_int, d_int, u_int, b_int, P_IN, Q_IN, X_IN);

  [w_int, k_int, v_int, d_int, u_int, b_int] = ntm_fnn_trainer(X_IN, R_OUT, XI_OUT, RHO_OUT, H_OUT, LENGTH_IN);

  [Y_OUT, R_OUT, XI_OUT, RHO_OUT, H_OUT] = ntm_interface_top(w_int, k_int, v_int, d_int, u_int, b_int, P_IN, Q_IN, X_IN);
end
