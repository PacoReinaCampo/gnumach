///////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _                  //
//                                           / _(_)    | |   | |                 //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 //
//                  | |                                                          //
//                  |_|                                                          //
//                                                                               //
//                                                                               //
//              Peripheral-NTM for MPSoC                                         //
//              Neural Turing Machine for MPSoC                                  //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
// Copyright (c) 2020-2024 by the author(s)                                      //
//                                                                               //
// Permission is hereby granted, free of charge, to any person obtaining a copy  //
// of this software and associated documentation files (the "Software"), to deal //
// in the Software without restriction, including without limitation the rights  //
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     //
// copies of the Software, and to permit persons to whom the Software is         //
// furnished to do so, subject to the following conditions:                      //
//                                                                               //
// The above copyright notice and this permission notice shall be included in    //
// all copies or substantial portions of the Software.                           //
//                                                                               //
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    //
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      //
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   //
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        //
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, //
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     //
// THE SOFTWARE.                                                                 //
//                                                                               //
// ============================================================================= //
// Author(s):                                                                    //
//   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////

#include "systemc.h"
#include "ntm_tensor_multiplier_design.cpp"

int sc_main(int argc, char *argv[]) {
  tensor_multiplier tensor_multiplier("TENSOR_ADDER");

  sc_signal<bool> clock;
  sc_signal<sc_int<64>> data_a_in[SIZE_I_IN][SIZE_J_IN][SIZE_K_IN];
  sc_signal<sc_int<64>> data_b_in[SIZE_I_IN][SIZE_J_IN][SIZE_K_IN];
  sc_signal<sc_int<64>> data_out[SIZE_I_IN][SIZE_J_IN][SIZE_K_IN];

  tensor_multiplier.clock(clock);

  for (int i=0; i<SIZE_I_IN; i++) {
    for (int j=0; j<SIZE_J_IN; j++) {
      for (int k=0; k<SIZE_K_IN; k++) {
        tensor_multiplier.data_a_in[i][j][k](data_a_in[i][j][k]);
        tensor_multiplier.data_b_in[i][j][k](data_b_in[i][j][k]);

        tensor_multiplier.data_out[i][j][k](data_out[i][j][k]);
      }
    }
  }

  for (int i=0; i<SIZE_I_IN; i++) {
    for (int j=0; j<SIZE_J_IN; j++) {
      for (int k=0; k<SIZE_K_IN; k++) {
        data_a_in[i][j][k] = i + j + k;
        data_b_in[i][j][k] = i - j + k;
      }
    }
  }

  clock = 0;
  sc_start(1, SC_NS);
  clock = 1;
  sc_start(1, SC_NS);

  for (int i=0; i<SIZE_I_IN; i++) {
    for (int j=0; j<SIZE_J_IN; j++) {
      for (int k=0; k<SIZE_K_IN; k++) {
        cout << "@" << sc_time_stamp() << ": data_out[" << i << ", " << j << ", " << k << "] = " << data_out[i][j][k].read() << endl;
      }
    }
  }

  return 0;
}
