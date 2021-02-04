/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * NED.c
 *
 * Code generation for function 'NED'
 *
 */

/* Include files */
#include "NED.h"
#include "orient_test_for_coder.h"
#include "rt_nonfinite.h"
#include <math.h>
#include <string.h>

/* Function Definitions */
void NED_ecompass(const double a[3], const double m[3], double R[9])
{
  double Reast[3];
  int i;
  double x[9];
  int xpageoffset;
  boolean_T y[3];
  boolean_T b[9];
  boolean_T exitg1;
  boolean_T nanPageIdx;
  Reast[0] = a[1] * m[2] - a[2] * m[1];
  Reast[1] = a[2] * m[0] - a[0] * m[2];
  Reast[2] = a[0] * m[1] - a[1] * m[0];
  R[6] = a[0];
  R[3] = Reast[0];
  R[7] = a[1];
  R[4] = Reast[1];
  R[8] = a[2];
  R[5] = Reast[2];
  R[0] = Reast[1] * a[2] - Reast[2] * a[1];
  R[1] = Reast[2] * a[0] - Reast[0] * a[2];
  R[2] = Reast[0] * a[1] - Reast[1] * a[0];
  for (i = 0; i < 9; i++) {
    x[i] = R[i] * R[i];
  }

  for (i = 0; i < 3; i++) {
    xpageoffset = i * 3;
    Reast[i] = sqrt((x[xpageoffset] + x[xpageoffset + 1]) + x[xpageoffset + 2]);
  }

  memcpy(&x[0], &R[0], 9U * sizeof(double));
  for (i = 0; i < 3; i++) {
    R[3 * i] = x[3 * i] / Reast[i];
    xpageoffset = 3 * i + 1;
    R[xpageoffset] = x[xpageoffset] / Reast[i];
    xpageoffset = 3 * i + 2;
    R[xpageoffset] = x[xpageoffset] / Reast[i];
  }

  for (i = 0; i < 9; i++) {
    b[i] = rtIsNaN(R[i]);
  }

  y[0] = false;
  y[1] = false;
  y[2] = false;
  i = 1;
  exitg1 = false;
  while ((!exitg1) && (i <= 3)) {
    if (!b[i - 1]) {
      i++;
    } else {
      y[0] = true;
      exitg1 = true;
    }
  }

  i = 4;
  exitg1 = false;
  while ((!exitg1) && (i <= 6)) {
    if (!b[i - 1]) {
      i++;
    } else {
      y[1] = true;
      exitg1 = true;
    }
  }

  i = 7;
  exitg1 = false;
  while ((!exitg1) && (i <= 9)) {
    if (!b[i - 1]) {
      i++;
    } else {
      y[2] = true;
      exitg1 = true;
    }
  }

  nanPageIdx = false;
  i = 0;
  exitg1 = false;
  while ((!exitg1) && (i < 3)) {
    if (!y[i]) {
      i++;
    } else {
      nanPageIdx = true;
      exitg1 = true;
    }
  }

  if (nanPageIdx) {
    memset(&R[0], 0, 9U * sizeof(double));
    R[0] = 1.0;
    R[4] = 1.0;
    R[8] = 1.0;
  }
}

/* End of code generation (NED.c) */
