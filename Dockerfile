FROM maven:3.6.2-jdk-13 as builder

COPY . /usr/src/

WORKDIR /usr/src/
RUN mvn -B package

FROM tomcat:8.5-jdk15-openjdk-slim

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

COPY --from=builder /usr/src/target/ROOT.war webapps/
