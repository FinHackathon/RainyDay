# Status: Working, Fake Data

###
# Libs
###
source(paste(db_populate_path,"/database_require.R",sep=""))
#Good
df_countries<-dbReadTable(db, countries_table_name);
# df_cities<-dbReadTable(db, cities_table_name);
df_expenses<-dbReadTable(db, expense_categories_table_name);

#FAKE data generation
Ndata <- 1000 # number of instances of generated data
Nuser <- 50 # number of users

userID<- paste("user_",1:Nuser,sep="")
Expense<-c(0,1)
Amount<-rpois(Ndata,15)
Country<-c("United Kindom") #df_countries[,1]
City<-c("Edinburg", "Glasgow") #df_cities[,1]
Provider<-c("Tesco", "Stabucks", "Lidl", "NSF Dentist", "check", "coffee", "drink", "O2club", "Tesco", "Adil", "Train")
Products<-c("Beer::Dipers::Milk::Bannas::Cheese","Mocca Coffee","Nachos::Sandwich::Bread::Juice::Beef meat","Cleaning");
GCategories<-df_expenses[,1];
SCategories<-df_expenses
Entrie_methods<- c("bs::r","bs","r","h") # Bank_Statement, Receipt, HandWritten

df<-data.frame(matrix(NA,Ndata,11+1)) # stringdate

year <- 2012
month<-1
day<-2
hour<-1
min<-1
sec<-3.456



mysample<-function(year,month,day,hour,min,sec){
  user  <- (sample(userID,1))
  date  <- ISOdatetime(year,month,day,hour,min,sec,tz="UTC")
  
  expe  <- (sample(Expense,1,prob=c(.01,.99)))
  ammo  <- (sample(Amount,1))
  count <- (sample(Country,1))
  city  <- (sample(City,1))
  prov  <- (sample(Provider,1))
  prod  <- (sample(Products,1))
  gc    <- (sample(GCategories,1))
  sc    <- (sample(strsplit(SCategories[GCategories==gc,2],"::")[[1]],1))
  em    <- (sample(Entrie_methods,1,prob=c(.5,.3,.1,.1)))
  if(em=="bs"){
    prod<-""
  }
  if(expe==0){
    ammo<-rpois(1,1200)
  }
  
  return(c(user,date,toString(date),expe,ammo,count,city,prov,prod,gc,sc,em))
}

for(line in 1:Ndata){
  df[line,]<-mysample(year,month,day,hour,min,sec)
  
  sec <- sec + runif(1,0,3000)
  
  mod_val<-60
  if(sec%/%mod_val){
    min<-min+sec%/%mod_val
    sec<-max(sec%%mod_val,1)
  }
  
  mod_val<-60
  if(min%/%mod_val){
    hour<-hour+min%/%mod_val
    min<-max(min%%mod_val,1)
  }
  
  mod_val<-24
  if(hour%/%mod_val){
    day<-day+hour%/%mod_val
    hour<-max(hour%%mod_val,1)
  }
  
  mod_val<-29
  if(day%/%mod_val){
    month<-month+day%/%mod_val
    day<-max(day%%mod_val,1)
  }
  
  mod_val<-12+1
  if(day%/%mod_val){
    year<-year+month%/%mod_val
    month<-max(month%%mod_val,1)
  }
}

# Oblis
dimnames(df)[[2]]<-c("userID","Date","DateString", "Expense", "Amount", "Country", "City", "Provider", "Products", "GCategories", "SCategories", "Entrie_methods")

### Good
## Create an in HDD database
ok <- dbWriteTable(db, expenses_table_name, df, row.names = FALSE, overwrite=TRUE)
stopifnot(ok)

# Verify
df_read<-dbReadTable(db, expenses_table_name);
stopifnot(sum(df_read!=df)==0)
stopifnot(dbDisconnect(db))

# Verify
write.csv(df,row.names=FALSE,file=paste("./data/csv-prototyping/",expenses_table_name,".csv",sep=""))