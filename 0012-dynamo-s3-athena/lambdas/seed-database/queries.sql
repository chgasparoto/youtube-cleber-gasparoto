-- create table sql
CREATE EXTERNAL TABLE IF NOT EXISTS user_comments_table_2022_11_06_001 (
Item struct <
    pk:struct<S:string>
    sk:struct<S:string>
    active:struct<BOOL:boolean>
    createdAt:struct<N:string>
    email:struct<S:string>
    fullname:struct<S:string>
    username:struct<S:string>
    comment:struct<S:string>
>
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://968339500772-dynamodb-s3-athena/AWSDynamoDB/01667735083131-0dfc8cf2/data/'
TBLPROPERTIES ('has_encrypted_data'='true');

-- filter by email and active field
SELECT Item.pk.S as id
    Item.email.S as email
    from_unixtime(cast(Item.createdAt.N as bigint) / 1000)
    Item.active.BOOL as active
FROM user_comments_table_2022_11_06_001
WHERE Item.email.S LIKE '%.com'
    AND Item.active.BOOL = true;