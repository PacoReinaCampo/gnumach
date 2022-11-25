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
## Copyright (c) 2022-2023 by the author(s)                                      ##
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

import math
import numpy as np 

class TensorMathCalculus:
  def __init__(self, data_in, length_in, length_i_in, length_j_in, length_k_in, control):
    self.data_in = data_in

    self.length_in = length_in

    self.length_i_in = length_i_in
    self.length_j_in = length_j_in
    self.length_k_in = length_k_in

    self.control = control

  def ntm_tensor_differentiation(self):
    temporal = 0.0

    data_out = []

    # calculating differentiation
    for i in range(len(data_in)):
      data_out.append([])
      for j in range(len(data_in[i])):
        data_out[i].append([])
        for k in range(len(data_in[i][j])):
          if control == 0:
            temporal = (data_in[i][j][k] - data_in[i-1][j][k])/length_i_in
          elif control == 1:
            temporal = (data_in[i][j][k] - data_in[i][j-1][k])/length_j_in
        else:
            temporal = (data_in[i][j][k] - data_in[i][j][k-1])/length_k_in

            data_out[i][j].append(temporal)

    return data_out

  def ntm_tensor_integration(self):
    temporal = 0.0

    data_out = []

    # calculating integration
    for i in range(len(data_in)):
      data_out.append([])
      for j in range(len(data_in[i])):
        data_out[i].append([])
        for k in range(len(data_in[i][j])):
          temporal += data_in[i][j][k]

          data_out[i][j].append(temporal*length_in)

    return data_out

  def ntm_tensor_softmax(self):
    temporal0 = 0.0
    temporal1 = 0.0

    inputs = np.array(data_in)

    data_int = []

    data_out = []

    # calculating softmax
    for i in range(len(data_in)):
      data_int.append([])
      data_out.append([])
      for j in range(len(data_in[i])):
        data_int[i].append([])
        data_out[i].append([])
        for k in range(len(data_in[i][j])):
          temporal0 += math.exp(data_in[i][j][k])

          temporal1 = math.exp(data_in[i][j][k])

          data_int[i][j].append(temporal1)

        for k in range(len(data_in[i][j])):
          data_out[i][j].append(data_int[i][j][k]/temporal0)

    return data_out


control = 0

length_in = 1.0

length_i_in = 1.0
length_j_in = 1.0
length_k_in = 1.0

data_in = np.random.rand(3,3,3)


math_calculus = TensorMathCalculus(data_in, length_in, length_i_in, length_j_in, length_k_in, control)
test_calculus = TensorMathCalculus(data_in, length_in, length_i_in, length_j_in, length_k_in, control)


np.testing.assert_array_equal(math_calculus.ntm_tensor_differentiation(), test_calculus.ntm_tensor_differentiation())

np.testing.assert_array_equal(math_calculus.ntm_tensor_integration(), test_calculus.ntm_tensor_integration())

np.testing.assert_array_equal(math_calculus.ntm_tensor_softmax(), test_calculus.ntm_tensor_softmax())