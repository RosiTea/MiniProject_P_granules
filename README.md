# BMA_P_granules
Major executable model I worked on for my Part III Systems Biology Mini Project on modelling P granule polarisation in C. elegans embryo. 

The BioModelAnalyzer (BMA) models can be found in BMA_model_architectures and they can be easily imported into the BioModelAnalyzer webtool (https://biomodelanalyzer.org/tool.html). Simulation under correct initial conditions will reproduce the simulation data in the BMA_simulation_data folder. If 30 time steps were chosen for the simulation, the exported CSV files can be put into the same directory as the change_csv.sh file, so that a one-line command (bash change_csv.sh) can format all CSV files to the suitable format for data visualisation for the R scripts provided in ggplot_scripts. 

BMA: https://github.com/hallba/BioModelAnalyzer


## Notes on ODE_scripts
This folder contains Jupyter notebooks of our scripts for deterministic modelling, one of the other parts of our project. Please be aware that these codes have not been maintained in a high standard. These scripts were first created by jh2288@cam.ac.uk. I only modified them so I DO NOT OWN these scripts - please contact the author for usage or distribution. 

## Notes on ml_train_data
This folder contains the Machine Learning training data generated over 1200 Smoldyn simulations. This is one of the other parts of our project. The code will generate 1200 CSV files if completed, so for simplicity only the final CSV file is kept here. For more about Smoldyn and ML, see https://github.com/toby-clark4/Mini-Project.
