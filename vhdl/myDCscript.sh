#!/bin/bash

echo "My dc_shell script"

# declare -A constraints=( [8]=1.0 [16]=2.0 [32]=3.0 )

for m in exact approx   # mode
do
for op in mul div sqrt  # operation
do
for bw in 32            # bit width
do
# try different timing constraints / frequency
for f in unconstrained 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1050 1100 1150 1200
do
        if [ $f = 'unconstrained' ]; then
                dir="${f}"
        else
                dir="${f}_MHz"
                # Compute clock period from frequency
                freq=$(awk -v c=$f 'BEGIN {print (1000 / c) }')
        fi

        rm -rf "${m}/${op}/${bw}_bits/${dir}/"
        mkdir -p "${m}/${op}/${bw}_bits/${dir}/"
        cp "${m}/${op}/s1" "${m}/${op}/${bw}_bits/${dir}/"
        cd "${m}/${op}/${bw}_bits/${dir}/"
        # Limit delay
        if [ $f != 'unconstrained' ]; then
                sed -i "s/\#set_max_delay 1 \[all_outputs\]/set_max_delay ${freq} [all_outputs]/g" s1
        fi
        echo ""
        echo ""
        echo "$PWD"
        echo "******** item: ${bw} bits - ${dir}"
        echo ""
        echo ""
        dc_shell-t -f s1
        #ls *.vhdl
        cd ../../../..
done
done
done
done
