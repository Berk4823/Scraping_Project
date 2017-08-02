######################################################
######################################################
################### Data Munging #####################
######################################################
######################################################


BPrice = read.csv("BPrice.csv", stringsAsFactors = F)
# read in BPrice.csv

# The goal of the steps below is to enable manipulation of the price data in BPrice. Currently 
# it is all in one string, with each ticket price separated by a comma. I want to take out the 
# minimum and maximum prices, and make them into separate colums within BPrice.

Condense_BPrice = BPrice$Price
# Assigning the Price column of BPrice to this. 
Condense_BPrice = sapply(Condense_BPrice, function(x) strsplit(x, ","))
# Split the string delimited by ",".
Condense_BPrice = lapply(Condense_BPrice, as.numeric)
# Changing the class of the elements to numeric in order to now find the min and max.

Condense_BPrice = sapply(Condense_BPrice, {function(x) x[x != 0]})
# This step is removing all prices equal to 0 from each element of the list. The reason
# for this step is that there should not be any 0's, because this is for prices for tickets. 
# I do not want any to mess up calculations. (There were a few 0's to remove)

Min_Price = as.numeric(sapply(Condense_BPrice, min))
# Minimum
Max_Price = as.numeric(sapply(Condense_BPrice, max))
#Maximum

BPrice$Minimum_Price = Min_Price 
# Adding the column to BPrice
BPrice$Maximum_Price = Max_Price
# Adding the column to BPrice

#Next, I will clean up some of the strings

BPrice$Show_Name = sapply(BPrice$Show_Name, function(x) gsub("\"", "", x))
# Remove the "/" from the Show_Names column
BPrice$Show_Duration = sapply(BPrice$Show_Duration, function(x) gsub("\"", "", x))
# Remove the "/" from the Show_Duration column
BPrice$Theater = sapply(BPrice$Theater, function(x) gsub("\"", "", x))
# Remove the "/" from the Theater column

# There are some missing entries that when analyzed turn into "Inf" and -"Inf"--
# These entries actually reflect shows that are completely sold out. Given no real 
# price data for these shows exists, I am removing them. 

BPrice = BPrice %>% filter(!is.infinite(Minimum_Price) | !is.infinite(Maximum_Price))

# I also noticed that, unlike for any other show, Hamilton is completely sold out of non-premium
# seating (Dear Evan Hansen is completely sold out.) To reflect this, the minimum price is actually
# equal to the maximum price for this show. (Because those maximum prices are the only ones
# still available for purchase.)

BPrice$Minimum_Price[BPrice$Show_Name == "Hamilton"] = BPrice$Maximum_Price[BPrice$Show_Name == "Hamilton"]
BPrice = BPrice %>% filter(!(Show_Name == "Hamilton" & Minimum_Price < 500))

Performance = BPrice$Performance
# Assigning the Performance column to this.
Performance = sapply(Performance, function(x) strsplit(x, "T"))
# Split Performance delimited by "T".
Performance_Date = sapply(Performance, function(x) x[1])
# Assigning the Date to this.
Performance_Time = sapply(Performance, function(x) x[2])
# Assigning the Time to this.
Performance_Date = sapply(Performance_Date, function(x) gsub("\"", "", x))
# Remove the "/" from Performance_Date
Performance_Date = as.character(Performance_Date)
# Turn Performance_Date into a character vector.
Performance_Date = as.Date(Performance_Date)
# Turn Performance_Date into a date time object.
BPrice$Performance_Date = Performance_Date
# Adding this column to the BPrice Data Frame. 
BPrice$Performance_Month = month(BPrice$Performance_Date)
# Creating a new column called Performance_Month
BPrice$Performance_Day = wday(BPrice$Performance_Date)
# Creating a new column called Performance_Day

Performance_Time = as.vector(as.character(Performance_Time))
# Turn Performance_Time into a character vector
Performance_Time = sapply(Performance_Time, function(x) gsub("\"", "", x))
# Remove the "/" from Performance_Time
Performance_Time = sapply(Performance_Time, function(x) substr(x, 1, 8))
# Remove the last bunch of information, everything past the "-"
Performance_Time = unname(Performance_Time)
# Remove the names from Performance_Time
BPrice$Performance_Time = Performance_Time
# Adding this column to the BPrice Data Frame

BPrice = BPrice %>% select(Show_Name, Show_Duration, Theater, Capacity, Performance_Date, 
                           Performance_Month, Performance_Day, Performance_Time, 
                           Minimum_Price, Maximum_Price)
# Selecting only the columns I ultimately want, and reordering them. 

write.csv(BPrice, "BPrice_Final.csv", row.names = F)
# Write the output to a CSV. I will be using this data in Python to finish
# the remaining steps!

