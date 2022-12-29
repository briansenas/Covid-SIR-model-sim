# Apartado 2:
    #a) Menor que b/a
f1="sir-a:0.001-b:0.125-dt:0.1-I:1-S:62.5-R:0-M:1-C:0.txt"
apt="2-Menor_que_B_A_no_C"
gnuplot -e "filename='$f1';apartado='$apt'" "getGraphs.plt"
f1="sir-a:0.001-b:0.125-dt:0.1-I:1-S:62.5-R:0-M:1-C:1.txt"
apt="2-Menor_que_B_A"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt
    #a) Igual que b/a
f1="sir-a:0.001-b:0.125-dt:0.1-I:1-S:125-R:0-M:1-C:0.txt"
apt="2-Igual_que_B_A_no_C"
gnuplot -e "filename='$f1';apartado='$apt'" "getGraphs.plt"
f1="sir-a:0.001-b:0.125-dt:0.1-I:1-S:125-R:0-M:1-C:1.txt"
apt="2-Igual_que_B_A"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt
    #a) Mayor que b/a
f1="sir-a:0.001-b:0.125-dt:0.1-I:1-S:187.5-R:0-M:1-C:0.txt"
apt="2-Mayor_que_B_A_no_C"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt
f1="sir-a:0.001-b:0.125-dt:0.1-I:1-S:187.5-R:0-M:1-C:1.txt"
apt="2-Mayor_que_B_A"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt

# Apartado 4:
    #a) Implementamos cuarentena:
f1="sir-a:0.0001-b:0.125-dt:0.1-I:1-S:125-R:0-M:1-C:1.txt"
apt="4-Cuarentena"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt
    #b) Mejoramos las vacunas/medicinas:
f1="sir-a:0.001-b:0.25-dt:0.1-I:1-S:125-R:0-M:1-C:1.txt"
apt="4-Vacunas"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt
    #c) La imunidad ahora dura más tiempo:
f1="sir-a:0.001-b:0.125-dt:0.1-I:1-S:125-R:0-M:1-C:1.txt"
apt="4-Imunidad"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt

# Apartado 5
    # a) Número de infectados inciales mayor
f1="sir-a:0.001-b:0.125-dt:0.1-I:10-S:125-R:0-M:1-C:1.txt"
apt="5-MasInfectados"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt
    # b) Número de recuperados inciales mayor
f1="sir-a:0.001-b:0.125-dt:0.1-I:1-S:125-R:125-M:1-C:1.txt"
apt="5-MasRecuperados"
gnuplot -e "filename='$f1';apartado='$apt'" getGraphs.plt
