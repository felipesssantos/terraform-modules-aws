# Projeto 01 - Arquitetura Web 3-Tier com Alta Disponibilidade na AWS ☁️

## Visão Geral
Este projeto implanta uma infraestrutura de alta disponibilidade na AWS seguindo as práticas do *Well-Architected Framework*. Ele amarra módulos customizados do Terraform para provisionar uma rede segura, balanceamento de carga e escalabilidade automática.

## Blocos de Arquitetura 🧱

A infraestrutura é construída instanciando recursos de 4 módulos nativos deste repositório:

1. **VPC (Virtual Private Cloud):** Cria a rede isolada com Subnets Públicas (para exposição à internet) e Privadas (para blindagem dos servidores).
2. **IAM (Gestão de Identidade):** Elimina completamente a necessidade de chaves SSH vulneráveis (`.pem`), garantindo acesso limpo, auditável e seguro aos servidores através do **AWS Systems Manager (SSM)**.
3. **ALB (Application Load Balancer):** Posicionado nas Subnets Públicas, atua como "porteiro". Ele recebe o tráfego HTTP vindo da internet e distribui uniformemente para os servidores saudáveis.
4. **ASG (Auto Scaling Group):** O motor de trabalho real. Posicionado nas Subnets Privadas, ele gerencia as instâncias EC2. Ele garante a capacidade desejada: se um servidor falhar ou travar, o ASG o destrói e clona um novo idêntico automaticamente.

## Nível de Segurança (Security Posture) 🔐
* **Zero IPs Públicos nos Servidores:** As máquinas EC2 vivem no porão da arquitetura (Private Subnet) e não podem ser achadas aleatoriamente na internet.
* **Firewall Encadeado:** O Security Group das instâncias EC2 bloqueia tudo, exceto o tráfego que comprove vir exclusivamente do Security Group do Load Balancer. Ninguém contorna o porteiro.
* **Zero Trust de Acesso Administrativo:** Para acessar o terminal da máquina operacionalmente, o engenheiro deve usar autenticação e autorização via AWS Console/CLI com o Session Manager. Nenhuma porta 22 (SSH) foi aberta na infraestrutura inteira.

## Como Executar 🚀

Dentro deste diretório (`projeto-01`), execute:

1. Baixe os conectores da AWS e inicialize os submódulos:
   ```bash
   terraform init
   ```
2. Revise o que será criado de forma segura:
   ```bash
   terraform plan
   ```
3. Implante a arquitetura:
   ```bash
   terraform apply
   ```

## Próximos Passos (Futuro do Projeto) 🔮
- **Banco de Dados (RDS / Aurora):** Adicionando a verdadeira camada de dados na arquitetura 3-Tier.
- **Borda Global (CloudFront + WAF + ACM):** Adicionando cache mundial, firewall e certificados SSL na frente do Load Balancer.
