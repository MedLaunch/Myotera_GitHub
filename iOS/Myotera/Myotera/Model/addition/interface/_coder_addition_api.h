/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_addition_api.h
 *
 * Code generation for function '_coder_addition_api'
 *
 */

#ifndef _CODER_ADDITION_API_H
#define _CODER_ADDITION_API_H

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
extern real_T addition(real_T in1, real_T in2);
extern void addition_api(const mxArray * const prhs[2], int32_T nlhs, const
  mxArray *plhs[1]);
extern void addition_atexit(void);
extern void addition_initialize(void);
extern void addition_terminate(void);
extern void addition_xil_shutdown(void);
extern void addition_xil_terminate(void);

#endif

/* End of code generation (_coder_addition_api.h) */
