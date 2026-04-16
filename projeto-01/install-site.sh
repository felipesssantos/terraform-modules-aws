#!/bin/bash
# Atualiza pacotes e instala o Servidor Web Apache
sudo yum update -y
sudo yum install -y httpd

# Garante que o serviço vai ligar automaticamente sempre que a máquina bootar
sudo systemctl enable httpd
sudo systemctl start httpd

# Pega o IP interno da máquina para saber qual servidor do ASG atendeu o Load Balancer
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
IP_LOCAL=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4)

# Cria a página inicial do seu site em HTML 
echo "<h1>🚀 Aplicação rodando no Projeto 01!</h1> <p><b>Eu sou o servidor escondido de IP Privado: $IP_LOCAL </b></p>" | sudo tee /var/www/html/index.html
