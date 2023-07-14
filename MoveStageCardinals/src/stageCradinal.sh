#!/bin/bash

# Set file and directory paths
cardinal_cost_file="path/to/cardinal_cost_file.csv"
source_directory="path/to/source_directory"

# Set database connection details
central_db_host="localhost"
central_db_user="root"
central_db_password="priya"
central_db_name="EPRN_Central "

store_db_host="localhost"
store_db_user="root"
store_db_password="priya"
store_db_name="store_DB"

# Move Cardinal cost file to source directory
echo "Moving Cardinal cost file to source directory..."
mv "$cardinal_cost_file" "$source_directory"

# Load product cost file into the EPRN Central database
echo "Loading product cost file into the EPRN Central database..."
mysql -h $central_db_host -u $central_db_user -p$central_db_password $central_db_name << EOF
LOAD DATA INFILE '$source_directory/cardinal_cost_file.csv'
INTO TABLE Product_Cardinal
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
IGNORE 1 LINES;
EOF

# Push cost changes to the store database
echo "Pushing cost changes to the store database..."
mysql -h $store_db_host -u $store_db_user -p$store_db_password $store_db_name << EOF
UPDATE Product_Store AS sp
JOIN Product_Cardinal AS pc ON sp.Product_ID = pc.Product_ID
SET sp.Price = pc.Price;
EOF

echo "Cost changes pushed to the store database."
