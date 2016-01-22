#Energy Harvesting For The Internet-of-Things: Measurements And Probability Models (Testbed and Analysis Code)

This repository provides code that accompanies the paper *Energy Harvesting For The Internet-of-Things: Measurements And Probability Models*.


The code provided is split across two sub-folders:

 - **Testbed**: This code runs on the Arduino platform, and performs periodic sampling of harvested energy from a Linear Technologies DC2080A Energy Harvesting (EH) Multi-Source Demo Board, saving data to a CSV file on an SD card using a compatible Arduino Shield.
 - **Analysis**: This folder contains Matlab code which takes CSV files produced by the Arduino, filters the data, and provides analysis as found in the paper.

Each of the sub folders has another readme file, which further details the use of the contained files.
