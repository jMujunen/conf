#!/bin/bash
trap "echo The script is terminated; exit" SIGINT
gnuplot -p gnuplot_cpu_example.plt &
