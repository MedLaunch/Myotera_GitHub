/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * IMUFusionCommon.h
 *
 * Code generation for function 'IMUFusionCommon'
 *
 */

#ifndef IMUFUSIONCOMMON_H
#define IMUFUSIONCOMMON_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "rtwtypes.h"
#include "orient_test_for_coder_types.h"

/* Function Declarations */
extern void c_IMUFusionCommon_predictOrient(const
  c_fusion_internal_coder_ahrsfil *obj, const double gfast[3], const double
  offset[3], c_matlabshared_rotations_intern *qorient);

#endif

/* End of code generation (IMUFusionCommon.h) */
