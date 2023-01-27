

<div><img align=left width=200px height=120px src="https://github.com/geethakan/proj2-ETL-foodinspection/blob/main/Images/inspections.jpg">
  
# ETL Mini Project - Food Inspections
  
This is a mini project done as a group and purposed to practice teamwork and collaborative problem-solving. Timeframe was very limited and division of labor made it possible to accomplish the task.</div>


## Contributors
  
- Heather Robson
- Enrique Bouche
- Camille Jensen
- Geetha Kandukuri
  
  
## DataSets

<div> Source: <a href="https://data.cityofchicago.org/Health-Human-Services/Food-Inspections/4ijn-s7e5" target="_blank">Chicago Data Portal - Food Inspections.</a> 
Dataset #1 - Inspections of restaurants and food establishments in Chicago from January 2010 thru Jun 2018. Downloaded as csv. Dataset #2 - API call was used to get 
inspection details from Jul 2018 thru Jan 2023 in json format.</div>
  
  | Column Name   | Type    | Description              |
  | ------------- | ------- | ------------------------ |
  | Inspection Id | Int     | Unique Id per inspection 
  | DBA Name      | String  | Business Name            
  | AKA Name      | String  | Also Known As Name
  | License #     | Int | License number for Business
  | Facility Type | String  | Business Type
  | Risk          | String  | Risk and Category
  | Address       | String  | Street address
  | City          | String  | City
  | State         | String  | 2 alpha State
  | Zip           | Int     | 5 digit zip
  | Inspection Date | Date  | date in USA format
  | Inspection Type | String | Nature of inspection
  | Results         | String | Pass/Fail/Conditional
  | Violations      | String | Violation number followed by description followed by comments
  | Latitude        | Float  | Latitude 
  | Longitude       | Float  | Longitude
  | Location        | String | Latitude and Longitude in dictionary format
  

## Extract

- We sourced our original data from the Chicago Data Portal. We extracted two different data sets containing food inspection instances in Chicago and surrounding areas. 
- The first data set contains food inspection instances from 1/1/2010-6/30/2018, and the second data set contains instances from 7/1/2018-Present.
- Both sets have the same keys, and the reason a new set was created after 7/1/2018 was because the definitions of violations changed.
- We extracted the first data set, Food Inspections- 1/1/2010-6/30/2018, as a CSV file. This source contained most of the data, with 173k food inspection instances.
- The second data set, Food Inspections- 7/1/2018-Present was extracted as a JSON file using an API call.
- The url= (https://data.cityofchicago.org/resource/qizy-d2wf.json) we used for the API call. 
- Using the data in the JSON file, we created a column heading list as well as an empty list to hold all data rows. Using a for loop we extracted our desired values and appended them to the list we created.
- From here, we created a data frame using the extracted rows and column header list.

## Transform

- Reviewing the food inspection data set, we chose "inspection_id" as the primary key due to the unique values across both data sets. 
- Right away we dropped 3 columns, "Latitude", "Longitude", and "Location". These keys did not contain relevant values to our desired data set as all 3 columns contained coordinates for their respected business.
- We renamed all the remaining columns in our CSV file to lower case with under-scores in place of spaces. We did this to ensure proper loading into PostgreSQL. 
- We loaded both datasets into pandas DataFrames and combined DataFrames into one single source.
- We changed "inspection_id", "license_id", and "zip" from float to integer. 
- We also changed "inspection_date" to datetime. JSON and CSV had different formats for their dates, so we had to change the format to match. 
- To clarify the "risk" column, we split the values in the column into 3 separate columns.
- The first column contained just the string value "Risk", which we deemed unnecessary and dropped the column. The second column contains the risk rank as an integer from 1-3, given in the original data set. The third column contains the level of risk from low-high, and we removed the parentheses enclosing the levels from the original column.
- Some risk values were blank; for these we added a value of "0". 
- We investigated the "results" column containing the outcome of each instance. Some rows were labeled "Out of Business". We dropped these rows as they serve no relevance due to their forced closure. 
- The original data set warns that there may have been duplicate values. To clean this, we found duplicate "inspection_id" values and dropped those.
- For purposes of this project, we dropped the "violations" column as the values of this column were too large to fit the database. In a real-world situation, this column would be imperative for analysis.

## Load

- We loaded our final data into a relational database for storage.
- We created a connection to PostgreSQL and used this to create a sqlalchemy engine.
- From here, we loaded our dataframe to SQL by doing a bulk insert into a PostgreSQL database table.
- We used SQL in PostgreSQL to create the table. 
- Finally, we commited our changes and closed the session. 

## Topic Chosen

- Given the timeframe and project requirements, we decided these data sets had the potential to meet the ETL requirements for this project.

## API Call Limitations

- The API call has a limitation of the number of records that can be extracted, therefore we only used this data as a way to illustrate for the purposes of this class how to combine two datasets together.
