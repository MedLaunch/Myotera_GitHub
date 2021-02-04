/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * orient_test_for_coder_initialize.c
 *
 * Code generation for function 'orient_test_for_coder_initialize'
 *
 */

/* Include files */
#include "orient_test_for_coder_initialize.h"
#include "orient_test_for_coder.h"
#include "orient_test_for_coder_data.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void orient_test_for_coder_initialize(void)
{
  rt_InitInfAndNaN();
  isInitialized_orient_test_for_coder = true;
}

/* End of code generation (orient_test_for_coder_initialize.c) */
