echo $TEST
export | grep TEST

export TEST=TEST

echo $TEST
export | grep TEST

unset TEST

echo $TEST
export | grep TEST