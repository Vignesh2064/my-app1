node{
    def buildNumber = BUILD_NUMBER
    stage("Git clone"){
        git url: 'https://github.com/Vignesh2064/my-app1.git', branch: 'master'
    }
    
    stage("Maven build package"){
        def mavenHome= tool name: "Maven",type: "maven"
        sh "${mavenHome}/bin/mvn clean package"
        sh 'mv target/myweb*.war target/newapp.war'
    }
    stage("Build Docker Image"){
       sh "docker build -t vignesh2064/newapp:${buildNumber} ."  
    }
    stage("Docker login and push"){
        withCredentials([string(credentialsId: 'Dockerpwd', variable: 'Dockerpwd')]) {
            sh "docker login -u vignesh2064 -p ${Dockerpwd}" 
            
        }
    stage("Docker push"){
        sh "docker push vignesh2064/newapp:${buildNumber}"
    }
    stage(" Deploy application in docker container")
    sshagent(['17f945c1-b86e-404b-a5b6-fdda1fa29104']) {
     sh "ssh -o StrictHostkeyChecking=no ubuntu@172.31.90.13 docker rm -f new || true "
     sh "ssh -o StrictHostkeyChecking=no ubuntu@172.31.90.13 docker run -itd --name new -p 8080:8080 vignesh2064/newapp:${buildNumber}"
   }
}
}

