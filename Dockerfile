FROM tomcat
# Take the war and copy to webapps of tomcat
COPY target/newapp.war /usr/local/tomcat/webapps/newapp.war
