#FROM maven:3.9.9-amazoncorretto-17 AS build
#
#COPY src /usr/app/src
#COPY pom.xml /usr/app
#
#WORKDIR /usr/app
#RUN mvn -f /usr/app/pom.xml clean install -DskipTests -U
#FROM openjdk:17
#COPY --from=build /usr/app/target/Shopping_Cart-0.0.1-SNAPSHOT.jar .
#EXPOSE 8090
#ENTRYPOINT ["nohup", "java","-jar","Shopping_Cart-0.0.1-SNAPSHOT.jar", "&"]

FROM maven:3.9.9-amazoncorretto-17 AS build

COPY src /usr/app/src
COPY pom.xml /usr/app

WORKDIR /usr/app
RUN mvn -f /usr/app/pom.xml clean package -DskipTests -U
#FROM openjdk:17
FROM tomcat:10.1.19-jdk17
WORKDIR $CATALINA_HOME/

COPY --from=build /usr/app/target/shopping.war $CATALINA_HOME/webapps.dist/
COPY ./config/web.xml $CATALINA_HOME/webapps.dist/manager/WEB-INF
COPY ./config/tomcat-users.xml $CATALINA_HOME/conf
COPY ./config/server.xml $CATALINA_HOME/conf
RUN cp -r $CATALINA_HOME/webapps.dist/* $CATALINA_HOME/webapps

EXPOSE 8080
#ENTRYPOINT ["nohup", "java","-jar","Shopping_Cart-0.0.1-SNAPSHOT.jar", "&"]
ENTRYPOINT ["catalina.sh", "run"]