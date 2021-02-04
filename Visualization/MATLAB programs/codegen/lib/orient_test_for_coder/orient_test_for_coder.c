/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * orient_test_for_coder.c
 *
 * Code generation for function 'orient_test_for_coder'
 *
 */

/* Include files */
#include "orient_test_for_coder.h"
#include "AHRSFilterBase.h"
#include "orient_test_for_coder_data.h"
#include "orient_test_for_coder_emxutil.h"
#include "orient_test_for_coder_initialize.h"
#include "orient_test_for_coder_rtwutil.h"
#include "rt_nonfinite.h"
#include <math.h>
#include <string.h>

/* Function Definitions */
void orient_test_for_coder(const double acc_data[], const int acc_size[2], const
  double gyro_data[], const int gyro_size[2], const double magn_data[], const
  int magn_size[2], double eulfilt_data[], int eulfilt_size[2])
{
  c_fusion_internal_coder_ahrsfil ifilt;
  unsigned char varargin_1_idx_1;
  unsigned char varargin_1_idx_2;
  int ex;
  int loop_ub;
  int ii;
  int b_acc_size[2];
  int b_loop_ub;
  int b_gyro_size[2];
  int c_loop_ub;
  int d_loop_ub;
  cell_wrap_2 varSizes[3];
  int b_magn_size[2];
  signed char inSize[8];
  double n;
  double a;
  int i;
  boolean_T exitg1;
  signed char i1;
  double b_acc_data[3];
  double b_gyro_data[3];
  double b_magn_data[3];
  double qahrs_a_data[1];
  int qahrs_a_size[1];
  double qahrs_b_data[1];
  int qahrs_b_size[1];
  double qahrs_c_data[1];
  int qahrs_c_size[1];
  double qahrs_d_data[1];
  int qahrs_d_size[1];
  static const double dv[144] = { 6.0923483957341713E-6, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0923483957341713E-6, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0923483957341713E-6, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 7.6154354946677142E-5, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 7.6154354946677142E-5, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 7.6154354946677142E-5,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0096236100000000012, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0096236100000000012, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0096236100000000012, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6 };

  double o_a;
  double o_b;
  double o_c;
  double eulfilt_tmp;
  if (!isInitialized_orient_test_for_coder) {
    orient_test_for_coder_initialize();
  }

  c_emxInitStruct_fusion_internal(&ifilt);

  /*  MAKE SURE IN 'MATLAB programs' FOLDER */
  /*  inputs are acc, gyro and magn xyz matrix */
  /*  returns matrix of euler angles   */
  /*      plot = 0; */
  /*      %Read in 9-DOF data */
  /*      accfile = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_" + which + "_acc" + trial + ".csv"; */
  /*  %     opts = detectImportOptions(accfile); */
  /*  %     opts.SelectedVariableNames = [2:4];  */
  /*  %     acc = readmatrix(accfile, opts); */
  /*       */
  /*      file = readtable(accfile); */
  /*      acc = file(2:end, 2:end); */
  /*      acc = table2array(acc); */
  /*   */
  /*      gyrofile = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_" + which + "_gyro" + trial + ".csv"; */
  /*  %     opts = detectImportOptions(gyrofile); */
  /*  %     opts.SelectedVariableNames = [2:4];  */
  /*  %     gyro = readmatrix(gyrofile, opts); */
  /*       */
  /*      file = readtable(accfile); */
  /*      gyro = file(2:end, 2:end); */
  /*      gyro = table2array(gyro); */
  /*   */
  /*      magnfile = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_" + which + "_magn" + trial + ".csv"; */
  /*  %     opts = detectImportOptions(magnfile); */
  /*  %     opts.SelectedVariableNames = [2:4];  */
  /*  %     magn = readmatrix(magnfile, opts); */
  /*       */
  /*      file = readtable(accfile); */
  /*      magn = file(2:end, 2:end); */
  /*      magn = table2array(magn); */
  /*   */
  /*  %     if(plot) */
  /*  %         viewer = HelperOrientationViewer; */
  /*  %     end */
  /*   */
  /*      %Edittable Parameters */
  /*      % ahrsFilter.GyroscopeNoise          = 0.0002; */
  /*      % ahrsFilter.AccelerometerNoise      = 0.0003; */
  /*      % ahrsFilter.LinearAccelerationNoise = 0.0025; */
  /*      % ahrsFilter.MagnetometerNoise       = 0.1; */
  /*      % ahrsFilter.MagneticDisturbanceNoise = 0.5; */
  /*      % ahrsFilter.MagneticDisturbanceDecayFactor = 0.5; */
  ifilt.MagnetometerNoise = 0.1;
  ifilt.MagneticDisturbanceNoise = 0.5;
  ifilt.MagneticDisturbanceDecayFactor = 0.5;
  ifilt.ExpectedMagneticFieldStrength = 50.0;
  ifilt.AccelerometerNoise = 0.0001924722;
  ifilt.GyroscopeNoise = 9.1385E-5;
  ifilt.GyroscopeDriftNoise = 3.0462E-13;
  ifilt.LinearAccelerationNoise = 0.0096236100000000012;
  ifilt.LinearAccelerationDecayFactor = 0.5;
  ifilt.isInitialized = 0;
  varargin_1_idx_1 = (unsigned char)gyro_size[0];
  varargin_1_idx_2 = (unsigned char)magn_size[0];
  ex = (unsigned char)acc_size[0];
  if (ex > varargin_1_idx_1) {
    ex = varargin_1_idx_1;
  }

  if (ex > varargin_1_idx_2) {
    ex = varargin_1_idx_2;
  }

  /* Shortest set of data between acc, gyro, mag */
  eulfilt_size[0] = ex;
  eulfilt_size[1] = 3;
  if (0 <= ex - 1) {
    loop_ub = acc_size[1];
    b_acc_size[0] = 1;
    b_acc_size[1] = acc_size[1];
    b_loop_ub = gyro_size[1];
    b_gyro_size[0] = 1;
    b_gyro_size[1] = gyro_size[1];
    d_loop_ub = magn_size[1];
    b_magn_size[0] = 1;
    b_magn_size[1] = magn_size[1];
  }

  for (ii = 0; ii < ex; ii++) {
    /* Shortest set of data between acc, gyro, mag */
    if (ifilt.isInitialized != 1) {
      ifilt.isInitialized = 1;
      c_loop_ub = acc_size[1];
      varSizes[0].f1[0] = 1U;
      varSizes[0].f1[1] = (unsigned int)acc_size[1];
      varSizes[1].f1[0] = 1U;
      varSizes[1].f1[1] = (unsigned int)gyro_size[1];
      varSizes[2].f1[0] = 1U;
      varSizes[2].f1[1] = (unsigned int)magn_size[1];
      for (i = 0; i < 6; i++) {
        varSizes[0].f1[i + 2] = 1U;
        varSizes[1].f1[i + 2] = 1U;
        varSizes[2].f1[i + 2] = 1U;
      }

      memcpy(&ifilt.inputVarSize[0], &varSizes[0], 3U * sizeof(cell_wrap_2));
      i = ifilt.pInputPrototype->size[0] * ifilt.pInputPrototype->size[1];
      ifilt.pInputPrototype->size[0] = 1;
      ifilt.pInputPrototype->size[1] = acc_size[1];
      emxEnsureCapacity_real_T(ifilt.pInputPrototype, i);
      for (i = 0; i < c_loop_ub; i++) {
        ifilt.pInputPrototype->data[i] = acc_data[ii + acc_size[0] * i];
      }

      ifilt.pSensorPeriod = 0.019230769230769232;
      ifilt.pKalmanPeriod = 0.019230769230769232;
      ifilt.TunablePropsChanged = false;
      ifilt.pOrientPost.a = 1.0;
      ifilt.pOrientPost.b = 0.0;
      ifilt.pOrientPost.c = 0.0;
      ifilt.pOrientPost.d = 0.0;
      ifilt.pGyroOffset[0] = 0.0;
      ifilt.pGyroOffset[1] = 0.0;
      ifilt.pMagVec[1] = 0.0;
      ifilt.pGyroOffset[2] = 0.0;
      ifilt.pMagVec[2] = 0.0;
      ifilt.pMagVec[0] = ifilt.ExpectedMagneticFieldStrength;
      n = 0.00036982248520710064 * (ifilt.GyroscopeDriftNoise +
        ifilt.GyroscopeNoise);
      a = (ifilt.AccelerometerNoise + ifilt.LinearAccelerationNoise) + n;
      n += ifilt.MagnetometerNoise + ifilt.MagneticDisturbanceNoise;
      memset(&ifilt.pQv[0], 0, 36U * sizeof(double));
      for (i = 0; i < 3; i++) {
        i1 = iv[3 * i];
        ifilt.pQv[6 * i] = a * (double)i1;
        c_loop_ub = 6 * (i + 3);
        ifilt.pQv[c_loop_ub + 3] = n * (double)i1;
        i1 = iv[3 * i + 1];
        ifilt.pQv[6 * i + 1] = a * (double)i1;
        ifilt.pQv[c_loop_ub + 4] = n * (double)i1;
        i1 = iv[3 * i + 2];
        ifilt.pQv[6 * i + 2] = a * (double)i1;
        ifilt.pQv[c_loop_ub + 5] = n * (double)i1;
      }

      memcpy(&ifilt.pQw[0], &dv[0], 144U * sizeof(double));
      ifilt.pLinAccelPost[0] = 0.0;
      ifilt.pLinAccelPost[1] = 0.0;
      ifilt.pLinAccelPost[2] = 0.0;
      ifilt.pFirstTime = true;
    }

    if (ifilt.TunablePropsChanged) {
      ifilt.TunablePropsChanged = false;
      n = ifilt.pKalmanPeriod * ifilt.pKalmanPeriod * (ifilt.GyroscopeDriftNoise
        + ifilt.GyroscopeNoise);
      a = (ifilt.AccelerometerNoise + ifilt.LinearAccelerationNoise) + n;
      n += ifilt.MagnetometerNoise + ifilt.MagneticDisturbanceNoise;
      memset(&ifilt.pQv[0], 0, 36U * sizeof(double));
      for (i = 0; i < 3; i++) {
        i1 = iv[3 * i];
        ifilt.pQv[6 * i] = a * (double)i1;
        c_loop_ub = 6 * (i + 3);
        ifilt.pQv[c_loop_ub + 3] = n * (double)i1;
        i1 = iv[3 * i + 1];
        ifilt.pQv[6 * i + 1] = a * (double)i1;
        ifilt.pQv[c_loop_ub + 4] = n * (double)i1;
        i1 = iv[3 * i + 2];
        ifilt.pQv[6 * i + 2] = a * (double)i1;
        ifilt.pQv[c_loop_ub + 5] = n * (double)i1;
      }
    }

    inSize[0] = 1;
    inSize[1] = (signed char)acc_size[1];
    for (i = 0; i < 6; i++) {
      inSize[i + 2] = 1;
    }

    c_loop_ub = 0;
    exitg1 = false;
    while ((!exitg1) && (c_loop_ub < 8)) {
      if (ifilt.inputVarSize[0].f1[c_loop_ub] != (unsigned int)inSize[c_loop_ub])
      {
        for (i = 0; i < 8; i++) {
          ifilt.inputVarSize[0].f1[i] = (unsigned int)inSize[i];
        }

        exitg1 = true;
      } else {
        c_loop_ub++;
      }
    }

    inSize[0] = 1;
    inSize[1] = (signed char)gyro_size[1];
    for (i = 0; i < 6; i++) {
      inSize[i + 2] = 1;
    }

    c_loop_ub = 0;
    exitg1 = false;
    while ((!exitg1) && (c_loop_ub < 8)) {
      if (ifilt.inputVarSize[1].f1[c_loop_ub] != (unsigned int)inSize[c_loop_ub])
      {
        for (i = 0; i < 8; i++) {
          ifilt.inputVarSize[1].f1[i] = (unsigned int)inSize[i];
        }

        exitg1 = true;
      } else {
        c_loop_ub++;
      }
    }

    inSize[0] = 1;
    inSize[1] = (signed char)magn_size[1];
    for (i = 0; i < 6; i++) {
      inSize[i + 2] = 1;
    }

    c_loop_ub = 0;
    exitg1 = false;
    while ((!exitg1) && (c_loop_ub < 8)) {
      if (ifilt.inputVarSize[2].f1[c_loop_ub] != (unsigned int)inSize[c_loop_ub])
      {
        for (i = 0; i < 8; i++) {
          ifilt.inputVarSize[2].f1[i] = (unsigned int)inSize[i];
        }

        exitg1 = true;
      } else {
        c_loop_ub++;
      }
    }

    for (i = 0; i < loop_ub; i++) {
      b_acc_data[i] = acc_data[ii + acc_size[0] * i];
    }

    for (i = 0; i < b_loop_ub; i++) {
      b_gyro_data[i] = gyro_data[ii + gyro_size[0] * i];
    }

    for (i = 0; i < d_loop_ub; i++) {
      b_magn_data[i] = magn_data[ii + magn_size[0] * i];
    }

    AHRSFilterBase_stepImpl(&ifilt, b_acc_data, b_acc_size, b_gyro_data,
      b_gyro_size, b_magn_data, b_magn_size, qahrs_a_data, qahrs_a_size,
      qahrs_b_data, qahrs_b_size, qahrs_c_data, qahrs_c_size, qahrs_d_data,
      qahrs_d_size);

    /*          if(plot) */
    /*              viewer(qahrs); */
    /*          end */
    /*          pause(0.01); */
    /*  Convert quarternion into Euler angles */
    n = sqrt(((qahrs_a_data[0] * qahrs_a_data[0] + qahrs_b_data[0] *
               qahrs_b_data[0]) + qahrs_c_data[0] * qahrs_c_data[0]) +
             qahrs_d_data[0] * qahrs_d_data[0]);
    o_a = qahrs_a_data[0] / n;
    o_b = qahrs_b_data[0] / n;
    o_c = qahrs_c_data[0] / n;
    a = qahrs_d_data[0] / n;
    n = o_b * a * 2.0 - o_a * o_c * 2.0;
    if (n > 1.0) {
      n = 1.0;
    }

    if (n < -1.0) {
      n = -1.0;
    }

    eulfilt_tmp = o_a * o_a * 2.0 - 1.0;
    eulfilt_data[ii] = rt_atan2d_snf(o_a * a * 2.0 + o_b * o_c * 2.0,
      eulfilt_tmp + o_b * o_b * 2.0);
    eulfilt_data[ii + ex] = -asin(n);
    eulfilt_data[ii + ex * 2] = rt_atan2d_snf(o_a * o_b * 2.0 + o_c * a * 2.0,
      eulfilt_tmp + a * a * 2.0);
  }

  c_emxFreeStruct_fusion_internal(&ifilt);

  /*  qahrs = ifilt(acc(1:num_meas,:), gyro(1:num_meas,:), magn(1:num_meas,:)); */
  /*  eulfilt = euler(qahrs,'ZYX','frame'); */
  /*  viewer(qahrs); */
  /* storePath = "orientation"+"_"+what+"_take" + trial + ".csv"; */
  /* NOT WRITING TO ANYTHING, ADD AFTER CODER */
  /* writematrix(eulfilt,storePath) */
  /*      if(plot) */
  /*          % Release the system object */
  /*          release(ifilt) */
  /*   */
  /*          %Plotting roll, pitch, yaw over time: */
  /*          t = 1:num_meas; */
  /*          figure() %Fused Roll Pitch Yaw */
  /*          subplot(3,1,1) */
  /*          plot(t, eulfilt(:,3)) */
  /*          title('Fused ROLL Data') */
  /*          ylabel('Rotation (degrees)') */
  /*          xlabel('Time (s)') */
  /*          subplot(3,1,2) */
  /*          plot(t, eulfilt(:,2)) */
  /*          title('Fused PITCH Data') */
  /*          ylabel('Rotation (degrees)') */
  /*          xlabel('Time (s)') */
  /*          subplot(3,1,3) */
  /*          plot(t, eulfilt(:,1)) */
  /*          title('Fused YAW Data') */
  /*          ylabel('Rotation (degrees)') */
  /*          xlabel('Time (s)') */
  /*      end  */
}

/* End of code generation (orient_test_for_coder.c) */
