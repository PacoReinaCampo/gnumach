-----------------------------------------------------------------------------------
--                                            __ _      _     _                  --
--                                           / _(_)    | |   | |                 --
--                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 --
--               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 --
--              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 --
--               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 --
--                  | |                                                          --
--                  |_|                                                          --
--                                                                               --
--                                                                               --
--              Peripheral-NTM for MPSoC                                         --
--              Neural Turing Machine for MPSoC                                  --
--                                                                               --
-----------------------------------------------------------------------------------

-----------------------------------------------------------------------------------
--                                                                               --
-- Copyright (c) 2020-2024 by the author(s)                                      --
--                                                                               --
-- Permission is hereby granted, free of charge, to any person obtaining a copy  --
-- of this software and associated documentation files (the "Software"), to deal --
-- in the Software without restriction, including without limitation the rights  --
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     --
-- copies of the Software, and to permit persons to whom the Software is         --
-- furnished to do so, subject to the following conditions:                      --
--                                                                               --
-- The above copyright notice and this permission notice shall be included in    --
-- all copies or substantial portions of the Software.                           --
--                                                                               --
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    --
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      --
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   --
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        --
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, --
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     --
-- THE SOFTWARE.                                                                 --
--                                                                               --
-- ============================================================================= --
-- Author(s):                                                                    --
--   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           --
--                                                                               --
-----------------------------------------------------------------------------------

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Numerics;
use Ada.Numerics;

with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

package body ntm_matrix_math is

  procedure ntm_matrix_logistic_function (
    data_in : in matrix;

    data_out : out matrix
  ) is
    ONE : constant float := 1.0;
  begin
    for i in data_out'Range(1) loop
      for j in data_out'Range(2) loop
        data_out(i, j) := ONE/(ONE + ONE/exp(data_in(i, j)));
      end loop;
    end loop;

  end ntm_matrix_logistic_function;

  procedure ntm_matrix_oneplus_function (
    data_in : in matrix;

    data_out : out matrix
  ) is
    ONE : constant float := 1.0;
  begin
    for i in data_out'Range(1) loop
      for j in data_out'Range(2) loop
        data_out(i, j) := ONE/(ONE + ONE/exp(data_in(i, j)));
      end loop;
    end loop;

  end ntm_matrix_oneplus_function;

  procedure ntm_matrix_mean_function (
    data_in : in tensor;

    data_out : out matrix
  ) is
  begin
    for i in data_out'Range(1) loop
      for j in data_out'Range(2) loop
        data_out(i, j) := 0.0;

        for k in data_in'Range(3) loop
          data_out(i, j) := data_out(i, j) + data_in(i, j, k) / float(data_in'Length(3));
        end loop;
      end loop;
    end loop;

  end ntm_matrix_mean_function;

  procedure ntm_matrix_deviation_function (
    data_in : in tensor;

    mean_in : in matrix;

    data_out : out matrix
  ) is
  begin
    for i in data_out'Range(1) loop
      for j in data_out'Range(2) loop
        data_out(i, j) := 0.0;

        for k in data_in'Range(3) loop
          data_out(i, j) := data_out(i, j) + (data_in(i, j, k) - mean_in(i, j)) * (data_in(i, j, k) - mean_in(i, j)) / float(data_in'Length(3)-1);
        end loop;
      end loop;
    end loop;

  end ntm_matrix_deviation_function;

end ntm_matrix_math;
