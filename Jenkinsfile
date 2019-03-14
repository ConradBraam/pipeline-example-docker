pipeline {
    agent {  
        docker { 
		    image 'mine' 
		    label 'dockerhost'
		} 
    }
    stages {
        stage('sanity') {
            steps {
                sh 'mbed --version'
				sh 'pwd'
				sh 'printenv'
            }
        } // stage for debugging what is being passed in and environment
		stage('build') {
			steps {
				sh 'ls -l'
			}
		}
    }
}



