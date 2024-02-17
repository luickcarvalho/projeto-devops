
## Descrição da Aplicação:
O projeto Comment consiste no desenvolvimento de uma API desenvolvida em Python que tem a responsabilidade de registrar os comentários feitos por usuários. 

### Arquitetura
Elastic Load Balance, ECS, RDS Aurora, Secret Manager, Git Hub, Git Action e Cloudwatch.

### IAC
Terraform e Ansible.

### CI/CD
Deploy Aplicação Python: Para visualizar o código python da aplicação Comment, o mesmo se encontra na branch "app", se ocorrer alguma alteração no código, automaticamente o git actions irá realizar o deploy da aplicação.
Deploy Terraform:
  Plan: Realizar alteração a partir da brach "Terraform" e no path do Terraform que irá ser criada um PR para verificar o output do plan.
  Apply: Realizar a criação de um tag no formato v1.0.0
  Destroy: Acessar a aba "Actions", selecionar o Workflow "Terraform Destroy" e dentro dele existe a trigger "Run Workflow".

### Diagrama da Aplicação:
  <img src="/img/comments.jpg">

### Teste Aplicação:
  <img src="/img/Screenshot_4.png">
  <img src="/img/Screenshot_3.png">
  <img src="/img/Screenshot_2.png">

### Dashboard Monitoramento:
  <img src="/img/Screenshot_5.png">
