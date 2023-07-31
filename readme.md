# Text Cleaning Workflow

This repo contains two simple files that executes many forms of NLTK's text cleaning functionality on a directory of txt files.

## File Overview

The files consist of:

1. [text_cleaning_pipeline.py](text_cleaning_pipeline.py): Runs tfidf on a corpus, exporting a .csv organized by input files.
2. [text_cleaning.sbatch](text_cleaning.sbatch): Creates a batch job for text_cleaning_pipeline.py.

## Usage instructions

1. ssh into Farmshare with the syntax: 
```
ssh yourSUNetID@rice.stanford.edu
```
2. Once you get on Farmshare, you'll need to move to the learning environment for these files:
```bash
cd /farmshare/learning/scripts/scripts/text_cleaning
```
3. Let's also make three directories for the outputs of our process:
```
mkdir ~/out ~/err /scratch/users/$USER/outputs
```
4. At this point we can submit our script:
```
sbatch text_cleaning.sbatch
```
You can watch your program run with
```
watch squeue -u $USER
```
## Code Explanation

### text_cleaning_pipeline.py 

This file performs standard forms of preprocessing for text files including tokenization, lowercasing, punctuation removal, stop word filtering, and lemmatization. The output/input variable (words) remains 
the same throughout the script, so you should be able to comment out any processes you don't desire and still run the script.

###  text_cleaning.sbatch 

Pretty standard sbatch file. Depending on the size of the corpus, "time" and "mem" may need to be tweaked if you are getting "wall time" or "out of memory" errors respectively.

```bash
#!/bin/bash
#SBATCH --job-name=cleaning					# gives the job a descriptive name that slurm will use
#SBATCH --output=/home/%u/out/cleaning.%j.out			# the filepath slurm will use for output files. I've configured this so it automatically inserts variables for your username (%u) and the job name (%j) above.
#SBATCH --error=/home/%u/err/cleaning.%j.err			# the filepath slurm will use for error files. I've configured this so it automatically inserts variables for your username (%u) and the job name (%j) above.
#SBATCH -p hns							# the partition slurm will use for the job. Here it is normal, but you can use other partitions (sinfo to see which you can access)
#SBATCH -c 1							# number of cores to use. This should be 1 unless you've rewritten the code to run in parallel
#SBATCH --mem=32GB						# memory to use. 32GB should be plenty, but if you're getting a memory error, you can increase
pip3 install nltk						# download nltk
pip install --upgrade certifi					# allow nltk to download files
python3 -m nltk.downloader all					# download nltk files
python3 text_cleaning_pipeline.py				# run the python script
```

#### Notes

[^1]: Scratch systems offer very fast read/write speeds, so they're good for things like I/O. However, data on 
scratch is deleted every 60 days if not modified, so if you use scratch, you'll want to transfer results back to your home directory.
