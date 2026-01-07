#!/bin/bash
trap "echo The script is terminated; exit" SIGINT
gnuplot -p gnuplot_gpu_example.plt &
