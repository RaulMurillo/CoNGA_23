#!/bin/bash

echo "My area report script"

for m in exact approx   # mode
do
cd ${m}
for op in mul div sqrt  # operation
do
cd ${op}
touch results/area.csv
R="$PWD/results/area.csv"
for bw in 32            # bit width
do
cd "${bw}_bits/"

# try different timing constraints
for f in unconstrained 50 100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1050 1100 1150 1200
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
        grep -e 'Total cell area' *area.report | awk 'NF>1{print $NF}' >> $R

        cd ../
done
cd ../
done
cd ../
done
cd ../
done
