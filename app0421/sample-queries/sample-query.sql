-- Creating Athena table 'customer' to query customer data stored in AWS S3. This data is partitioned by created_at for better query performance --

CREATE EXTERNAL TABLE IF NOT EXISTS customer (
    customer_id STRING COMMENT 'ID of the customer',
    first_name STRING COMMENT 'First name of the customer',
    last_name STRING COMMENT 'Last name of the customer',
    email STRING COMMENT 'Email ID of the customer',
    phone_number STRING COMMENT 'Contact number of the customer',
    address STRING COMMENT 'Registered address of the customer',
    city STRING COMMENT 'City of the customer',
    state STRING COMMENT 'State of the customer',
    zipcode STRING COMMENT 'Zip Code of the customer',
    country STRING COMMENT 'Country of the customer',
    created_at TIMESTAMP COMMENT 'Created timestamp'
) PARTITIONED BY (
    year_created INT,
    month_created INT,
    day_created INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    'separatorChar' = ',',
    'quoteChar' = '"',
    'escapeChar' = '\\'
)
LOCATION 's3://your-s3-bucket/path/to/customer/'
TBLPROPERTIES (
    'classification'='csv',
    'columnsOrdered'='true',
    'compressionType'='none',
    'typeOfData'='file'
);