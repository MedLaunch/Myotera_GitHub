/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * orient_test_for_coder_types.h
 *
 * Code generation for function 'orient_test_for_coder_types'
 *
 */

#ifndef ORIENT_TEST_FOR_CODER_TYPES_H
#define ORIENT_TEST_FOR_CODER_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef typedef_c_matlabshared_rotations_intern
#define typedef_c_matlabshared_rotations_intern

typedef struct {
  double a;
  double b;
  double c;
  double d;
} c_matlabshared_rotations_intern;

#endif                                 /*typedef_c_matlabshared_rotations_intern*/

#ifndef typedef_cell_wrap_2
#define typedef_cell_wrap_2

typedef struct {
  unsigned int f1[8];
} cell_wrap_2;

#endif                                 /*typedef_cell_wrap_2*/

#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  double *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef typedef_c_fusion_internal_coder_ahrsfil
#define typedef_c_fusion_internal_coder_ahrsfil

typedef struct {
  int isInitialized;
  boolean_T TunablePropsChanged;
  cell_wrap_2 inputVarSize[3];
  double AccelerometerNoise;
  double GyroscopeNoise;
  double GyroscopeDriftNoise;
  double LinearAccelerationNoise;
  double LinearAccelerationDecayFactor;
  double pQw[144];
  double pQv[36];
  c_matlabshared_rotations_intern pOrientPost;
  c_matlabshared_rotations_intern pOrientPrior;
  boolean_T pFirstTime;
  double pSensorPeriod;
  double pKalmanPeriod;
  double pGyroOffset[3];
  double pLinAccelPrior[3];
  double pLinAccelPost[3];
  emxArray_real_T *pInputPrototype;
  double MagnetometerNoise;
  double MagneticDisturbanceNoise;
  double MagneticDisturbanceDecayFactor;
  double ExpectedMagneticFieldStrength;
  double pMagVec[3];
} c_fusion_internal_coder_ahrsfil;

#endif                                 /*typedef_c_fusion_internal_coder_ahrsfil*/
#endif

/* End of code generation (orient_test_for_coder_types.h) */
