# Prediction-About-the-2017-Grammy-Awards
Big Data Analytics Final Project 201612-100
In this directory, you will find all the codes we use in this project, including:
1. "Spark_Command.txt" -- In "/Spark" directory. Open this document and copy its material line by line to the command window and run
2. "Total_Weeks.py" -- In "/Spark" directory. Python script needed when using Spark to do word count
3. "scrape.py" -- Python script for scraping data from Internet. Just type "python scrape.py" in the command window to run this code.
   Requirements for this code are a) requests b) html5lib c) beautifulsoup4
4. "KeyFeatureExtraction.m" -- MATLAB code to set up songs trend library and extract the key feature. Click "run" in MATLAB to run this      codes. The directory of this code should also have "us_billboad.psv" inside.
5. "KeyFeatureExtraction.py" -- PyCUDA code to set up songs trend library and extract the key feature using Parallel Computing technique.
   Requirements for this code are a) Anaconda 2.7 b) theano c) NVIDIA CUDA Toolkit 8.0 d) Microsoft Visual Studio 2013
   The directory of this code should also have "us_billboad.psv" inside.
6. "BPANN.m" -- In "/Predict" directory. MATLAB code to train and use the Backpropagation Artificial Neural Networks. Just click "run" in MATLAB to run this code.
   The directory of this code should also have "training79.txt" and "forecast79.txt" inside.
