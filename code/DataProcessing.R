#Load libraries
library(data.table)
library(dplyr)
library(here)


#Load the data into data.tables
#Health poster
d1 <- fread(file.path("data", "raw", "Data Collection Sheet - Health 10.30 2_50-3_40.csv"))

#Time poster
d2 <- fread(file.path("data", "raw", "Data Collection Sheet - 30.10. - 9_34.csv"), 
            select = setdiff(names(fread(file.path("data", "raw", "Data Collection Sheet - 30.10. - 9_34.csv"), nrows = 0)), 
                             c("V7", "Darby Notes")))

#Placebo poster
d3 <- fread(file.path("data", "raw", "Data Collection Sheet - Control - 30.10 - 13.53.csv"), 
            select = setdiff(names(fread(file.path("data", "raw", "Data Collection Sheet - Control - 30.10 - 13.53.csv"), nrows = 0)), 
                             c("V7", "Additional Notes")))

#Health poster
d4 <- fread(file.path("data", "raw", "Data Collection Sheet - Health 11.4 1_50-4_10.csv"), 
            select = setdiff(names(fread(file.path("data", "raw", "Data Collection Sheet - Health 11.4 1_50-4_10.csv"), nrows = 0)), 
                             c("V7", "Additional Notes")))



#Add treatment type
d1 <- d1[, treatment := "Health poster"]
d2 <- d2[, treatment := "Time poster"]
d3 <- d3[, treatment := "Placebo poster"]
d4 <- d4[, treatment := "Health poster"]




#Combine tables
d <- rbind(d1, d2, d3, d4)


#Rename columns
old <- c("Obersavation Number", 
         "Use\n(Elevator = 0; Stairs = 1)",
         "Gender\n(Female=0; Male=1; Hybrid=2)",
         "Group Size\n(Single=0; Two people=1; More than two=2)",
         "Heavy Items\n(No=0; Yes=1)",
         "Notes"
         )

new <- c("obs_id",
         "stair_use",
         "gender",
         "group_size",
         "heavy_items",
         "notes"
         )

setnames(d, old, new, skip_absent = TRUE)


#Save combined data
fwrite(d, file.path("data", "processed", "CombinedData.csv"))

