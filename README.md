# Simulación de Covid-19
Esto es un modelo de simulación que nos permite estudiar la propagación de
una enfermedad infecciosa denominado modelo __SIR__.
Supondremos una población de tamaño N que se divide en:
- Infectados, `I(t)`, que tienen la enfermedad y pueden contagiarla.
- Susceptibles, `S(t)`, que no tienen la enfermedad pero pueden contraerla.
- Retirados, `R(t)`, individuos que se han recuperado.

Tendremos un total de 3 ecuaciones diferenciales (no lineales). Pero además,
tenemos la posibilidad de suponer que las personas recuperadas pueden volver
a recaer en un segundo modelo embedido, que se puede seleccionar por parámetro.

Para ejecutar a nuestro modelo tenemos que hacer: `cmake . && make`.
Luego a continuación tenemos:
- `bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 187.5 0 1 1 180`
1. __Streambuffer__: Indica la salida del ejecutable. 0=Terminal, 1=Archivo.
    - Se guardan los resultados en un archivo con nombre único en `./resultados`
2. __a__: Constante que multiplica a `S·I`, indica la velocidad de propagación.
3. __b__: Constante que multiplica a `I`, indica el tiempo de enfermedad.
4. __dt__: Intervalos de tiempos para los modelos de integración.
5. __comm__: Intervalos de comunicación, cada cuando se escribe a `Streambuffer`.
6. __Tini__: Tiempo inicial.
7. __Tfin__: Tiempo final.
8. __I__: Población de infectados inicial.
9. __S__: Población de susceptibles inicial.
10. __R__: Población de recuperados inicial.
11. __runge__: Método de Integración. 0:Euler, 1:Runge.
12. __inmunidad__: Flag que determina si la inmunidad es finita. 0: Infinita, 1:Finita.
13. __c__: En caso de `inmunidad==1` es necesario especificar la duración.
- `scripts/runAll.sh`: Ejecuta todo los archivos necesarios para revisar los análisis realizados.
- `resultados/genGraphs.plt`: Genera todo las gráficas utilizadas en el mismo análisis.
    - Las gráficas se añaden a `resultados/graphs` en subcarpetas autodescriptivas por apartado.
