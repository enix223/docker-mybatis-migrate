# mybatis-migate

## Intro

Image to run mybatis migrate command, typically used in k8s init container to sync db version.

## How to use

```
docker run -it --rm --network SAME-AS-YOUR-DB-NETWORK -v MIGRATE_SCRIPT_DIR:/mybatis/workspace enix223/mybatis-migrate up --env=production
```

## How it works

Some famous db drivers are downloaded in `/mybatis/drivers`, so you can use it out of the box, driver including:
* postgresql-42.6.0.jar
* sqlite-jdbc-3.43.2.2.jar
* mysql-connector-j-8.2.0.jar
* ojdbc10-19.21.0.0.jar
* mssql-jdbc-12.4.2.jre11.jar

So you can refer the driver above you need in your migration properties file.

Suppose you are running migration against another container `mysql8` for database `test`, you can set `production.properties` file like this:

```
# specify your db host and port
url=jdbc:mysql://mysql8:3306/test

# driver path
driver_path=driver_path=/mybatis/drivers/
```

## How to organize

* `/mybatis/workspace` The migration script dir
* `/mybatis/migrations` mybatis migrate executable dir
* `/mybatis/drivers` Pre downloaded db drivers dir