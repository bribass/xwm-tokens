pipeline {
  agent {
    docker {
      image 'bbassett/openscad'
    }
  }
  stages {
    stage('Git Submodules') {
      steps {
        sh 'git submodule update --init'
      }
    }
    stage('Build') {
      steps {
        sh 'rm -rf out && mkdir out && make DESTDIR=out'
        archiveArtifacts 'out/*.stl'
      }
    }
  }
}
