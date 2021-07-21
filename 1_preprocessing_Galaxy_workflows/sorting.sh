#!/bin/sh
# Script to sort 5'sensing-Seq non-deduplicated and unsorted reads

# set working directory
WORK_DIR="/data/Dokumente/uni/Doktorarbeit/20200506_tagRNA-Seq_sortieren/02_emails_rawData/raw_data/20210713_sort_BBDUK/"
BBDUK="/home/utee/bbmap/bbduk.sh"
INPUT_DIR="/data/Dokumente/uni/Doktorarbeit/20200506_tagRNA-Seq_sortieren/02_emails_rawData/raw_data/seq-Daten/"

PSS="PSS.fa"
TSS="TSS.fa"

cd $INPUT_DIR
for File in `find -type f -name \*.fastq.gz`; do 
# run bbduk to filter out PSS
bash $BBDUK in=$File out=$WORK_DIR"unassigned/"${File%.fastq.gz}"_unassigned_noPSS.fastq.gz" outm=$WORK_DIR"PSS/"${File%.fastq.gz}"_PSS_noTrim.fastq.gz" stats=$WORK_DIR"stats/"${File%.fastq.gz}"_PSS_stats.txt" ref=$WORK_DIR$PSS statscolumns=5 restrictleft=23 k=8

# run bbduk to filter out TSS
bash $BBDUK in=$WORK_DIR"unassigned/"${File%.fastq.gz}"_unassigned_noPSS.fastq.gz" out=$WORK_DIR"unassigned/"${File%.fastq.gz}"_unassigned.fastq.gz" outm=$WORK_DIR"TSS/"${File%.fastq.gz}"_TSS_noTrim.fastq.gz" stats=$WORK_DIR"stats/"${File%.fastq.gz}"_TSS_stats.txt" ref=$WORK_DIR$TSS statscolumns=5 restrictleft=23 k=8

rm $WORK_DIR"unassigned/"${File%.fastq.gz}"_unassigned_noPSS.fastq.gz"

# filter out PSS tags and 2 nt
bash $BBDUK in=$WORK_DIR"PSS/"${File%.fastq.gz}"_PSS_noTrim.fastq.gz" out=$WORK_DIR"PSS/"${File%.fastq.gz}"_PSS.fastq.gz" stats=$WORK_DIR"stats/"${File%.fastq.gz}"_PSS_trimming_stats.txt" ref=$WORK_DIR$PSS statscolumns=5 restrictleft=23 k=8 ktrim=l tp=2 overwrite=t

rm $WORK_DIR"PSS/"${File%.fastq.gz}"_PSS_noTrim.fastq.gz"

# filter out TSS tags and 2 nt
bash $BBDUK in=$WORK_DIR"TSS/"${File%.fastq.gz}"_TSS_noTrim.fastq.gz" out=$WORK_DIR"TSS/"${File%.fastq.gz}"_TSS.fastq.gz" stats=$WORK_DIR"stats/"${File%.fastq.gz}"_TSS_trimming_stats.txt" ref=$WORK_DIR$TSS statscolumns=5 restrictleft=23 k=8 ktrim=l tp=2 overwrite=t

rm $WORK_DIR"TSS/"${File%.fastq.gz}"_TSS_noTrim.fastq.gz"
done





#mkdir sorted_bam

