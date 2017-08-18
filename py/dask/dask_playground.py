# dask playground

# basics ----

from time import sleep

def inc(x):
    sleep(1)
    return x + 1

def add(x, y):
    sleep(1)
    return x + y

inc(10)
add(10, 20)
inc(20)

from dask import delayed

# parallel basics ----

%%time
# just builds the graph
x = delayed(inc)(1)
y = delayed(inc)(2)
z = delayed(add)(x, y)

%%time
# this is the computation part
z.compute()

# pip install graphviz
# brew install graphviz
z.visualize()

# parallelize a for loop

data = [1, 2, 3, 4, 5, 6, 7, 8]

%%time
results = []
for x in data:
    y = inc(x)
    results.append(y)

total = sum(results)

%%time
results = []
for x in data:
    y = delayed(inc)(x)
    results.append(y)

total = delayed(sum)(results) # this is it
total.compute()

total.visualize()

# parallelizing with control flow

def double(x):
    sleep(1)
    return 2 * x

def is_even(x):
    return not x % 2

data = [i for i in range(10)]

%%time
results = []
for x in data:
    if is_even(x):
        y = double(x)
    else:
        y = inc(x)
    results.append(y)

total = sum(results)
print(total)

%%time
results = []
for x in data:
    if is_even(x):
        y = delayed(double)(x)
    else:
        y = delayed(inc)(x)
    results.append(y)

total = delayed(sum)(results)
total.compute()
total.visualize()

# first group by example ----

%run prep_data.py

import os
sorted(os.listdir(os.path.join('data', 'nycflights')))

import pandas as pd
df = pd.read_csv(os.path.join('data', 'nycflights', '1990.csv'))
df.Origin.unique()

df.groupby('Origin').DepDelay.mean()

# dask dataframes ----

import os
import dask
import dask.dataframe as dd

df = dd.read_csv(
    os.path.join('data', 'nycflights', '*.csv'),
    parse_dates = {'Date': [0, 1, 2]},
    dtype = {'TailNum': str, 'CRSElapsedTime': float, 'Cancelled': bool})

df
df.head()

%time df.DepDelay.max().compute()

df.DepDelay.max().visualize()

len(df)
