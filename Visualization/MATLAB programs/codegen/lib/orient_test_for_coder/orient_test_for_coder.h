/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * orient_test_for_coder.h
 *
 * Code generation for function 'orient_test_for_coder'
 *
 */

#ifndef ORIENT_TEST_FOR_CODER_H
#define ORIENT_TEST_FOR_CODER_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "orient_test_for_coder_types.h"

/* Function Declarations */
extern void orient_test_for_coder(const double acc_data[], const int acc_size[2],
  const double gyro_data[], const int gyro_size[2], const double magn_data[],
  const int magn_size[2], double eulfilt_data[], int eulfilt_size[2]);

#endif

/* End of code generation (orient_test_for_coder.h) */
