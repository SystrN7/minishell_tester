#!/bin/bash

if [ ! -d ./test/ ]
then
        mkdir ./test/
fi

for i in `seq 1 $1`
do
        head -n 1 /dev/urandom > ./Random/test_random_$i.sh
done
