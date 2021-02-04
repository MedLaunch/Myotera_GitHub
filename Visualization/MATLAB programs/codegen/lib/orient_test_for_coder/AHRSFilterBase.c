/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AHRSFilterBase.c
 *
 * Code generation for function 'AHRSFilterBase'
 *
 */

/* Include files */
#include "AHRSFilterBase.h"
#include "IMUFusionCommon.h"
#include "NED.h"
#include "mrdivide_helper.h"
#include "orient_test_for_coder.h"
#include "orient_test_for_coder_data.h"
#include "orient_test_for_coder_rtwutil.h"
#include "permute.h"
#include "quaternioncg.h"
#include "rotmat.h"
#include "rt_nonfinite.h"
#include <math.h>
#include <string.h>

/* Function Definitions */
void AHRSFilterBase_stepImpl(c_fusion_internal_coder_ahrsfil *obj, const double
  accelIn_data[], const int accelIn_size[2], const double gyroIn_data[], const
  int gyroIn_size[2], const double magIn_data[], const int magIn_size[2], double
  orientOut_a_data[], int orientOut_a_size[1], double orientOut_b_data[], int
  orientOut_b_size[1], double orientOut_c_data[], int orientOut_c_size[1],
  double orientOut_d_data[], int orientOut_d_size[1])
{
  int aoffset;
  double magDistErr[3];
  double gfastmat_data[3];
  double gravityAccelGyroDiff[3];
  int b_iv[3];
  double afastmat_data[3];
  int afastmat_size[3];
  double mfastmat_data[3];
  int mfastmat_size[3];
  int i;
  int iter;
  c_fusion_internal_coder_ahrsfil *r;
  double Rprior[9];
  double linAccelErr_idx_1;
  int i1;
  double h1[9];
  double absxk;
  double gyroOffsetErr[3];
  double h2[9];
  double b_h2[9];
  double Qw[144];
  double linAccelErr_idx_0;
  double H[72];
  int i2;
  int H_tmp;
  int b_H_tmp;
  double tmp_tmp[36];
  double b_tmp_tmp[72];
  double ze[6];
  double y_tmp[72];
  double scale;
  static const signed char iv1[9] = { -1, 0, 0, 0, -1, 0, 0, 0, -1 };

  boolean_T isJamming;
  double t;
  double xe_post[12];
  double linAccelErr_idx_2;
  c_matlabshared_rotations_intern qerr;
  double x_c;
  double Ppost[144];
  aoffset = accelIn_size[1];
  if (0 <= aoffset - 1) {
    memcpy(&magDistErr[0], &accelIn_data[0], aoffset * sizeof(double));
  }

  aoffset = magIn_size[1];
  if (0 <= aoffset - 1) {
    memcpy(&gfastmat_data[0], &magIn_data[0], aoffset * sizeof(double));
  }

  aoffset = gyroIn_size[1];
  if (0 <= aoffset - 1) {
    memcpy(&gravityAccelGyroDiff[0], &gyroIn_data[0], aoffset * sizeof(double));
  }

  b_iv[0] = 3;
  b_iv[1] = 1;
  b_iv[2] = accelIn_size[1] / 3;
  permute(magDistErr, b_iv, afastmat_data, afastmat_size);
  b_iv[0] = 3;
  b_iv[1] = 1;
  b_iv[2] = magIn_size[1] / 3;
  permute(gfastmat_data, b_iv, mfastmat_data, mfastmat_size);
  b_iv[0] = 3;
  b_iv[1] = 1;
  b_iv[2] = gyroIn_size[1] / 3;
  permute(gravityAccelGyroDiff, b_iv, gfastmat_data, mfastmat_size);
  orientOut_a_size[0] = afastmat_size[2];
  aoffset = afastmat_size[2];
  if (0 <= aoffset - 1) {
    memset(&orientOut_a_data[0], 0, aoffset * sizeof(double));
  }

  orientOut_b_size[0] = afastmat_size[2];
  aoffset = afastmat_size[2];
  if (0 <= aoffset - 1) {
    memset(&orientOut_b_data[0], 0, aoffset * sizeof(double));
  }

  orientOut_c_size[0] = afastmat_size[2];
  aoffset = afastmat_size[2];
  if (0 <= aoffset - 1) {
    memset(&orientOut_c_data[0], 0, aoffset * sizeof(double));
  }

  orientOut_d_size[0] = afastmat_size[2];
  aoffset = afastmat_size[2];
  if (0 <= aoffset - 1) {
    memset(&orientOut_d_data[0], 0, aoffset * sizeof(double));
  }

  i = afastmat_size[2];
  for (iter = 0; iter < i; iter++) {
    if (obj->pFirstTime) {
      obj->pFirstTime = false;
      NED_ecompass(*(double (*)[3])&afastmat_data[0], *(double (*)[3])&
                   mfastmat_data[0], Rprior);
      quaternioncg_quaternioncg(Rprior, &obj->pOrientPost.a, &obj->pOrientPost.b,
        &obj->pOrientPost.c, &obj->pOrientPost.d);
    }

    r = obj;
    obj->pOrientPrior = obj->pOrientPost;
    c_IMUFusionCommon_predictOrient(r, *(double (*)[3])&gfastmat_data[0],
      obj->pGyroOffset, &obj->pOrientPrior);
    quaternionBase_rotmat(obj->pOrientPrior.a, obj->pOrientPrior.b,
                          obj->pOrientPrior.c, obj->pOrientPrior.d, Rprior);
    linAccelErr_idx_1 = obj->LinearAccelerationDecayFactor;
    for (i1 = 0; i1 < 3; i1++) {
      obj->pLinAccelPrior[i1] = linAccelErr_idx_1 * obj->pLinAccelPost[i1];
      absxk = Rprior[i1 + 6];
      gravityAccelGyroDiff[i1] = (afastmat_data[i1] + obj->pLinAccelPrior[i1]) -
        absxk;
      gyroOffsetErr[i1] = (Rprior[i1] * obj->pMagVec[0] + Rprior[i1 + 3] *
                           obj->pMagVec[1]) + absxk * obj->pMagVec[2];
    }

    memset(&h1[0], 0, 9U * sizeof(double));
    h1[3] = Rprior[8];
    h1[6] = -Rprior[7];
    h1[7] = Rprior[6];
    for (i1 = 0; i1 < 3; i1++) {
      h2[3 * i1] = h1[3 * i1];
      aoffset = 3 * i1 + 1;
      h2[aoffset] = h1[aoffset] - h1[i1 + 3];
      aoffset = 3 * i1 + 2;
      h2[aoffset] = h1[aoffset] - h1[i1 + 6];
    }

    for (i1 = 0; i1 < 9; i1++) {
      h1[i1] = h2[i1];
      h2[i1] = 0.0;
    }

    h2[3] = gyroOffsetErr[2];
    h2[6] = -gyroOffsetErr[1];
    h2[7] = gyroOffsetErr[0];
    for (i1 = 0; i1 < 3; i1++) {
      b_h2[3 * i1] = h2[3 * i1] - h2[i1];
      aoffset = 3 * i1 + 1;
      b_h2[aoffset] = h2[aoffset] - h2[i1 + 3];
      aoffset = 3 * i1 + 2;
      b_h2[aoffset] = h2[aoffset] - h2[i1 + 6];
    }

    memcpy(&h2[0], &b_h2[0], 9U * sizeof(double));
    for (i1 = 0; i1 < 3; i1++) {
      linAccelErr_idx_0 = h1[3 * i1];
      H[6 * i1] = linAccelErr_idx_0;
      aoffset = 6 * (i1 + 3);
      H[aoffset] = -linAccelErr_idx_0 * obj->pKalmanPeriod;
      H_tmp = 6 * (i1 + 6);
      H[H_tmp] = iv[3 * i1];
      b_H_tmp = 6 * (i1 + 9);
      H[b_H_tmp] = 0.0;
      linAccelErr_idx_0 = h2[3 * i1];
      H[6 * i1 + 3] = linAccelErr_idx_0;
      H[aoffset + 3] = -linAccelErr_idx_0 * obj->pKalmanPeriod;
      H[H_tmp + 3] = 0.0;
      H[b_H_tmp + 3] = iv1[3 * i1];
      i2 = 3 * i1 + 1;
      H[6 * i1 + 1] = h1[i2];
      H[aoffset + 1] = -h1[i2] * obj->pKalmanPeriod;
      H[H_tmp + 1] = iv[i2];
      H[b_H_tmp + 1] = 0.0;
      H[6 * i1 + 4] = h2[i2];
      H[aoffset + 4] = -h2[i2] * obj->pKalmanPeriod;
      H[H_tmp + 4] = 0.0;
      H[b_H_tmp + 4] = iv1[i2];
      i2 = 3 * i1 + 2;
      H[6 * i1 + 2] = h1[i2];
      H[aoffset + 2] = -h1[i2] * obj->pKalmanPeriod;
      H[H_tmp + 2] = iv[i2];
      H[b_H_tmp + 2] = 0.0;
      H[6 * i1 + 5] = h2[i2];
      H[aoffset + 5] = -h2[i2] * obj->pKalmanPeriod;
      H[H_tmp + 5] = 0.0;
      H[b_H_tmp + 5] = iv1[i2];
    }

    memcpy(&Qw[0], &obj->pQw[0], 144U * sizeof(double));
    for (i1 = 0; i1 < 6; i1++) {
      for (i2 = 0; i2 < 12; i2++) {
        linAccelErr_idx_0 = 0.0;
        for (aoffset = 0; aoffset < 12; aoffset++) {
          linAccelErr_idx_0 += H[i1 + 6 * aoffset] * Qw[aoffset + 12 * i2];
        }

        aoffset = i1 + 6 * i2;
        b_tmp_tmp[aoffset] = linAccelErr_idx_0;
        y_tmp[i2 + 12 * i1] = H[aoffset];
      }
    }

    for (i1 = 0; i1 < 12; i1++) {
      for (i2 = 0; i2 < 6; i2++) {
        linAccelErr_idx_0 = 0.0;
        for (aoffset = 0; aoffset < 12; aoffset++) {
          linAccelErr_idx_0 += Qw[i1 + 12 * aoffset] * y_tmp[aoffset + 12 * i2];
        }

        H[i1 + 12 * i2] = linAccelErr_idx_0;
      }
    }

    for (i1 = 0; i1 < 6; i1++) {
      for (i2 = 0; i2 < 6; i2++) {
        linAccelErr_idx_0 = 0.0;
        for (aoffset = 0; aoffset < 12; aoffset++) {
          linAccelErr_idx_0 += b_tmp_tmp[i2 + 6 * aoffset] * y_tmp[aoffset + 12 *
            i1];
        }

        tmp_tmp[i1 + 6 * i2] = linAccelErr_idx_0 + obj->pQv[i2 + 6 * i1];
      }
    }

    mrdiv(H, tmp_tmp);
    for (i1 = 0; i1 < 3; i1++) {
      ze[i1] = gravityAccelGyroDiff[i1];
      ze[i1 + 3] = mfastmat_data[i1] - ((Rprior[i1] * obj->pMagVec[0] +
        Rprior[i1 + 3] * obj->pMagVec[1]) + Rprior[i1 + 6] * obj->pMagVec[2]);
    }

    linAccelErr_idx_1 = 0.0;
    scale = 3.3121686421112381E-170;
    for (aoffset = 0; aoffset < 3; aoffset++) {
      linAccelErr_idx_0 = 0.0;
      absxk = 0.0;
      for (i1 = 0; i1 < 6; i1++) {
        t = H[(aoffset + 12 * i1) + 9] * ze[i1];
        linAccelErr_idx_0 += t;
        absxk += t;
      }

      magDistErr[aoffset] = absxk;
      absxk = fabs(linAccelErr_idx_0);
      if (absxk > scale) {
        t = scale / absxk;
        linAccelErr_idx_1 = linAccelErr_idx_1 * t * t + 1.0;
        scale = absxk;
      } else {
        t = absxk / scale;
        linAccelErr_idx_1 += t * t;
      }
    }

    linAccelErr_idx_1 = scale * sqrt(linAccelErr_idx_1);
    absxk = obj->ExpectedMagneticFieldStrength;
    isJamming = (linAccelErr_idx_1 * linAccelErr_idx_1 > 4.0 * (absxk * absxk));
    if (isJamming) {
      for (i1 = 0; i1 < 9; i1++) {
        Rprior[i1] = (H[i1] * gravityAccelGyroDiff[0] + H[i1 + 12] *
                      gravityAccelGyroDiff[1]) + H[i1 + 24] *
          gravityAccelGyroDiff[2];
      }

      gravityAccelGyroDiff[0] = Rprior[0];
      gyroOffsetErr[0] = Rprior[3];
      linAccelErr_idx_0 = Rprior[6];
      gravityAccelGyroDiff[1] = Rprior[1];
      gyroOffsetErr[1] = Rprior[4];
      linAccelErr_idx_1 = Rprior[7];
      gravityAccelGyroDiff[2] = Rprior[2];
      gyroOffsetErr[2] = Rprior[5];
      linAccelErr_idx_2 = Rprior[8];
    } else {
      for (i1 = 0; i1 < 12; i1++) {
        linAccelErr_idx_0 = 0.0;
        for (i2 = 0; i2 < 6; i2++) {
          linAccelErr_idx_0 += H[i1 + 12 * i2] * ze[i2];
        }

        xe_post[i1] = linAccelErr_idx_0;
      }

      gravityAccelGyroDiff[0] = xe_post[0];
      gyroOffsetErr[0] = xe_post[3];
      linAccelErr_idx_0 = xe_post[6];
      gravityAccelGyroDiff[1] = xe_post[1];
      gyroOffsetErr[1] = xe_post[4];
      linAccelErr_idx_1 = xe_post[7];
      gravityAccelGyroDiff[2] = xe_post[2];
      gyroOffsetErr[2] = xe_post[5];
      linAccelErr_idx_2 = xe_post[8];
    }

    b_quaternioncg_quaternioncg(gravityAccelGyroDiff, &qerr.a, &qerr.b, &qerr.c,
      &qerr.d);
    qerr.b = -qerr.b;
    qerr.c = -qerr.c;
    qerr.d = -qerr.d;
    absxk = obj->pOrientPrior.a;
    t = obj->pOrientPrior.b;
    x_c = obj->pOrientPrior.c;
    scale = obj->pOrientPrior.d;
    obj->pOrientPost.a = ((absxk * qerr.a - t * qerr.b) - x_c * qerr.c) - scale *
      qerr.d;
    obj->pOrientPost.b = ((absxk * qerr.b + t * qerr.a) + x_c * qerr.d) - scale *
      qerr.c;
    obj->pOrientPost.c = ((absxk * qerr.c - t * qerr.d) + x_c * qerr.a) + scale *
      qerr.b;
    obj->pOrientPost.d = ((absxk * qerr.d + t * qerr.c) - x_c * qerr.b) + scale *
      qerr.a;
    if (obj->pOrientPost.a < 0.0) {
      qerr = obj->pOrientPost;
      qerr.a = -qerr.a;
      qerr.b = -qerr.b;
      qerr.c = -qerr.c;
      qerr.d = -qerr.d;
      obj->pOrientPost = qerr;
    }

    qerr = obj->pOrientPost;
    absxk = sqrt(((qerr.a * qerr.a + qerr.b * qerr.b) + qerr.c * qerr.c) +
                 qerr.d * qerr.d);
    qerr.a /= absxk;
    qerr.b /= absxk;
    qerr.c /= absxk;
    qerr.d /= absxk;
    obj->pOrientPost = qerr;
    quaternionBase_rotmat(obj->pOrientPost.a, obj->pOrientPost.b,
                          obj->pOrientPost.c, obj->pOrientPost.d, Rprior);
    obj->pGyroOffset[0] -= gyroOffsetErr[0];
    obj->pLinAccelPost[0] = obj->pLinAccelPrior[0] - linAccelErr_idx_0;
    obj->pGyroOffset[1] -= gyroOffsetErr[1];
    obj->pLinAccelPost[1] = obj->pLinAccelPrior[1] - linAccelErr_idx_1;
    obj->pGyroOffset[2] -= gyroOffsetErr[2];
    obj->pLinAccelPost[2] = obj->pLinAccelPrior[2] - linAccelErr_idx_2;
    if (!isJamming) {
      for (H_tmp = 0; H_tmp < 3; H_tmp++) {
        aoffset = H_tmp * 3;
        gravityAccelGyroDiff[H_tmp] = obj->pMagVec[H_tmp] - ((Rprior[aoffset] *
          magDistErr[0] + Rprior[aoffset + 1] * magDistErr[1]) + Rprior[aoffset
          + 2] * magDistErr[2]);
      }

      absxk = rt_atan2d_snf(gravityAccelGyroDiff[2], gravityAccelGyroDiff[0]);
      if (absxk < -1.5707963267948966) {
        absxk = -1.5707963267948966;
      }

      if (absxk > 1.5707963267948966) {
        absxk = 1.5707963267948966;
      }

      obj->pMagVec[0] = 0.0;
      obj->pMagVec[1] = 0.0;
      obj->pMagVec[2] = 0.0;
      obj->pMagVec[0] = cos(absxk);
      obj->pMagVec[2] = sin(absxk);
      obj->pMagVec[0] *= obj->ExpectedMagneticFieldStrength;
      obj->pMagVec[1] *= obj->ExpectedMagneticFieldStrength;
      obj->pMagVec[2] *= obj->ExpectedMagneticFieldStrength;
    }

    for (i1 = 0; i1 < 12; i1++) {
      for (i2 = 0; i2 < 12; i2++) {
        linAccelErr_idx_0 = 0.0;
        for (aoffset = 0; aoffset < 6; aoffset++) {
          linAccelErr_idx_0 += H[i1 + 12 * aoffset] * b_tmp_tmp[aoffset + 6 * i2];
        }

        aoffset = i1 + 12 * i2;
        Ppost[aoffset] = Qw[aoffset] - linAccelErr_idx_0;
      }
    }

    memset(&Qw[0], 0, 144U * sizeof(double));
    linAccelErr_idx_1 = obj->pKalmanPeriod;
    linAccelErr_idx_1 *= linAccelErr_idx_1;
    t = obj->GyroscopeDriftNoise + obj->GyroscopeNoise;
    absxk = -obj->pKalmanPeriod;
    scale = obj->LinearAccelerationDecayFactor;
    scale *= scale;
    x_c = obj->MagneticDisturbanceDecayFactor;
    x_c *= x_c;
    Qw[0] = Ppost[0] + linAccelErr_idx_1 * (Ppost[39] + t);
    linAccelErr_idx_0 = Ppost[39] + obj->GyroscopeDriftNoise;
    Qw[39] = linAccelErr_idx_0;
    linAccelErr_idx_0 *= absxk;
    Qw[3] = linAccelErr_idx_0;
    Qw[36] = linAccelErr_idx_0;
    Qw[78] = scale * Ppost[78] + obj->LinearAccelerationNoise;
    Qw[117] = x_c * Ppost[117] + obj->MagneticDisturbanceNoise;
    Qw[13] = Ppost[13] + linAccelErr_idx_1 * (Ppost[52] + t);
    linAccelErr_idx_0 = Ppost[52] + obj->GyroscopeDriftNoise;
    Qw[52] = linAccelErr_idx_0;
    linAccelErr_idx_0 *= absxk;
    Qw[16] = linAccelErr_idx_0;
    Qw[49] = linAccelErr_idx_0;
    Qw[91] = scale * Ppost[91] + obj->LinearAccelerationNoise;
    Qw[130] = x_c * Ppost[130] + obj->MagneticDisturbanceNoise;
    Qw[26] = Ppost[26] + linAccelErr_idx_1 * (Ppost[65] + t);
    linAccelErr_idx_0 = Ppost[65] + obj->GyroscopeDriftNoise;
    Qw[65] = linAccelErr_idx_0;
    linAccelErr_idx_0 *= absxk;
    Qw[29] = linAccelErr_idx_0;
    Qw[62] = linAccelErr_idx_0;
    Qw[104] = scale * Ppost[104] + obj->LinearAccelerationNoise;
    Qw[143] = x_c * Ppost[143] + obj->MagneticDisturbanceNoise;
    memcpy(&obj->pQw[0], &Qw[0], 144U * sizeof(double));
    qerr = obj->pOrientPost;
    orientOut_a_data[0] = qerr.a;
    orientOut_b_data[0] = qerr.b;
    orientOut_c_data[0] = qerr.c;
    orientOut_d_data[0] = qerr.d;
  }
}

/* End of code generation (AHRSFilterBase.c) */
