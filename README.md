# Course-Project "Getting and Cleaning Data"

1. First one should download and unzip the folder into the working directory.
2. Than read the read.me file to learn how the data tables should be constructed.
3. We load activity_labels.txt and features.txt setting the values as characters.
4. To select all 'mean' and 'std'-including values, grep function is used.
5. To tidy the features, we exclude all '-','(',')' characters from their values.

6. Then we finally load and construct train and test data. Selecting X_train/test
frames by defined features and binding colums with 'subject' and 'activity' frames
in required order.

7. Train and test sets is row binded.
8. All column and activity values should be labelled properly to make the data tidy.
9. Then we make factors from two first (subject and activity) colums.
10. Now the analysis can be done via using some of reshape2 functions.
11. After all new data frame could be written to the file.

