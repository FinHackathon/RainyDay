###
# Libs
### setwd(paste(getwd(),"/skroutz",sep=""))
source(paste(db_populate_path,"/database_require.R",sep=""))

if(0){ # not working yet
df_read_coubtrie<-dbReadTable(db, countries_table_name);
# Create Empty DF

df<-data.frame(cbind(1:nrow(df),df))
dimnames(df)[[2]]<-c("ID",cities_table_name,paste(cities_table_name,"subcat",sep="_"))
## Create an in HDD database
ok <- dbWriteTable(db, cities_table_name, df, row.names = FALSE, overwrite=TRUE)
stopifnot(ok)

# Verify
df_read<-dbReadTable(db, cities_table_name);
stopifnot(sum(df_read!=df)==0)
stopifnot(dbDisconnect(db))

# Verify
write.csv(df,row.names=FALSE,file=paste("./data/csv-prototyping/",expense_categories_table_name,".csv",sep=""))
}