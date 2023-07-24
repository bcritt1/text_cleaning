#!/usr/bin/bash
#SBATCH --job-name=cleaning
#SBATCH --output=/home/%u/out/cleaning.%j.out
#SBATCH --error=/home/%u/err/cleaning.%j.err
#SBATCH -p normal
#SBATCH -c 1
#SBATCH --mem=32GB
pip3 install nltk
pip3 install --upgrade certifi
python3 -m nltk.downloader all
python3 text_cleaning_pipeline.py
