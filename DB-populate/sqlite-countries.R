###
# Libs
###
source(paste(db_populate_path,"/database_require.R",sep=""))

library(stringr) # str_replace_all

###
# Param
###
file<-paste(original_path,"./CountriesQuery.csv",sep="")

countries<-read.csv(file)


clearName<-function(name){
  #name<-"\"Ã.land Islands\"@en"
  name<-iconv(name, to='ASCII//TRANSLIT') 
  name<-str_replace_all(name, "@en", "")
  name<-str_replace_all(name, "[[:punct:]]", "")
  return(name);
}

###
# Param
###
countries<-na.omit(countries)
# Create Empty DF
df <- data.frame(matrix(vector(),dim(countries)[1],dim(countries)[2]),
                 stringsAsFactors=F)
dimnames(df)[[2]]<-names(countries)
df[,1:3]<-countries

df[,1]<-unlist(lapply(df[,1],clearName))

## Create an in HDD database
ok <- dbWriteTable(db, countries_table_name, df, row.names = FALSE, overwrite=TRUE)
stopifnot(ok)

# Verify
df_read<-dbReadTable(db, countries_table_name);
stopifnot(sum(df_read!=df)==0)
stopifnot(dbDisconnect(db))

# Verify
write.csv(df,row.names=FALSE,file=paste("./data/csv-prototyping/",countries_table_name,".csv",sep=""))

