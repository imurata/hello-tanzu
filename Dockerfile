FROM maven:3-amazoncorretto-11 as builder

COPY . /usr/src/

WORKDIR /usr/src/
RUN mvn -B package

FROM tomcat:latest

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

COPY --from=builder /usr/src/target/ROOT.war webapps/
