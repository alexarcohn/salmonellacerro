#!/bin/bash

#Alexa Cohn 9/30/21
#Use SKESA to assemble the genome

cd $1
#run skesa
for f in *_1.fastq.gz
#insert an exit if matches in dir
do
if [ -d "${f%_1.fastq.gz}" ]
then
echo 'skip '${f}
continue
fi
echo 'assemble' ${f%_1.fastq.gz}
# Change k-mer sizes if needed by editing -k
/programs/skesa.centos6.9/skesa --reads $f,${f%_1.fastq.gz}_2.fastq.gz --cores 1 --memory 32 --use_paired_ends --contigs_out ${f%_1.fastq.gz}
done