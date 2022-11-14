#!/bin/bash

echo "My power report script"

for m in exact approx   # mode
do
cd ${m}
for op in mul div sqrt  # operation
do
cd ${op}
touch results/power.csv
R="$PWD/results/power.csv"
for bw in 32            # bit width
do
cd "${bw}_bits/"
# try different timing constraints
for f in unconstrained 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1050 1100 1150 1200
do
        if [ $f = 'unconstrained' ]; then
                dir="${f}"
                freq=0
        else
                dir="${f}_MHz"
                # Compute clock period from frequency
                freq=${f}
        fi

        cd ${dir}
        printf ${bw},${freq}, >> $R
        grep -e '^Total.*mW$' *power.report | awk 'NF>1{p = $(NF-1) ; print p}' >> $R

        cd ../
done
cd ../
done
cd ../
done
cd ../
done
