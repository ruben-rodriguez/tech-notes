+++
title = "Oracle DB - Freeing up space"
date = 2020-02-05T00:00:00+08:00
description = "Network interface tracing"
tags = ["Oracle", "databases"]
showLicense = false
draft = false
+++

Quick note on how to identify Oracle Datafiles subject to resize and save some spaces.
This is intended for testing machines where there are *usually* limitations in terms of disk space.

<!--more--> 

In order to free up space in our beloved DB server, we might wish to resize some dbf's eating lots of space. 
Let's identify the dbf's we can shrink with the following SQL query:

```sql
SELECT FILE_NAME,
CEIL( (NVL(HWM,1)*8192)/1024/1024 ) SHRINK_TO,
CEIL( BLOCKS*8192/1024/1024) CURRENT_SIZE,
CEIL( BLOCKS*8192/1024/1024) -
CEIL( (NVL(HWM,1)*8192)/1024/1024 ) SAVINGS
FROM DBA_DATA_FILES A,
( SELECT FILE_ID, MAX(BLOCK_ID+BLOCKS-1) HWM
FROM DBA_EXTENTS
GROUP BY FILE_ID ) B
WHERE A.FILE_ID = B.FILE_ID(+);
```

This will return a resultset like the following:

| FILE_NAME                              | SHRINK_TO | CURRENT_SIZE | SAVINGS |
|----------------------------------------|-----------|--------------|---------|
| /oracle/oradata/DB/Datafile_name0.dbf  | 3,390     | 3,622        | 232     |
| /oracle/oradata/DB/Datafile_name01.dfb | 2,180     | 2,180        | 83      |
| /oracle/oradata/DB/Datafile_name02.dbf | 1,136     | 1,136        | 65      |

Once we identify a datafile that is subject to save us some space, let's resize it:

```sql
ALTER DATABASE DATAFILE '/oracle/oradata/DB/Datafile_name0.dbf' RESIZE 3390m;
```

Voila ~ ! We just saved 232m :)

> NOTE: you will probably need DBA/SYSTEM privileges to perform above operations.