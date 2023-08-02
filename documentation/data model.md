# Data model
Data model of aero db consist of two environments - staging area and data mart. They both contains set of 10 identical tables. In this set there are 2 fact tables and 8 dimension tables in star schema. The departures table (fact) stores information about departures from Prague airport to other europen cities including airport revenue, delay in minutes. The passengers fact table contains information such as ticket price about passengers from flights in the departures table. Currency of the data set is euro.  

