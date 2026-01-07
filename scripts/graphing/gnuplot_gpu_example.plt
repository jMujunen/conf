bind "x" "i = 1"
i=100
set title "GPU"
set xlabel "Time"
set ylabel "Values"
set grid

set datafile separator comma

set xrange [1:100]
set yrange [1:300]
set key Left left reverse box samplen 2 width 2

set ytics (15,30,45,60,75,90,105,120,135,150,165,180,195,210,225,240,255,270,285,300)

while i==100 {
    plot "< tail -100 /tmp/hwinfo.csv" using 9 with lines title "Usage" linewidth 2 linecolor "#3B6B59",\
    "< tail -100 < /tmp/hwinfo.csv" using 13 with lines title "Power" linewidth 2 linecolor "#FFB356"
    pause 1
}
