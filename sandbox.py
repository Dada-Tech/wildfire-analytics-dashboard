import pandas as pd

url = "https://open.alberta.ca/dataset/a221e7a0-4f46-4be7-9c5a-e29de9a3447e/resource/80480824-0c50-456c-9723-f9d4fc136141/download/fp-historical-wildfire-data-2006-2021.xlsx"
df = pd.read_excel(url)
print(df.head()['fire_start_date'])