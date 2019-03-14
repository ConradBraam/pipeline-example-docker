pipeline {
    agent {  
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



