#!/bin/bash

echo "My timing report script"

for m in exact approx   # mode
do
cd ${m}
for op in mul div sqrt  # operation
do
cd ${op}
touch results/delay.csv
R="$PWD/results/delay.csv"
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
        grep -e 'data arrival' *timing.report | sed '1q' | awk 'NF>1{printf $NF}' >> $R
        if [ $f = 'unconstrained' ]; then
                echo ',MET' >> $R
        else
                grep -e 'slack' *timing.report | sed 's/[()]//g' | awk '{print "," $(NF-1)}' >> $R
        fi

        cd ../
done
cd ../
done
cd ../
done
cd ../
done
