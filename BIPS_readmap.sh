#! /bin/bash

#SBATCH -p General  # which partition to use
#SBATCH -J BIPS_readmap  # give the job a custom name
#SBATCH -o results-%j.out  # give the job output a custom name
#SBATCH -t 0-02:00  # two hour time limit

#SBATCH -N 1  # number of nodes (you will most likely never need more than 1 node)
#SBATCH -n 1  # number of cores (AKA tasks)
#SBATCH --mem=20G #how much memory to use 

#load modules
module load bowtie2/bowtie2-2.3.1-python-2.7.14
module load samtools/samtools-1.10

#make index for genome
bowtie2-build ../data/chr2.fa mm10

#run bowtie2 mapping
bowtie2 -x mm10 -1 ../data/wt_H3K4me3_read1.fastq -2 ../data/wt_H3K4me3_read2.fastq -S mm10.sam

#sort sam file 
samtools sort -o mm10.sorted.bam mm10.sam

#index bam
samtools index mm10.sorted.bam
