#!usr/bin/perl
#This is a script to go over several files with SRA IDs and then download SRA files usign fastq-dump

#Get all files with SRA Ids from directory
my @txt = glob "rapt_cerro.txt";

#read each file at a time
foreach $filename (@txt){

#open file using file handler
open INPUT, "<", $filename;

#check each line at a time                         
while(defined($line=<INPUT>)){

#chomp($line);

#run fastq-dump

open FASTQ, "run_rapt.py -D singularity -a $line -o ./rapt_out/ --organism "Salmonella enterica" --tag $line";
close FASTQ;
}
close INPUT;
}

