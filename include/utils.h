#ifndef _GLOBAL_H
#define _GLOBAL_H

#include <iostream>
using namespace std;

void integracion();

void salida();

void one_step_runge_kutta(float* inp,float* out,float tt,float hh);

void one_step_euler(float* inp,float* out,float tt,float hh);

void one_step(float* inp, float* out, float tt, float hh);

void derivacion(float* est,float* f,float tt);

void openfile();

//https://stackoverflow.com/questions/14539867/how-to-display-a-progress-indicator-in-pure-c-c-cout-printf
void progress_bar(float progress);
//https://stackoverflow.com/questions/5525668/how-to-implement-readlink-to-find-the-path
string get_selfpath();

// Genera a partir de valores enteros un rango en flotante de 0-1
template<typename T, typename G>
float raNge1(T a, G b);

#endif
