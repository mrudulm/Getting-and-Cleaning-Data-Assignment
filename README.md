Experiment Background - Human Activity Recognition Using Smartphones Dataset Version 1.0
----------------------------------------------------------------------------------------

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, 3-axial linear
acceleration and 3-axial angular velocity at a constant rate of 50Hz
were captured. The obtained dataset has been randomly partitioned into
two sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

Goal - Create an R script `run_analysis.R` that combines training and test data into one single tidy data.
----------------------------------------------------------------------------------------------------------

The R script is divided into following sections -

-   Getting data files from source and creating required R objects.

-   Merges the training and the test sets to create one data set.

-   Extracts only the measurements on the mean and standard deviation
    for each measurement.

-   Uses descriptive activity names to name the activities in the data
    set

-   Appropriately labels the data set with descriptive variable names.

-   From the data set in step 4, creates a second, independent tidy data
    set with the average of each variable for each activity and
    each subject.


Section 1 - Getting data files from source and creating required R objects.
---------------------------------------------------------------------------


Step 1 : Define variables for source url and desitnation file name.

Step 2 : Download source file from url and unzip the file in working
directory.

Step 3 : Set path for all txt files to be read.

Step 4 : Read all training and test files into data frames.

Step 5 : Read Feature names and Activity names into data frames.

Step 6 : Assign feature names to test and training sets.

Step 7 : Merge subject, activitity and feature readings into one single
data frame for training and test data.

At the end of step 7 , we will have two data frames df_training_set
and df_test_set for training and test data respectively where each
record will describe readings of various feature for every subjects.


Section 2 - Merges the training and the test data sets to create one combined data set.
---------------------------------------------------------------------------------------


Step 1 : Row bind df_training_set and df_test_test into a new data
set df_combined_set.


Section 3 - Extracts only the measurements on the mean and standard deviation for each measurement.
---------------------------------------------------------------------------------------------------


Step 1 : retrieve column indices into a numeric vector
`filtercolindices` for mean and std. deviation for every subject and
activity.

Step 3 : Using `filtercolindices` indices , retrieve subset of combined
data df_combined_set into a new data frame df_mean_std_set.


Section 3 - Uses descriptive activity names to name the activities in the data set
----------------------------------------------------------------------------------


Step 1 : Assign activity name for each record in the data set.

Step 2 : Remove activity ID column from the data set.


Section 4 - Appropriately label the data set with descriptive variable names.
-----------------------------------------------------------------------------


Step 1 : Provide Descriptive names based on feature information and
remove any special characters like '()'.

            t - Time
            f - Frequency
            Acc- Acceleration
            Mag - Magnitude 
            mean - Mean
            BodyBody - Body
            std - StdDev 
            


Section 5 - From the data set in section 4, creates a final independent tidy data set with the average of each variable for each activity and each subject.
-----------------------------------------------------------------------------------------------------------------------------------------------------------


Step 1 : Resulting data set from section 4 has multiple readings for
every activity for each subject. This section calculates mean for each
activity / subject. This task of grouping and calculating mean is
carried out using `aggregate` function.

Step 2 : Once grouping is done and mean is calculated, next setp is to
order the entire data set by subjectId and activity names which makes it
clear and easy to understand.

Step 3 : The final setp of the analysis file is to write the tidy data
into `tidydata.txt` file which will be created into working directry.
