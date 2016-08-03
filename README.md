# Getting_and_Cleaning_dataset_project

Load the required library - dplyr in this case.
Download the required files and unzip them.
Read the column names from the feature test file.
Read the activity lables from the activity_labels file.
Read the dataset including the activity and subject from the test folder.
Read the dataset including the activity and subject from the train folder.
Merge the content of the test and train datasets.
Assign the col names to the merged dataset and select only the required columns (means and std).
Add the activity and subject columns to the merged dataset.
Assign proper description to the activity using the activity lable.
Assign proper value to the column names using gsub function.
Group the merged dataset by activity and subject.
Summarize the dataset to get the mean for each column.
Write the dataset to a text file (means.txt).
