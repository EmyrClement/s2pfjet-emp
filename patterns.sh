#!/usr/bin/env bash
mkdir output_ttbar200

for f in patterns_ttbar200/*.txt
do
fname=$(basename $f)
echo $f 
empbutler -c my_connections.xml do x0 buffers rx PlayOnce --inject $f
empbutler -c my_connections.xml do x0 buffers tx Capture
empbutler -c my_connections.xml do x0 capture

cp data/tx_summary.txt output_ttbar200/${fname/.txt/}_output.txt

done



