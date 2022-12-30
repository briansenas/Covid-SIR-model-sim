#include <iostream>
#include "utils.h"
#include <chrono>
#include <iomanip>
#include <sstream>
#include <fstream>
#include <unistd.h>
using namespace std;
using namespace std::chrono;


float a, b, c, C, dt;
float tinic, tfin, t;
unsigned int comm_int, ci=0, numeq = 3;
ofstream myfile;
bool streambuffer;

float* estado;
float* oldestado;
float* f;
float** k;

bool imunidad, runge;
chrono::duration<double, std::milli> duracion;

int main(int argc, char* argv[]){

    if(argc<=12){
        cerr << "[ERROR]: Execution Format Wrong." << endl;
        cerr << "./main salida(0:tty,1:file) capacidad_infecciosa(>0.0,inf) duracion_enfermedad(>0.0,inf)" <<
        "dt_(>0.0,inf) intervalo_comunicacion tiempo_inicial(0.0,inf) tiempo_final(0.0,inf)" <<
        "Infectados(0.0,inf) Susceptibles(0.0,inf) Recuperados(0.0,inf)" <<
        "metodo_integracion(0:euler,1:runge) imunidad(0:sin-recaer,1:recaer) duracion_imunidad(0,inf)" << endl;
        exit(-1);
    }

    // Leemos argumentos de entrada.
    streambuffer = atoi(argv[1]);
    a = atof(argv[2]);
    b = atof(argv[3]);
    dt = atof(argv[4]);
    comm_int = atoi(argv[5]);
    if(comm_int <= 0){
        comm_int = 1;
    }
    tinic = atof(argv[6]);
    tfin = atof(argv[7]);
    float I = atof(argv[8]);
    float S = atof(argv[9]);
    float R = atof(argv[10]);


    // Reservamos memoria para las variables globales.
    estado = new float[numeq];
    oldestado = new float[numeq];
    f = new float[numeq];
    k = new float*[numeq];
    for(unsigned int i=0;i<numeq;i++){
            k[i] = new float[4];
    }

    // Definimos método de integración y derivadas a utilizar.
    runge = atoi(argv[11]);
    imunidad = atoi(argv[12]);
    if(imunidad){
        if(argc<=13){
            cerr << "[ERROR]: Para activar la imunidad, tienes que pasar el parámetro la duración de esta" << endl;
            exit(-1);
        }
        C = atof(argv[13]);
        c = 1.0/C;
    }

    // Valores iniciales para variables globales.
    f[0] = f[1] = f[2] = 0;
    estado[0] = I;
    estado[1] = S;
    estado[2] = R;

    // Abrimos el archivo si fuera necesario
    if(streambuffer==1)
        openfile();

    // Inicializamos temporizador
    auto start = high_resolution_clock::now();
    duracion = start-start;
    t=tinic;
    // Empezamos a ejecutar el código.
    integracion();
    if(streambuffer)
        myfile.close();
}
