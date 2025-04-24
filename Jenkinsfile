pipeline {
    agent any
    tools {
        jdk "jdk"
        maven "maven"
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    
    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/IlhamBelhaj/BlogAPP.git'
            }
        }
        stage('Compile') {
            steps {
                sh "mvn compile"
            }
        }
        stage('Trivy FS') {
            steps {
                sh "trivy fs . --format table -o fs.html"
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQubeServer') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=BlogApp -Dsonar.projectKey=BlogApp \
                          -Dsonar.java.binaries=target'''
                }
            }
        }
        stage('Build') {
            steps {
                sh "mvn package"
            }
        }
   stage('Publish Artifacts') {
    steps {
        withMaven(
            maven: 'maven',                        
            jdk: 'jdk',                            
            mavenSettingsConfig: 'maven-settings', 
            traceability: true
        ) {
            sh "mvn deploy"
        }
    }
}

        stage('Docker Build & Tag') {
            steps {
                script{
                withDockerRegistry(credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/') {
                sh "docker build -t ilhambelhaj/blogging-app ."
                }
                }
            }
        }
        stage('Trivy Image Scan') {
            steps {
                sh "trivy image --format table -o image.html ilhambelhaj/blogging-app:latest"
            }
        }
        stage('Docker Push Image') {
            steps {
                script{
                withDockerRegistry(credentialsId: 'docker-hub', url: 'https://index.docker.io/v1/') {
                    sh "docker push ilhambelhaj/blogging-app"
                }
                }
            }
        }
      
        stage('K8s Deploy') {
            steps {
               withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'ilham-aks-cluster', contextName: '', credentialsId: 'kubernetes', namespace: 'webapps', serverUrl: 'https://ilham-aks-cluster-dns-0ee0xioy.hcp.westeurope.azmk8s.io:443']]) {
                    sh "kubectl apply -f k8s/deployment.yaml"
                    sh "kubectl apply -f k8s/service.yaml"
                    sleep 20
                }
            }
        }
        stage('Verify Deployment') {
            steps {
               withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: 'ilham-aks-cluster', contextName: '', credentialsId: 'kubernetes', namespace: 'webapps', serverUrl: 'https://ilham-aks-cluster-dns-0ee0xioy.hcp.westeurope.azmk8s.io:443']]) {
                    sh "kubectl get pods"
                    sh "kubectl get service"
                }
            }
        } 
        
    }  
}


