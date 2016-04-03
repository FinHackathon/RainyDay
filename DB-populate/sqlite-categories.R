###
# Libs
###
source(paste(db_populate_path,"/database_require.R",sep=""))


df<-data.frame(rbind(c("Restaurants", paste("Meal, Inexpensive Restaurant", "Meal for 2 People, Mid-range Restaurant, Three-course", "McMeal at McDonalds (or Equivalent Combo Meal)", "Domestic Beer (0.5 liter draught)", "Imported Beer (0.33 liter bottle)", "Cappuccino (regular)", "Coke/Pepsi (0.33 liter bottle)", "Water (0.33 liter bottle)",sep="::")),
                     c("Markets", paste("Milk (regular), (1 liter)", "Loaf of Fresh White Bread (500g)", "Rice (white), (1kg)", "Eggs (12)", "Local Cheese (1kg)", "Chicken Breasts (Boneless, Skinless), (1kg)", "Beef Round (1kg) (or Equivalent Back Leg Red Meat)", "Apples (1kg)", "Banana (1kg)", "Oranges (1kg)", "Tomato (1kg)", "Potato (1kg)", "Onion (1kg)", "Lettuce (1 head)", "Water (1.5 liter bottle)", "Bottle of Wine (Mid-Range)", "Domestic Beer (0.5 liter bottle)", "Imported Beer (0.33 liter bottle)", "Pack of Cigarettes (Marlboro)",sep="::")),
                     c("Utilities (Monthly)", paste("Basic (Electricity, Heating, Water, Garbage) for 85m2 Apartment", "1 min. of Prepaid Mobile Tariff Local (No Discounts or Plans)", "Internet (10 Mbps, Unlimited Data, Cable/ADSL)",sep="::")),
                     c("Sports And Leisure", paste("Fitness Club, Monthly Fee for 1 Adult", "Tennis Court Rent (1 Hour on Weekend)", "Cinema, International Release, 1 Seat",sep="::")),
                     c("Clothing And Shoes", paste("1 Pair of Jeans (Levis 501 Or Similar)", "1 Summer Dress in a Chain Store (Zara, H&M, ...)", "1 Pair of Nike Running Shoes (Mid-Range)", "1 Pair of Men Leather Business Shoes",sep="::")),
                     c("Rent Per Month", paste("Apartment (1 bedroom) in City Centre", "Apartment (1 bedroom) Outside of Centre", "Apartment (3 bedrooms) in City Centre", "Apartment (3 bedrooms) Outside of Centre",sep="::")),
                     c("Buy Apartment Price", paste("Price per Square Meter to Buy Apartment in City Centre", "Price per Square Meter to Buy Apartment Outside of Centre",sep="::")),
                     c("Salaries And Financing", paste("Average Monthly Disposable Salary (Net After Tax)", "Mortgage Interest Rate in Percentages (%)",sep="::"))))


df<-data.frame(cbind(1:nrow(df),df))
dimnames(df)[[2]]<-c("ID",expense_categories_table_name,paste(expense_categories_table_name,"subcat",sep="_"))
## Create an in HDD database
ok <- dbWriteTable(db, expense_categories_table_name, df, row.names = FALSE, overwrite=TRUE)
stopifnot(ok)

# Verify
df_read<-dbReadTable(db, expense_categories_table_name);
stopifnot(sum(df_read!=df)==0)
stopifnot(dbDisconnect(db))

