#!/bin/bash

problemName=$1
directoryForRun=$2
fileName=$3
startingVal=$4
numCalls=$5
iterations=$6
kSteps=$7
simpSteps=$8

mkdir -p $directoryForRun

for ((j=1; j<=$iterations; j++)) do

	#Adjusts the scale of the value i
	scale=$(($j - 1))
	##Use the scale to determine the number of calls
	addToStart=$(($scale * $numCalls))
	#Put the previous two variables together to determine the value for i
	beginningIndex=$(($startingVal + $addToStart))
	
	for ((i=$beginningIndex; i<$beginningIndex + $numCalls; i++)) do
		nice lein run -m $problemName > $directoryForRun/$fileName$i.txt :simplification? true :simplification-k $kSteps :simplification-steps $simpSteps &
	done

	echo "Doing iteration $j"

	wait
done

wait

echo "Complete."
