/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * mrdivide_helper.c
 *
 * Code generation for function 'mrdivide_helper'
 *
 */

/* Include files */
#include "mrdivide_helper.h"
#include "orient_test_for_coder.h"
#include "rt_nonfinite.h"
#include <math.h>
#include <string.h>

/* Function Definitions */
void mrdiv(double A[72], const double B[36])
{
  double b_A[36];
  int i;
  int j;
  signed char ipiv[6];
  int mmj_tmp;
  int kBcol;
  int iy;
  int jj;
  int jA;
  int jp1j;
  int k;
  double smax;
  int ix;
  int i1;
  double s;
  memcpy(&b_A[0], &B[0], 36U * sizeof(double));
  for (i = 0; i < 6; i++) {
    ipiv[i] = (signed char)(i + 1);
  }

  for (j = 0; j < 5; j++) {
    mmj_tmp = 4 - j;
    kBcol = j * 7;
    jj = j * 7;
    jp1j = kBcol + 2;
    iy = 6 - j;
    jA = 0;
    ix = kBcol;
    smax = fabs(b_A[jj]);
    for (k = 2; k <= iy; k++) {
      ix++;
      s = fabs(b_A[ix]);
      if (s > smax) {
        jA = k - 1;
        smax = s;
      }
    }

    if (b_A[jj + jA] != 0.0) {
      if (jA != 0) {
        iy = j + jA;
        ipiv[j] = (signed char)(iy + 1);
        ix = j;
        for (k = 0; k < 6; k++) {
          smax = b_A[ix];
          b_A[ix] = b_A[iy];
          b_A[iy] = smax;
          ix += 6;
          iy += 6;
        }
      }

      i = (jj - j) + 6;
      for (ix = jp1j; ix <= i; ix++) {
        b_A[ix - 1] /= b_A[jj];
      }
    }

    iy = kBcol + 6;
    jA = jj;
    for (kBcol = 0; kBcol <= mmj_tmp; kBcol++) {
      smax = b_A[iy];
      if (b_A[iy] != 0.0) {
        ix = jj + 1;
        i = jA + 8;
        i1 = (jA - j) + 12;
        for (jp1j = i; jp1j <= i1; jp1j++) {
          b_A[jp1j - 1] += b_A[ix] * -smax;
          ix++;
        }
      }

      iy += 6;
      jA += 6;
    }
  }

  for (j = 0; j < 6; j++) {
    iy = 12 * j - 1;
    jA = 6 * j;
    for (k = 0; k < j; k++) {
      kBcol = 12 * k;
      i = k + jA;
      if (b_A[i] != 0.0) {
        for (ix = 0; ix < 12; ix++) {
          i1 = (ix + iy) + 1;
          A[i1] -= b_A[i] * A[ix + kBcol];
        }
      }
    }

    smax = 1.0 / b_A[j + jA];
    for (ix = 0; ix < 12; ix++) {
      i = (ix + iy) + 1;
      A[i] *= smax;
    }
  }

  for (j = 5; j >= 0; j--) {
    iy = 12 * j - 1;
    jA = 6 * j - 1;
    i = j + 2;
    for (k = i; k < 7; k++) {
      kBcol = 12 * (k - 1);
      i1 = k + jA;
      if (b_A[i1] != 0.0) {
        for (ix = 0; ix < 12; ix++) {
          jp1j = (ix + iy) + 1;
          A[jp1j] -= b_A[i1] * A[ix + kBcol];
        }
      }
    }
  }

  for (j = 4; j >= 0; j--) {
    if (ipiv[j] != j + 1) {
      for (ix = 0; ix < 12; ix++) {
        iy = ix + 12 * j;
        smax = A[iy];
        i = ix + 12 * (ipiv[j] - 1);
        A[iy] = A[i];
        A[i] = smax;
      }
    }
  }
}

/* End of code generation (mrdivide_helper.c) */
