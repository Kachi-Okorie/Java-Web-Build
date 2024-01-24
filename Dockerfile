#we are using jdk 11
FROM openjdk:11 as base 
#set the working directory to app
WORKDIR /app
COPY . . 
#executable permission to prevent denial of access
RUN chmod +x gradlew
#building our project
RUN ./gradlew build 

#we are deploying war file into tomcat file
FROM tomcat:9
#going to webapp directory
WORKDIR webapps
COPY --from=base /app/build/libs/myapp.war .
#chnage app.war to ROOT.war
RUN rm -rf ROOT && mv myapp.war ROOT.war 
EXPOSE 8080
CMD ["catalina.sh", "run"]
