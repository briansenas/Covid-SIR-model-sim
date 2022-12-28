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
- `bin/sir-model`
