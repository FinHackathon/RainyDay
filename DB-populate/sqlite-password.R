# Status: Working
###
# Libs
###
source(paste(db_populate_path,"/database_require.R",sep=""))
#FAKE data generation
Nuser <- 50 # number of users
userID<- paste("user_",1:Nuser,sep="")
mysample<-function(user){pass<- paste(sample(c(LETTERS,letters,0:9),sample(8:12)),collapse="");return(c(user,pass))}

df<-data.frame(matrix(ncol=2,nrow=Nuser))
for(line in 1:Nuser){df[line,]<-mysample(userID[line]);}

dimnames(df)[[2]]<-c("userID", "Passwrd")

### Good
## Create an in HDD database
ok <- dbWriteTable(db, user_pass_table_name, df, row.names = FALSE, overwrite=TRUE)
stopifnot(ok)

# Verify
df_read<-dbReadTable(db, user_pass_table_name);
stopifnot(sum(df_read!=df)==0)
stopifnot(dbDisconnect(db))

# Verify
write.csv(df,row.names=FALSE,file=paste("./data/csv-prototyping/",user_pass_table_name,".csv",sep=""))