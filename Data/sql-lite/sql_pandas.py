__author__ = 'desp'

import sqlite3
import pandas as pd

# Create a SQL connection to our SQLite database
con = sqlite3.connect("C:\Users\desp\Desktop\graphs\RainyDaySQLite.sqlite")
df = pd.read_sql_query("SELECT * from expenses", con)

cur = con.cursor()

# the result of a "cursor.execute" can be iterated over by row
#for row in cur.execute('SELECT * FROM expense_categories;'):
#    print(row)

# verify that result of SQL query is stored in the dataframe
print(df.head())
#Be sure to close the connection.
con.close()
userMatrix = df[['Date', 'City', 'Expense', 'GCategories', 'Amount']];
#userMatrix = df[df.userID == 'user_1'][['Date', 'City', 'Expense', 'GCategories', 'Amount']]
### Mapping data
city_mapping = {'Glasgow' : 1, 'Edinburg' : 2}

category_mapping = {'Rent Per Month' : 1, 'Salaries And Financing' : 2, 'Buy Apartment Price' : 3, 'Utilities (Monthly)' : 4, 'Markets' : 5, 'Restaurants' : 6,
                    'Clothing And Shoes' : 7, 'Sports And Leisure' : 8}
userMatrix = userMatrix.replace({'City' : city_mapping, 'GCategories' : category_mapping})


#### Date time
from datetime import datetime

#Date_Axis = String(userMatrix['Date']);

y = userMatrix['Amount'];
x = userMatrix[['City', 'Expense', 'GCategories']]
category = userMatrix[['GCategories']]
#print category

#### linear fit
#from sklearn import linear_model
#model = linear_model.LinearRegression()
#model.fit(x,y)
#print(model.coef_)

#import matplotlib.pyplot as pyplot
#pyplot.plot(y)
#pyplot.show()

#total_rent = 0;
#for line in (1,userMatrix.__len__()):
#    if(userMatrix['category'][line] == 'Rent Per Month'):
#        total_rent += userMatrix[line]['category']

