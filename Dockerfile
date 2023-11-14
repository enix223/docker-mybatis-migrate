ARG IMG_VERSION=17.0.8.1_1-jre-jammy
FROM eclipse-temurin:${IMG_VERSION}
ARG MIGRATION_VERSION

RUN apt-get update
RUN apt-get install -y curl zip unzip

RUN mkdir -p /mybatis
WORKDIR /mybatis

# install migrate
RUN curl -OL "https://github.com/mybatis/migrations/releases/download/mybatis-migrations-${MIGRATION_VERSION}/mybatis-migrations-${MIGRATION_VERSION}-bundle.zip"
RUN unzip mybatis-migrations-${MIGRATION_VERSION}-bundle.zip && mv mybatis-migrations-${MIGRATION_VERSION} migrations && rm mybatis-migrations-${MIGRATION_VERSION}-bundle.zip

# get jdbc driver
RUN mkdir -p /mybatis/drivers
WORKDIR /mybatis/drivers
RUN curl -OL "https://repo1.maven.org/maven2/org/postgresql/postgresql/42.6.0/postgresql-42.6.0.jar"
RUN curl -OL "https://repo1.maven.org/maven2/org/xerial/sqlite-jdbc/3.43.2.2/sqlite-jdbc-3.43.2.2.jar"
RUN curl -OL "https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.2.0/mysql-connector-j-8.2.0.jar"
RUN curl -OL "https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc10/19.21.0.0/ojdbc10-19.21.0.0.jar"
RUN curl -OL "https://repo1.maven.org/maven2/com/microsoft/sqlserver/mssql-jdbc/12.4.2.jre11/mssql-jdbc-12.4.2.jre11.jar"

VOLUME [ "/mybatis/workspace" ]
WORKDIR /mybatis/workspace
ENTRYPOINT [ "/mybatis/migrations/bin/migrate" ]
CMD [ "up" ]
