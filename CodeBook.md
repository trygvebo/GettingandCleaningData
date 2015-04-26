Codebook for the data set "mean_table.txt"
=========================================
written by: Trygve Børsting


Description
-----------
The data set "mean_table.txt" was created as a part of the assignment for the 
Coursera course 'Getting and Cleaning Data.' The data set is based on the data
provided in the assignment (the original data source is: Anguita, D.  
Ghio, A. and Oneto, L., Parra, X. Reyes-Ortiz, J. L. 'Human Activity Recog-
nition Using Smartphones Dataset', 21st European Symposium on Artificial Compu-
tional Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 Ap-
ril 2013). The data set has been processed according to instructions given in
the assignment, for further details see the following section on method and R-
script provided in the repo. As required in the assignment the data set contains
the mean of each measurement for each activity for each test subject. 


Code Book
---------
The data set contains four variables:

"Subject_ID" - this column contains the ID assigned to each test subject in
the original data set, there are 30 different test subjects in the data set.

"Type_of_Activity" - this column contains the different activities that the
test subjects preformed when the measurement where made. This is in accordance 
with the list of activities in the original data. There is in total six differ-
ent activities.

"Type_of_Measurement_Data" - this column contains the name of the type of data-
that was measured as listed in the orignal data set. 

"Mean_of_Measurements" - this column contains mean of each type of measurement
for each type of activity for each test subject, as has been specified by the
previously mentioned variables. 


Description of Method
---------------------
This section describes the method by which the mean_table data set was created.
For the aid of readability R-script has been divided into sections with
titles denoted by "##" and comments by "#". The titles from the script is also
used as headers in this description.

Getting R ready - the first step get R set up by loading the relevant
packages and setting the work directory. The work directory should be the folder
containing the folder with the original raw data. 

Load column names - the second step is to load the text file containing the 
names of the different columns in the data set representing the different types 
of measurements. This was done by opening a connection to the file and using the
command "readLines". Afterwards closing the connection to the file.

Load train table - the next step was to load the train data. This was done by
using the 'read.table' command. First loading test subject IDs, second loading
the variable identifying the different activities test subjects preformed, third 
loading the observational data itself using 'read.table' with the options 'sep=
""' so that R read the white space as separators and 'col.names=cnames' where 
'cnames' is the object containing the names of the columns to observational data
previously loaded. Last the three data sets where combined with 'cbind' to form
one data frame.

Load test table - same as previous step except that it loaded the data in the
train folder instead. 

Combine train and test table - this steps combine the two data frames 
'train_table' and 'test_table' created in the two steps above using 'rbind'
command.

Select mean and standard deviation - Using the 'select' command to filter out 
the mean and standard deviation. Using the option 'contains' to find all 
variables measuring means (searching for 'mean') and standard deviations 
searching for 'std') respectively. Using the 'ignore.case=TRUE' option allowed 
for all relevant variables to be selected. As the columns containing mean and 
standard deviation meausres were filtered out into seperate data frames they had
to be pasted together again with cbind also adding the data frame 'id_table' 
which contained the identificator variables (ID and activity type). 

Reformatting the table - to obtain a workable amount of columns for the 
assignment the table was transformed into a narrow format using the 'gather' 
function, where the different forms of measurement contained in the different 
columns where moved into a new column called 'data_type' (later renamed 
"Type_of_Measurement"). ID and Excerise was not changed by the 'gather' function
as they are already in the desired format.

Rename activities - By applying the mutate function the variables in the 
Excerise column was changed from numeric to character variables describing the 
activities corresponding to the key given in the 'activity_labels.txt' file in 
the original data set. This was done by changing the variable to a factor and 
applying the appropriate labels. 

Rename columns - all the columns names were changed to give more descriptive
names by using the command 'rename'. 

Summarise the data - all the data was summarised in a new table in accordance 
with the requirements of the assignment. This was done by first grouping the 
data with the 'group_by' grouping the variables after the columns variables 
Subject_ID, Type_of_Activity, Type_of_Measurement_Data. The data was summarised
with the command 'summarise' using the option 
'Mean_of_Measurements=mean(Measurement_Data)' which allowed for the mean being 
taken on all measurements according the the grouping assigned by 'group_by' 
command. That is mean of each type of measurement for each activity for each
test subject, this in accordance with the requirements of the assignment.

Print data - the data printed to a text file by using the command 'write.table'
with the option 'row.name=FALSE' in accordance with the instructions given in 
the assignment.