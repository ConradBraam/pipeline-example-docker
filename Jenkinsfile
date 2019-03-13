pipeline {
    agent { node { label 'ubuntu' } // w the docker containers are hosted  
           docker { image 'mine' } 
    }
    stages {
        stage('build') {
            steps {
                sh 'mbed --version'
            }
        }
    }
}



