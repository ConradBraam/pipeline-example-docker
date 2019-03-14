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
				sh 'ls /work'
				// /home/jenkins/workspace/pipeline-play
            }
        } // stage for debugging what is being passed in and environment
		stage('build') {
			steps {
				dir("/work") {
				    sh 'pwd'
				    sh 'ls'
				}
			}
		}
    }
}



