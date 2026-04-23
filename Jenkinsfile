pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    environment {
        AWS_REGION = "ap-south-1"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Akshata2205/test-demo-deployment.git'
            }
        }

        stage('Build Spring Boot') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
//                 sh 'docker build -t springboot-app .'
                 sh 'docker build -t abhosle1298/demo-spring-app:0.0.1.RELEASE .'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }

//         stage('Get EC2 IP') {
//             steps {
//                 script {
//                     env.EC2_IP = sh(
//                         script: "cd terraform && terraform output -raw ec2_ip",
//                         returnStdout: true
//                     ).trim()
//                 }
//             }
//         }

//         stage('Update Ansible Inventory') {
//             steps {
//                 sh """
//                 sed -i 's/EC2_PUBLIC_IP/${EC2_IP}/g' ansible/inventory.ini
//                 """
//             }
//         }

        stage('Run Ansible') {
            steps {
                sh "ansible-playbook -i ansible/ansible_hosts.yml ansible/demo_ansible_playbook.yml"
            }
        }
    }
}