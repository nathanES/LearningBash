#!/bin/bash

values=(39 5 36 12 9 3 2 30 4 18 22 1 28 25)
numvalues=${#values[@]}
for ((i = 0; i < numvalues; i++)); do
  lowest=$i
  for ((j = i; j < numvalues; j++)); do
    if [[ ${values[j]} -le ${values[$lowest]} ]]; then
      lowest=$j
    fi
  done
  temp=${values[i]}
  values[i]=${values[lowest]}
  values[lowest]=$temp
done
echo "Sorted: ${values[@]}"

values2=(39 5 36 12 9 3 2 30 4 18 22 1 28 25)
values2length=${#values2[@]}
for ((i = 0; i < values2length; i++)); do
  for ((y = 0; y < values2length - 1; y++)); do
    if ((values2[y] > values2[y + 1])); then
      temp=${values2[y + 1]}
      values2[y + 1]=${values2[y]}
      values2[y]=${temp}
    fi
  done
done
echo "Sorted2 : ${values2[@]}"
