FROM openjdk:17 AS BUILD_IMAGE
RUN apt-get update && apt-get install maven -y
COPY ./ vprofile-project-25/
RUN cd vprofile-project-25 && mvn install

FROM tomcat:9-jdk17
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project-25/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]