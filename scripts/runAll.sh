# Get Script Directory to later find the bin path
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

# ./main salida(0:tty,1:file) capacidad_infecciosa(>0.0,inf) duracion_enfermedad(>0.0,inf)
# dt_(>0.0,inf) intervalo_comunicacion tiempo_inicial(0.0,inf) tiempo_final(0.0,inf)
# Infectados(0.0,inf) Susceptibles(0.0,inf) Recuperados(0.0,inf)
# metodo_integracion(0:euler,1:runge) imunidad(0:sin-recaer,1:recaer)
# duracion_imunidad(0,inf)

# Plain base model-testing:
echo -e "Plain-base-model-testing:"
# Euler model:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 200 0 0 1 180
# Runge model:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 200 0 1 1 180

$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 200 150 1 1 180
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 100 150 1 1 180

# \nApartado 2:
echo -e "\nApartado 2:"
echo -e "\ta) Menor que b/a"
# Menor que b/a = 125, sin posibilidad de recaer:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 62.5 0 1 0
# Menor que b/a = 125, con posibilidad de recaer:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 62.5 0 1 1 180
echo -e "\ta) Igual que b/a"
# Igual que b/a = 125, sin posibilidad de recaer:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 125 0 1 0
# Igual que b/a = 125, con posibilidad de recaer:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 125 0 1 1 180
echo -e "\ta) Mayor que b/a"
# Mayor que b/a = 125, sin posibilidad de recaer:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 187.5 0 1 0
# Mayor que b/a = 125, con posibilidad de recaer:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 187.5 0 1 1 180

# \nApartado 4.
echo -e "\nApartado 4"
echo -e "\t a) Implementamos cuarentena:"
# Implementamos cuarentena, valor de a decrece:
$SCRIPT_DIR/../bin/sir-model 1 0.0001 0.125 0.1 10 0 250 1 200 0 1 1 180
echo -e "\t b) Mejoramos las vacunas/medicinas:"
# Mejoramos los medicamentos/vacunas, b dobla:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.25 0.1 10 0 250 1 200 0 1 1 180
echo -e "\t c) La imunidad ahora dura más tiempo: "
# La imunidad dura más tiempo, aproximadamente el doble:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 100 150 1 1 360

# \nApartado 5:
echo -e "\nApartado 5"
echo -e "\t a) Número de infectados inciales mayor"
# Aumetamos el número de individuos infectados a 10.
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 50 200 0 1 1 180
echo -e "\t b) Número de recuperados inciales mayor"
# Aumetamos el número de individuos recuperados a la mitad.
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 50 500 1 1 180
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 50 500 1 0 180

# \nApartado 6:
echo -e "\nApartado 6"
# Euler:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.1 10 0 250 1 200 0 0 1 180
# Runge-kutta:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.05 10 0 250 1 200 0 1 1 180
# Euler :
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.05 10 0 250 1 200 0 0 1 180
# Runge-kutta:
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.01 10 0 250 1 200 0 1 1 180
# Euler :
$SCRIPT_DIR/../bin/sir-model 1 0.001 0.125 0.01 10 0 250 1 200 0 0 1 180
