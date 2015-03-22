## Code book
### Analysis process

The analysis script, run_analysis.R reads in the processed experiment data and performs a number of steps to produce final file.

Both the processed test and training datasets are read in and merged into one data frame.
The data columns are then given names based on the features.txt file.


The activity identifiers are replaced with the activity labels based on the activity_labels.txt file.
Invalid characters (() and - in this case) are removed from the column names. Also, duplicate phrase BodyBody in some columns names is replaced with Body.


Each line in run_analysis.R is commented. Reference the file for more information on this process.

### More information

Detailed information on the experiment and the data can be found in the README.txt and features_info.txt files included in the experiment data zip file or find more information on the dataset homepage.