# Course Project 3

The run_analysis.R script has the following assumptions:
- The dataset is available "./UCI HAR Dataset"
- The Dplyer package is installed on the machine

The script goes through the following key steps:
- Loads the Dplyer library
- Sets the working directory to where the data is
- Reads the data sets, merges them and sets "nice" column names
- Selects only columns containing the words "Mean" or "Std" (ignoring case)
- Prepends Subject and Activity to the dataframe (replacing activity ID by its name)
- Groups the data by Subject then by Activity and calculates the mean for each variable 
- Exports the data for submission

The script contains detailed comments to simplify readability 

Thank You!!
