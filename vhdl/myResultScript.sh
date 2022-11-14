#!/bin/bash

for m in exact approx   # mode
do
    for op in mul div sqrt  # operation
    do
        rm -rf ${m}/${op}/results
        mkdir -p ${m}/${op}/results
    done
done

bash myAreaScript.sh
bash myPowerScript.sh
bash myTimeScript.sh

for m in exact approx   # mode
do
    for op in mul div sqrt  # operation
    do
        python elaborate_json.py ${m}/${op}/results  ${m}/${op}
    done
done

# python group_json.py

