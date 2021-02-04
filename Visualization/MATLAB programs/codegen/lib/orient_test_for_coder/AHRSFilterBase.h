/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AHRSFilterBase.h
 *
 * Code generation for function 'AHRSFilterBase'
 *
 */

#ifndef AHRSFILTERBASE_H
#define AHRSFILTERBASE_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "orient_test_for_coder_types.h"

/* Function Declarations */
extern void AHRSFilterBase_stepImpl(c_fusion_internal_coder_ahrsfil *obj, const
  double accelIn_data[], const int accelIn_size[2], const double gyroIn_data[],
  const int gyroIn_size[2], const double magIn_data[], const int magIn_size[2],
  double orientOut_a_data[], int orientOut_a_size[1], double orientOut_b_data[],
  int orientOut_b_size[1], double orientOut_c_data[], int orientOut_c_size[1],
  double orientOut_d_data[], int orientOut_d_size[1]);

#endif

/* End of code generation (AHRSFilterBase.h) */
