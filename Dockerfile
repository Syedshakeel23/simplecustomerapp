FROM tomcat:9.0-jdk17

# Clean default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Download your WAR file from Nexus
RUN curl -fL -o /usr/local/tomcat/webapps/ROOT.war \
  http://34.203.202.65:8081/repository/Simplecustomerapp/com/javatpoint/SimpleCustomerApp/1.0.0-SNAPSHOT/SimpleCustomerApp-1.0.0-20250721.185847-1.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
