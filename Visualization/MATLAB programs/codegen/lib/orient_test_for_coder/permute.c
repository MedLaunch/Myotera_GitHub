/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * permute.c
 *
 * Code generation for function 'permute'
 *
 */

/* Include files */
#include "permute.h"
#include "orient_test_for_coder.h"
#include "rt_nonfinite.h"
#include <string.h>

/* Function Definitions */
void permute(const double a_data[], const int a_size[3], double b_data[], int
             b_size[3])
{
  boolean_T b;
  int plast;
  int k;
  boolean_T exitg1;
  static const signed char b_iv[3] = { 2, 1, 3 };

  b = true;
  if (a_size[2] != 0) {
    plast = 0;
    k = 0;
    exitg1 = false;
    while ((!exitg1) && (k < 3)) {
      if (a_size[b_iv[k] - 1] != 1) {
        if (plast > b_iv[k]) {
          b = false;
          exitg1 = true;
        } else {
          plast = b_iv[k];
          k++;
        }
      } else {
        k++;
      }
    }
  }

  if (b) {
    b_size[0] = 1;
    b_size[1] = 3;
    b_size[2] = a_size[2];
    plast = 3 * a_size[2];
    if (0 <= plast - 1) {
      memcpy(&b_data[0], &a_data[0], plast * sizeof(double));
    }
  } else {
    b_size[0] = 1;
    b_size[1] = 3;
    b_size[2] = a_size[2];
    plast = a_size[2];
    if (0 <= plast - 1) {
      b_data[0] = a_data[0];
      b_data[1] = a_data[1];
      b_data[2] = a_data[2];
    }
  }
}

/* End of code generation (permute.c) */
