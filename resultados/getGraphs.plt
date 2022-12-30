set encoding utf8
set terminal png size 1280, 720 enhanced font "Alegreya,18"
# set terminal pngcairo size 1280, 720 enhanced color dashed font "Alegreya, 14" \
# set terminal pdfcairo enhanced color dashed font "Alegreya, 14" \
# set terminal epslatex color colortext
# rounded size 16 cm, 9.6 cm
set print "-"
set key on
set key bottom right
set auto
set grid
set size 1,1
set macro

# Standard border
set style line 11 lc rgb '#808080' lt 1 lw 3
set border 0 back ls 11
set tics out nomirror

# Standard grid
set style line 12 lc rgb '#808080' lt 0 lw 1
set grid back ls 12
# unset grid

set style line 1 lc rgb '#E41A1C' pt 1 ps 1 lt 1 lw 1 # red
set style line 2 lc rgb '#377EB8' pt 6 ps 1 lt 1 lw 1 # blue
set style line 3 lc rgb '#4DAF4A' pt 2 ps 1 lt 1 lw 1 # green
set style line 4 lc rgb '#984EA3' pt 3 ps 1 lt 1 lw 1 # purple
set style line 5 lc rgb '#FF7F00' pt 4 ps 1 lt 1 lw 1 # orange
set style line 6 lc rgb '#FFFF33' pt 5 ps 1 lt 1 lw 1 # yellow
set style line 7 lc rgb '#A65628' pt 7 ps 1 lt 1 lw 1 # brown
set style line 8 lc rgb '#F781BF' pt 8 ps 1 lt 1 lw 1 # pink

file_exists(file ) = system("[ -f '".file."' ] && echo '1' || echo '0'") + 0

set palette defined ( 0 "red", 1 "green")
set cbrange[0:1]
# color(y) = y >= 0 ? (255*65535) : (255*255)


dir = "graphs/".apartado
system "mkdir ".dir

# https://stackoverflow.com/questions/37674787/gnuplot-get-value-of-a-particular-data-in-a-datafile-with-or-without-using-sta
getValue(row,col,filename) = system('awk ''{if (NR == '.row.') print $'.col.'}'' '.filename.'')

set key outside
set key bottom right

# lines = floor(system("wc -l media1-120-0-40.txt"))
outname = dir."/all.png"
set output outname
set xlabel "tiempo"
set title "Evolución en el tiempo de cada parámetro"
plot filename u :1 with lp lw 1 title "Infectados", \
filename u :2 with lp lw 1 title "Susceptibles", \
filename u :3 with lp lw 1 title "Recuperados"

set key inside

outname = dir."/t-I.png"
set output outname
set xlabel "tiempo"
set ylabel "infectados"
set title "Evolución de infectados con el tiempo"
plot filename u :1 with lp lw 1 title "Evolución de infectados con el tiempo"

outname = dir."/t-R.png"
set output outname
set xlabel "tiempo"
set ylabel "recuperados"
set title "Evolución de recuperados con el tiempo"
plot filename u :3 with lp lw 1 title "Evolución de recuperados con el tiempo"

outname = dir."/t-S.png"
set output outname
set xlabel "tiempo"
set ylabel "susceptibles"
set title "Evolución de susceptibles con el tiempo"
plot filename u :2 with lp lw 1 title "Evolución de susceptibles con el tiempo"

outname = dir."/I-R.png"
set output outname
set xlabel "infectados"
set ylabel "recuperados"
set title "Infectados versus recuperados en el tiempo"

plot filename u 1:3 with lp lw 1 title "Infectados versus recuperados en el tiempo"

outname = dir."/I-S.png"
set output outname
set xlabel "infectados"
set ylabel "susceptibles"
set xrange [*:*] reverse
set title "Infectados versus susceptibles en el tiempo"
plot filename u 1:2 with lp lw 1 title "Infectados versus susceptibles en el tiempo"

outname = dir."/S-R.png"
set output outname
set xlabel "susceptibles"
set ylabel "recuperados"
set title "Susceptibles versus recuperados en el tiempo"
plot filename u 2:3 with lp lw 1 title "Susceptibles versus recuperados en el tiempo"
