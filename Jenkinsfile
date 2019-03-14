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
				sh 'find / -type d -name 'mbed-os-example-ble'
				// /home/jenkins/workspace/pipeline-play
            }
        } // stage for debugging what is being passed in and environment
		stage('build') {
			steps {
				sh 'ls -l'
			}
		}
    }
}



