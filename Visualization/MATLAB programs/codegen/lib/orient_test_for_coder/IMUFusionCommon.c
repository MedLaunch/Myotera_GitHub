/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * IMUFusionCommon.c
 *
 * Code generation for function 'IMUFusionCommon'
 *
 */

/* Include files */
#include "IMUFusionCommon.h"
#include "orient_test_for_coder.h"
#include "quaternioncg.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void c_IMUFusionCommon_predictOrient(const c_fusion_internal_coder_ahrsfil *obj,
  const double gfast[3], const double offset[3], c_matlabshared_rotations_intern
  *qorient)
{
  double c[3];
  double deltaq_a;
  double deltaq_b;
  double deltaq_c;
  double deltaq_d;
  double xa;
  double xb;
  double xc;
  c[0] = (gfast[0] - offset[0]) * obj->pSensorPeriod;
  c[1] = (gfast[1] - offset[1]) * obj->pSensorPeriod;
  c[2] = (gfast[2] - offset[2]) * obj->pSensorPeriod;
  b_quaternioncg_quaternioncg(c, &deltaq_a, &deltaq_b, &deltaq_c, &deltaq_d);
  xa = qorient->a;
  xb = qorient->b;
  xc = qorient->c;
  qorient->a = ((qorient->a * deltaq_a - qorient->b * deltaq_b) - qorient->c *
                deltaq_c) - qorient->d * deltaq_d;
  qorient->b = ((xa * deltaq_b + qorient->b * deltaq_a) + qorient->c * deltaq_d)
    - qorient->d * deltaq_c;
  qorient->c = ((xa * deltaq_c - xb * deltaq_d) + qorient->c * deltaq_a) +
    qorient->d * deltaq_b;
  qorient->d = ((xa * deltaq_d + xb * deltaq_c) - xc * deltaq_b) + qorient->d *
    deltaq_a;
  if (qorient->a < 0.0) {
    qorient->a = -qorient->a;
    qorient->b = -qorient->b;
    qorient->c = -qorient->c;
    qorient->d = -qorient->d;
  }
}

/* End of code generation (IMUFusionCommon.c) */
