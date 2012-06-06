#!/bin/bash
plot_data='set xrange [0:24]; set terminal png; set xtics 1; plot "< cat /proc/$$/fd/0" title "'"$1"'" with boxes;'
ruby get-tweets-dates.rb $1 > $1-tweets-dates.rbon
ruby tweets-histogram.rb $1 | gnuplot -p -e "$plot_data" > $1-tweets-histogram.png
for day in "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" "Sunday"
do
	ruby tweets-histogram.rb $1 $day | gnuplot -p -e "$plot_data" > $1-$day-tweets-histogram.png
done
