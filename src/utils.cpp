#include "utils.h"
#include <iostream>
#include <chrono>
#include <iomanip>
#include <sstream>
#include <fstream>
#include <unistd.h>
#define PATH_MAX 1024
using namespace std;
using namespace std::chrono;


extern float a, b, c, dt;
extern float tinic, tfin, t;
extern unsigned int comm_int;
extern unsigned int ci;
extern unsigned int numeq;

extern float* estado;
extern float* oldestado;
extern float* f;
extern float** k;

extern ofstream myfile;
extern bool streambuffer;

extern bool imunidad, runge;

extern chrono::duration<double, std::milli> duracion;

void salida(){
    if(ci%comm_int==0){
        if(streambuffer==0){
            cout    << "I: " << estado[0] << " S: " << estado[1] << " R: " << estado[2]
                << " T:" << duracion.count()  << "ms" << endl;
        }else{
            myfile  << setprecision(3) << fixed << setw(10)
                << estado[0] << setw(10) << estado[1]
                << setw(10) << estado[2] << setw(10)
                << duracion.count() << endl;
        }
    }
}

void integracion()
{
    do {
        auto start = high_resolution_clock::now();
        salida();
        ci++;
        oldestado=estado;
        one_step(oldestado,estado,t,dt); //sustituir por one-step-runge-kutta o por one-step-euler
        t+=dt;
        auto stop = high_resolution_clock::now();
        duracion += stop-start;
        if(streambuffer)
            progress_bar(raNge1(t,tfin));
    } while (t<tfin);
    if(streambuffer)
        cout << endl;
}

void one_step(float* inp, float* out, float tt, float hh){
    if(runge)
        one_step_runge_kutta(inp,out,tt,hh);
    else
        one_step_euler(inp,out,tt,hh);
}


void one_step_runge_kutta(float* inp,float* out,float tt,float hh)
{
    unsigned int i, j;
    float time, incr;
    for (i=0; i<numeq; i++) out[i]=inp[i];
    time=tt;
    for (j=0; j<4; j++) {
        derivacion(out,f,time);
        for (i=0; i<numeq; i++) k[i][j]=f[i];
        if(j<2)
            incr=hh/2.0;
        else
            incr=hh;
        time=tt+incr;
        for (i=0; i<numeq; i++) out[i]=inp[i]+k[i][j]*incr;
    }
    for (i=0; i<numeq; i++)
        out[i]=inp[i]+hh/6.0*(k[i][0]+2*k[i][1]+2*k[i][2]+k[i][3]);
}


void one_step_euler(float* inp,float* out,float tt,float hh)
{
    derivacion(inp,f,tt);
    for (unsigned int i=0; i<numeq; i++) out[i]=inp[i]+hh*f[i];
}



void derivacion(float* est,float* f,float tt){
    // específico para el modelo considerado
    //con inmunidad
    if(imunidad)
    {
        f[0]=a*est[0]*est[1]-b*est[0];
        f[1]=-a*est[0]*est[1];
        f[2]=b*est[0];
    }
    //sin inmunidad
    else
    {
        f[0]=a*est[0]*est[1]-b*est[0];
        f[1]=-a*est[0]*est[1]+est[2]*c;
        f[2]=b*est[0]-est[2]*c;
    }
}

void openfile(){
    // Try to store the results in a file
    string path;
    stringstream oss;
    if(streambuffer==1){
        path = get_selfpath();
        path = path.substr(0,path.find_last_of("/\\") + 1);
        oss << path << "../resultados/sir-a:" << a << "-b:" << b << "-dt:" << dt <<
            "-I:" << estado[0] << "-R:" << estado[1] << "-S:" << estado[2] <<
            ".txt";
        myfile.open(oss.str(),ios::out|ios::trunc);
        if(!myfile.is_open()){
            cerr << "[ERROR]: Couldn't open file to save results" << endl;
            streambuffer = 0;
        }
    }
}

//https://stackoverflow.com/questions/14539867/how-to-display-a-progress-indicator-in-pure-c-c-cout-printf
void progress_bar(float progress){
    int barWidth = 70;

    std::cout << "[";
    int pos = barWidth * progress;
    for (int i = 0; i < barWidth; ++i) {
        if (i < pos) std::cout << "=";
        else if (i == pos) std::cout << ">";
        else std::cout << " ";
    }
    std::cout << "] " << int(progress * 100.0) << " %\r";
    std::cout.flush();
}

//https://stackoverflow.com/questions/5525668/how-to-implement-readlink-to-find-the-path
string get_selfpath() {
    char buff[PATH_MAX];
    ssize_t len = ::readlink("/proc/self/exe", buff, sizeof(buff)-1);
    if (len != -1) {
        buff[len] = '\0';
        return std::string(buff);
    }
    /* handle error condition */
    return "";
}

template<typename T, typename G>
float raNge1(T a, G b){
    return float(a) / float(b);
}
