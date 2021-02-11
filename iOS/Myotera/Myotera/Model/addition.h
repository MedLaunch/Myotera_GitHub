/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * addition.h
 *
 * Code generation for function 'addition'
 *
 */

#ifndef ADDITION_H
#define ADDITION_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include <string>
#include "rtwtypes.h"
#include "addition_types.h"

class Addition {
public:
    Addition(double x_in, double y_in) : x(x_in), y(y_in) { }
    
    double doAdd() {
        return x + y;
    }
private:
    double x = 10;
    double y = 10;
};

#endif

/* End of code generation (addition.h) */
