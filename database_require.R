# Database
require(RSQLite)

###
# Parameters Setup
###
# countries file # ToDo should replace with read from postgress in future
DbFile<-"./RainyDaySQLite.db"
db <- dbConnect(SQLite(), dbname = DbFile)
expense_categories_table_name<-"expense_categories"