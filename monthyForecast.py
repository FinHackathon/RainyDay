import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.ar_model import AR
import statsmodels as sm
#from statsmodels.graphics import qqplot

data = pd.read_csv("F:\Hackathon\Edinburgh\monthData.csv")
print data.head();

dateparse = lambda dates: pd.datetime.strptime(dates, "%DD/%MM/%YYYY")
#data = pd.read_csv("F:\Hackathon\Edinburgh\monthData.csv")
data = pd.read_csv("F:\Hackathon\Edinburgh\monthData.csv",  parse_dates='Month', index_col='Month');

#data_series = pd.Series(data['Amount'], index = data_index)
#print(data.index);
data = data['Amount'];

model = AR(data)
result = model.fit(12)

#plt.plot(data, 'b-', label='data')
#plt.plot(range(result.k_ar, len(data)), result.fittedvalues, 'r-')
print result.k_ar
print result.params
#plt.show()
#print (result.predict('2016-01-01', '2016-01-12', dynamic= True))
#model.predict(result.k_ar, 12, dynamic = True).plot()
#data['2016-01-01':'2016-01-12'].plot(style='--')
##########ARMA

### predict future values
fit =[]
from dateutil.relativedelta import relativedelta
import datetime
import numpy
tempDate = datetime.date(2015,12,01)
arrayData = numpy.array(data.values).tolist()

#for t in range(result.k_ar, len(data)):
#    val = 0
#    for i in range(1, result.k_ar-1):
#        val += result.params[i] * arrayData[t - i]
#    val += result.params[0]
#    fit.append(val)
#    arrayData.append(val)
    #model = AR(arrayData)
    #result = model.fit(12)

#plt.plot(arrayData)
#plt.show()

for t in range(result.k_ar, len(data)):
    val = 0
    for i in range(1, result.k_ar-1):
        val += result.params[i] * data[t - i]
    val += result.params[0]
    fit.append(val)
    #model = AR(arrayData)
    #result = model.fit(12)

plt.plot(data, 'b-', label = 'data')
#plt.plot(range(result.k_ar, len(data)), fit, 'r-', label='fit')
plt.plot(range(result.k_ar, len(data)), result.fittedvalues, 'r-')
plt.show()
