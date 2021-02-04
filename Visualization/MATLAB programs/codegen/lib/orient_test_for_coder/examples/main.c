/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * main.c
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

/* Include files */
#include "main.h"
#include "orient_test_for_coder.h"
#include "orient_test_for_coder_terminate.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static void argInit_d248xd3_real_T(double result_data[], int result_size[2]);
static double argInit_real_T(void);
static void main_orient_test_for_coder(void);

/* Function Definitions */
static void argInit_d248xd3_real_T(double result_data[], int result_size[2])
{
  int idx0;
  int idx1;

  /* Set the size of the array.
     Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 2;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result_data[idx0 + 2 * idx1] = argInit_real_T();
    }
  }
}

static double argInit_real_T(void)
{
  return 0.0;
}

static void main_orient_test_for_coder(void)
{
  double acc_data[744];
  int acc_size[2];
  double gyro_data[744];
  int gyro_size[2];
  double magn_data[744];
  int magn_size[2];
  double eulfilt_data[744];
  int eulfilt_size[2];

  /* Initialize function 'orient_test_for_coder' input arguments. */
  /* Initialize function input argument 'acc'. */
  argInit_d248xd3_real_T(acc_data, acc_size);

  /* Initialize function input argument 'gyro'. */
  argInit_d248xd3_real_T(gyro_data, gyro_size);

  /* Initialize function input argument 'magn'. */
  argInit_d248xd3_real_T(magn_data, magn_size);

  /* Call the entry-point 'orient_test_for_coder'. */
  orient_test_for_coder(acc_data, acc_size, gyro_data, gyro_size, magn_data,
                        magn_size, eulfilt_data, eulfilt_size);
}

int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* The initialize function is being called automatically from your entry-point function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_orient_test_for_coder();

  /* Terminate the application.
     You do not need to do this more than one time. */
  orient_test_for_coder_terminate();
  return 0;
}

/* End of code generation (main.c) */
