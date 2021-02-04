/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_orient_test_for_coder_api.h
 *
 * Code generation for function '_coder_orient_test_for_coder_api'
 *
 */

#ifndef _CODER_ORIENT_TEST_FOR_CODER_API_H
#define _CODER_ORIENT_TEST_FOR_CODER_API_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void orient_test_for_coder(real_T acc_data[], int32_T acc_size[2], real_T
  gyro_data[], int32_T gyro_size[2], real_T magn_data[], int32_T magn_size[2],
  real_T eulfilt_data[], int32_T eulfilt_size[2]);
extern void orient_test_for_coder_api(const mxArray * const prhs[3], int32_T
  nlhs, const mxArray *plhs[1]);
extern void orient_test_for_coder_atexit(void);
extern void orient_test_for_coder_initialize(void);
extern void orient_test_for_coder_terminate(void);
extern void orient_test_for_coder_xil_shutdown(void);
extern void orient_test_for_coder_xil_terminate(void);

#endif

/* End of code generation (_coder_orient_test_for_coder_api.h) */
