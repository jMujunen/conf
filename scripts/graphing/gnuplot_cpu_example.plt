bind "x" "i = 1"
i=100
set title "CPU"
set xlabel "Time"
set ylabel "Values"
set grid

set datafile separator comma

set key Left left reverse box samplen 2 width 2

set xrange [1:1000]
set yrange [1:150]


set ytics (15,30,45,60,75,90,105,120,135,150)

while i==100 {
    plot "< tail -1000 /tmp/cpuinfo.csv" using ($1 * 100) with lines title "Voltage" linewidth 1 linecolor "#02de04",\
    "< tail -1000 < /tmp/cpuinfo.csv" using 4 with lines title "Max Temp" linewidth 1 linecolor "#db5a06",\
    "< tail -1000 < /tmp/cpuinfo.csv" using 5 with lines title "Avg Temp" linewidth 1 linecolor "#B6B59"

    pause 1
}
