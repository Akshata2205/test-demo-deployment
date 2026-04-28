// pipeline {
//     agent any
//
//     tools {
//         maven 'Maven3'
//         docker 'Docker'
//     }
//
// //     environment {
// //             DOCKER_HOST = 'unix:///var/run/docker.sock'
// //         }
// environment {
//     DOCKER_HOST = 'tcp://docker:2376'
// }
//
//     environment {
//         AWS_REGION = "ap-south-1"
//     }
//
//     stages {
//
//         stage('Checkout') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Akshata2205/test-demo-deployment.git'
//             }
//         }
//
//         stage('Build Spring Boot') {
//             steps {
//                 sh 'mvn clean package -DskipTests'
//             }
//         }
//
//         stage('Test Docker') {
//             steps {
//                 sh 'docker version'
//             }
//         }
//
//         stage('Build Docker Image') {
//             steps {
// //                 sh 'docker build -t springboot-app .'
//                  sh 'docker build -t abhosle1298/demo-spring-app:0.0.1.RELEASE .'
//             }
//         }
//
//         stage('Terraform Init') {
//             steps {
//                 dir('terraform') {
//                     sh 'terraform init'
//                 }
//             }
//         }
//
//         stage('Terraform Apply') {
//             steps {
//                 dir('terraform') {
//                     sh 'terraform apply -auto-approve'
//                 }
//             }
//         }
//
// //         stage('Get EC2 IP') {
// //             steps {
// //                 script {
// //                     env.EC2_IP = sh(
// //                         script: "cd terraform && terraform output -raw ec2_ip",
// //                         returnStdout: true
// //                     ).trim()
// //                 }
// //             }
// //         }
//
// //         stage('Update Ansible Inventory') {
// //             steps {
// //                 sh """
// //                 sed -i 's/EC2_PUBLIC_IP/${EC2_IP}/g' ansible/inventory.ini
// //                 """
// //             }
// //         }
//
//         stage('Run Ansible') {
//             steps {
//                 sh "ansible-playbook -i ansible/ansible_hosts.yml ansible/demo_ansible_playbook.yml"
//             }
//         }
//     }
// }



pipeline {
    agent any

    tools {
            maven 'Maven3'
            docker 'Docker'
        }

    environment {
        ANSIBLE_HOST_KEY_CHECKING = "False"
    }

    stages {

    stage('Checkout') {
                steps {
                    git branch: 'main', url: 'https://github.com/Akshata2205/test-demo-deployment.git'
                }
            }

            stage('Build Spring Boot') {
                steps {
                    sh 'mvn clean package'
//                     -DskipTests'
                }
            }

            stage('Test Docker') {
                steps {
                    sh 'docker version'
                }
            }

            stage('Build Docker Image') {
                steps {
    //                 sh 'docker build -t springboot-app .'
                     sh 'docker build -t abhosle1298/demo:0.0.1.RELEASE .'
                }
            }

        stage('Terraform Init') {
            steps {
                sh '''
                    cd terraform
                    terraform init
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                    cd terraform
                    terraform apply -auto-approve
                '''
            }
        }

        stage('Get EC2 IP') {
            steps {
                script {
                    env.EC2_IP = sh(
                        script: "cd terraform && terraform output -raw ec2_public_ip",
                        returnStdout: true
                    ).trim()

                    echo "EC2 IP: ${EC2_IP}"
                }
            }
        }

        stage('Generate Ansible Inventory') {
            steps {
                sh '''
                    echo "[web]" > inventory.ini
                    echo "${EC2_IP} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/key.pem" >> inventory.ini
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                sh '''
                    ansible-playbook -i inventory.ini ansible/deploy.yml
                '''
            }
        }
    }
}