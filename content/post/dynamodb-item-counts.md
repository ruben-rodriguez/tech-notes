+++
title = "DynamoDB item count"
date = 2021-03-05T00:00:00+08:00
description = "Counting items of a DynamoDB table"
tags = ["AWS", "aws-cli", "databases"]
showLicense = false
draft = false
+++

So, let's say you have a fancy new table where you are storing items for whatever, that's cool! Now, imagine one day, somebody asks what's the count for a certain column value. No problem, let's leverage AWS CLI to retrieve such metrics (yeah, querying DynamoDB on AWS Web Console sucks)

<!--more--> 

Okay, let's say we have a table called `fancy_table` that has a column called `animal` containing several animal types (cat, dog, lion, etc). Now, you wish to count how many items with that column value set to `dog`. We would build the following command:

```sh
aws dynamodb scan --table-name fancy_table \
 --select "COUNT" --filter-expression "animal = :animal_type" \
 --expression-attribute-values '{":animal_type":{"S":"dog"}}'
```
which would return somehting like

```json
{
    "Count": 2677,
    "ScannedCount": 8919,
    "ConsumedCapacity": null
}
```

where `Count` is the number of items in the DynamoDB meeting the filter and `ScannedCount` the total number of items stored in the table.

<b>Careful thouhg!</b> If your table contains many items and you have a low read capacity setting in your table, you might get the following exception: 

> An error occurred (ProvisionedThroughputExceededException) when calling the Scan operation (reached max retries: 9): The level of configured provisioned throughput for the table was exceeded. Consider increasing your provisioning level with the UpdateTable API.

You can find more details on querying DynamoDB on the AWS official docs: [Working with Queries in DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html)