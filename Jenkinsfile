node{
    def buildNumber = BUILD_NUMBER 
     stage("Git code"){
        git url: 'https://github.com/Vignesh2064/my-app1.git', branch: 'master'
     }
     stage("Maven build package"){
         def mavenHome= tool name: "Maven",type: "maven"
         sh "${mavenHome}/bin/mvn clean package"
         sh 'mv target/myweb*.war target/newapp.war'
     }
     stage('SonarQube Analysis') {
         def mvnHome = tool name: 'Maven', type: 'maven'
         withSonarQubeEnv(credentialsId: 'sonar') {
         sh "mvn sonar:sonar"
         } 
     }
     stage("Build Docker Image"){
         sh "docker build -t vignesh2064/newapp:${buildNumber} ."
         } 
    stage("Docker login and push"){
        withCredentials([string(credentialsId: 'docker-pass', variable: 'docker')]) {
        sh "docker login -u vignesh2064 -p ${docker}"
        }
    }
    stage("Docker push"){
        sh "docker push vignesh2064/newapp:${buildNumber}"
    }
     stage(" Deploy application in docker container")
         {
         sh "docker rm -f new || true "
         sh "docker run -itd --name new -p 8090:8080 vignesh2064/newapp:${buildNumber}"
         }
    
}
