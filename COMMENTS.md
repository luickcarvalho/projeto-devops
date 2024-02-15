**1** - Primeiro desafio foi realizar o teste local da aplicação python usando docker. Notei que aplicação não ficava com status running, o container estava sendo iniciado e desligava, fiz uma análise no código e com ajuda do Chat GPT identifiquei que faltava o if com app.run".

**2** - Depois que o container ficou estável realizei teste do method POST o json estava retornando NoneType, adicionei a verificação para garantir que request.get_json() não retorne None antes de tentar acessar as chaves, tanto no method POST e GET.

**3** - Fiz a criação de uma rota Healthcheck e pedi uma ajuda para chatgpt, para que as rotas POST salvar os campos preenchidos em um banco de dados MySQL e rota GET faça um select retornando as informações, sendo assim a aplicação ficou funcional.

**4** - Segui com o desenho da infraestrutura que será responsável por disponibilizar e suportar a aplicação, segui três pilares segurança, disponibilidade e escalabilidade, por este motivo fiz a escolha de utilizar os seguintes recursos da AWS ALB, ECS, RDS Aurora e Secret Manager.

**5** - Após provisionar todos os recursos na AWS, realize a criação do pipeline CI/CD utilizando Git Action na branch "APP" é onde ficou armazenado o código da aplicação e Dockerfile, se ocorrer qualquer tipo de alteração nos codigos deste branch, o git action irá realizar o registry da imagem no ecr e atualizar a imagem dos containers que estarão running. Todas as variables e secrets estão configuradas no git hub.

## Pontos da aplicação para melhorar:
    - AWS Cloudwatch: Monitoramento para enviar alertas via e-mail.
    - AWS WAF: Mitigar futuros ataques cibernéticos.
    - Criar um front-end para melhor interação dos usuários.
