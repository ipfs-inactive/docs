pipeline {
  agent any
  stages {
    stage('Build') {
      steps { node(label: 'linux') {
        ansiColor('xterm') {
          sh 'docker run -i -v `pwd`:/site ipfs/ci-websites echo "Hello, world!"'
        }
      }}
    }
  }
}
