import pandas as pd
from collections import defaultdict
import os


path = "reagan_data/around_circumference"; # file path
dd = defaultdict(list);

files = os.listdir(f"./{path}/") # lists all files
csv_files = list(filter(lambda f: f.endswith('.csv'), files)) # grabs csv files

for f in csv_files:
	tag = f.rsplit("-")[0];
	dd[tag].append(f);

int i = 0
for tag in dd:
	# uneven lengths?
	accDF = pd.read_csv(f"./{path}/{dd[tag][0]}").dropna(subset=["timestamp"]).rename(columns={"x": "Acc x", "y": "Acc y", "z": "Acc z"});
	gyroDF = pd.read_csv(f"./{path}/{dd[tag][1]}").dropna(subset=["timestamp"]).rename(columns={"x": "Gyro x", "y": "Gyro y", "z": "Gyro z"});
	df = pd.concat(accDF,gyroDF);
	#df.to_csv(f"{path}/mergedData_{i++}")

import pdb; pdb.set_trace(); # debugging