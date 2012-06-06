#!/bin/sh
plot_data='set xrange [0:24]; set terminal png; set xtics 1; plot "< cat /proc/$$/fd/0" title "'"$1"'" with boxes;'
ruby tweets-histogram.rb $1 | gnuplot -p -e "$plot_data" > $1-tweets-histogram.png
