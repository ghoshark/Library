pipeline {
     agent any
      options {
           ansiColor('xterm')
         }
     stages {
         
           stage("Git Checkout") {
               steps {
                   git url: 'https://github.com/ghoshark/Library.git'
               }
         }
           stage("Gradle Clean") {
               steps {
                   sh "gradle clean"
               } 
          }
           stage("Code Compile") {
               steps {
                   sh "gradle compileJava"
               }
          }
          stage("Run Unit Tests") {
               steps {
                    sh "gradle test"
               }
          }
           stage("Jacoco Code Coverage") {
               steps {
                    sh "gradle jacocoTestReport"
               
               publishHTML (target: [
               reportDir: 'build/reports/jacoco/test/html',
               reportFiles: 'index.html',
               reportName: "JaCoCo Report"
               ])
                    sh "gradle jacocoTestCoverageVerification"
               }
          }
          
            stage('Sonarqube Analysis') {
                environment {
                    scannerHome = tool 'SonarQubeScanner'
                }
                steps {
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner -Dproject.settings=/home/sesa475934/projects/Library/sonar-project.properties"
                    }
                    timeout(time: 10, unit: 'MINUTES') {
                        waitForQualityGate abortPipeline: true
                    }
                }
            }       
                      
           stage("Build Project") {
               steps {
                    sh "gradle build"
               }
          }  
             stage("Docker Build Image") {
               steps {
                   
                    sh "docker build -t arghosh/onlinelibrary ."
               }
          }    
             stage("Push to Docker Hub") {
               steps {
                    sh "docker login --username arghosh --password February2019!"
                    sh "docker push arghosh/onlinelibrary"
               }
          }   
             stage("Deploy to Dev") {
               steps {
                    echo "Dev deployment"
                   // sh "docker container run arghosh/onlinelibrary"
               }
          }  
             stage("Deploy to QA") {
               steps {
                    echo "QA deployment"
                    sh "ansible-playbook /home/sesa475934/projects/Library/ansible/deploy.yml --extra-vars 'host_name=qa_server remote_username=sesa475934'"
               }
          }  
             stage("Deploy to Production") {
               steps {
                    input 'Continue to Production deployment?'
                    echo "Prod deployment"
                    sh "ansible-playbook /home/sesa475934/projects/Library/ansible/deploy.yml --extra-vars 'host_name=qa_server remote_username=sesa475934'"
               }
          }  
          
     }
     
}
