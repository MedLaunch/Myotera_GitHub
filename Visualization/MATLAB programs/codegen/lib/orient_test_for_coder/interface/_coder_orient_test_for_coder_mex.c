/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_orient_test_for_coder_mex.c
 *
 * Code generation for function '_coder_orient_test_for_coder_mex'
 *
 */

/* Include files */
#include "_coder_orient_test_for_coder_mex.h"
#include "_coder_orient_test_for_coder_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void c_orient_test_for_coder_mexFunc(int32_T nlhs, mxArray
  *plhs[1], int32_T nrhs, const mxArray *prhs[3]);

/* Function Definitions */
void c_orient_test_for_coder_mexFunc(int32_T nlhs, mxArray *plhs[1], int32_T
  nrhs, const mxArray *prhs[3])
{
  const mxArray *outputs[1];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 3, 4,
                        21, "orient_test_for_coder");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 21,
                        "orient_test_for_coder");
  }

  /* Call the function. */
  orient_test_for_coder_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  emlrtReturnArrays(1, plhs, outputs);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  mexAtExit(&orient_test_for_coder_atexit);

  /* Module initialization. */
  orient_test_for_coder_initialize();

  /* Dispatch the entry-point. */
  c_orient_test_for_coder_mexFunc(nlhs, plhs, nrhs, prhs);

  /* Module termination. */
  orient_test_for_coder_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_orient_test_for_coder_mex.c) */
