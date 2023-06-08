# PontuaAi Mobile


## Introdução
O documento proposto oferece soluções para maior alcance e fidelização de clientes para o comércio, através de um aplicativo de pontos. A ideia central é disponibilizar ao cliente recompensas em pontos pela compra no comércio, estes pontos que podem ser acumulados e trocados por prêmios cadastrados pelo próprio comércio. O administrador receberá um acesso com permissão de adicionar outros administradores, cadastrar produtos, editá-los, pontuar clientes e validar os vouchers recuperados pelo cliente.

[Link do Propótipo](https://www.figma.com/file/E3S0avEeAedBKdnhS5Kdi9/Projeto-Final-Engenharia-de-Software?type=design&node-id=1-32&t=QMtMZWTonJQ6hJmm-0)


## Requisitos Funcionais 

**[RF001] – Criação de contas**

 

O aplicativo deve permitir que o cliente cadastre sua conta dentro do sistema. Todos os campos serão obrigatórios, sendo eles: 

- Nome; 

- E-mail; 

- CPF; 

- Senha. 

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

Os campos CPF e E-mail devem ser únicos de cada usuário. 

 

**[RF002] – Entrar na conta** 

 

O aplicativo deve permitir que os usuários entrem na sua conta, preenchendo os campos obrigatórios: 

 

- E-mail ou CPF; 

- Senha. 

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

 

**[RF003] – Alterar dados** 

 

O aplicativo deve permitir que o cliente altere suas informações pessoais: 

- Nome; 

- E-mail; 

  - Deve-se confirmar o novo e-mail informado, de modo a comprovar que este é de domínio do usuário. 

- Senha 

Deve-se confirmar que o usuário tem ciência da senha atual.  

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

O campo CPF não é editável. 

 

 

 

**[RF004] – Recuperar senha** 

 

O aplicativo deve permitir que o cliente consiga recuperar sua senha, através do e-mail cadastrado.  

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

 

**[RF005] – Listagem de Prêmios** 

 

O aplicativo deve listar os prêmios disponíveis, com as seguintes informações: 

- Nome; 

- Pontos necessários; 

- Imagem. 

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

**[RF006] – Descrição do Prêmio** 

 

O aplicativo deve possuir uma descrição detalhada do prêmio, apresentando as seguintes informações: 

- Imagem; 

- Nome; 

- Pontos necessários; 

- Descrição detalhada; 

- Opção de resgatar o prêmio. 

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

 

**[RF007] – Adicionar aos Favoritos** 

 

O aplicativo deve permitir que o cliente adicione um prêmio à lista de favoritos. 

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

**[RF008] – Remover dos Favoritos** 

 

O aplicativo deve permitir que o cliente remova um prêmio da lista de favoritos. 

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

**[RF009] – Resgatar Prêmio** 

 

O aplicativo deve permitir que o cliente resgate o prêmio, fazendo a troca de seus pontos por um código identificador único desta troca. 

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

**[RF010] – Visualização dos Resgates** 

 

O aplicativo deve permitir que o cliente visualize sua lista de prêmios resgatados. 

 

Prioridade: **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

**[RF011] – Filtragem dos Prêmios Resgatados** 

 

O aplicativo deve permitir que o cliente visualize separadamente os prêmios disponíveis dos prêmios já utilizados. 

 

Prioridade: ☐ Essencial   **☒ Importante**   ☐ Desejável 

 
 

 
**[RF012] – Cadastro de atendentes** 

 

O aplicativo deve permitir que o usuário administrador cadastre novos atendentes, com os seguintes campos obrigatórios:  

- Nome; 

- E-mail; 

- CPF; 

- Senha. 

 

Prioridade:  **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

O primeiro acesso administrador será disponibilizado manualmente. A partir dele, será possível cadastrar novos administradores. 

 

 

 
**[RF013] – Cadastro de Prêmios** 

 

O aplicativo deve permitir que um usuário administrador cadastre novos prêmios, com os seguintes campos obrigatórios:  

- Imagem; 

- Nome; 

- Pontos Necessários; 

- Descrição detalhada; 

- Status; 

Não visível ao cliente. Serve somente de controle para exibir ou não para o cliente. 

 

Prioridade:  **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 
**[RF014] – Edição de Prêmios** 

 

O aplicativo deve permitir que um usuário administrador edite produtos já cadastrados. Os campos editáveis são: 

- Imagem; 

- Nome; 

- Pontos necessários; 

- Descrição detalhada; 

- Status. 

 

Prioridade:  **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

 

**[RF015] – Remoção de Prêmios** 

 

O aplicativo deve permitir que um usuário administrador delete prêmios. 

 

Prioridade:  **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

 

**[RF016] – Validação de Códigos** 

 

O aplicativo deve permitir que um usuário administrador valide o código identificador apresentado pelo cliente. A validação deve indisponibilizar o código de ser utilizado novamente. 

 

Prioridade:  **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

 

**[RF017] – Atribuição de Pontos** 

 

O aplicativo deve permitir que um usuário administrador pesquise pelo CPF do cliente e digite o valor da compra realizada. Deve-se atribuir aos clientes seus pontos a partir da regra de pontuação. 

 

Prioridade:  **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

**[RF018] – Configuração da Regra de Pontuação** 

 

O aplicativo deve permitir que o usuário administrador configure a regra de pontuação, com os seguintes campos: 

 

Valor em reais; 

Quantidade de pontos gerados. 
 

Prioridade:  **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

**[RF019] - Variação da Regra de Pontuação** 

 

O aplicativo deve permitir que o usuário administrador configure pontos que variam dentro limitações de valor.  
 

Prioridade:  ☐ Essencial   ☐ Importante   **☒ Desejável** 

 

 

**[RF020] - Visualização de Pontos** 

 

O aplicativo deve permitir que o usuário visualize sua quantidade de pontos. 
 

Prioridade:  **☒ Essencial**   ☐ Importante   ☐ Desejável 

 

 

 

## Requisitos Não Funcionais 

 

**[RNF001] – Portabilidade** 

 

O aplicativo deve ser compatível com todos os sistemas operacionais, e suportar o maior número possível de suas versões. 

 

 

**[RNF002] – Segurança de acesso** 

 

Somente usuários cadastrados deverão conseguir acessar o aplicativo. 

 

 

**[RNF003] – Disponibilidade** 

 

O aplicativo deve estar disponível 24/7 (funcionamento contínuo).  

 

 

**[RNF004] – Facilidade** 

 

O aplicativo deve ser intuitivo e autoexplicativo durante seu uso. Deve apresentar instruções claras e com feedbacks. 

 

 

**[RNF005] – Desempenho** 

 

O aplicativo deve pontuar o cliente num prazo de até 1 minutos após o registro da venda. 

 

 

**[RNF006] – Privacidade de Dados** 

 

O aplicativo não deve compartilhar os dados pessoais dos usuários, nem seus interesses. 

 

 

**[RNF007] – Segurança de Dados** 

 

O aplicativo deve proteger a senha do usuário com criptografia. 

 

 


## Restrições 

 

**[RES001] – Vendas** 

 

O aplicativo não deve realizar vendas. 

 

**[RES002] – Internet** 

 

O aplicativo necessita de conexão à internet. 

 

 

## Suposições 

 

**[SUP001] – Aparelho Celular** 

 

Suponha-se que clientes e atendentes possuam um aparelho celular para fazer o uso do aplicativo, isso inclui a capacidade de validar o QR Code. 

 

 

**[SUP002] – Conectividade à Internet** 

 

Suponha-se que clientes e atendentes possuam conectividade à internet para  

 

 

## Sugestões 

 

**[SUG001] – Notificações por Push** 

 

Sugere-se que seja implementado notificações por push para alertar clientes sobre pontos recebidos e novos prêmios disponíveis. 

 

 

**[SUG002] – Rede de Comércios** 

 

Sugere-se que seja implementado a possibilidade de abranger uma rede de comércios. 

 
