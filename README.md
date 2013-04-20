# USport
Aplicativo para a disciplina de Projetão do Centro de Informática.

## Descrição do projeto
Aplicativo web que permite a trasmissão e acompanhamento de jogos de futebol americano.

Os modelos principais do aplicativo são:
* User
* Channel
* Match
* Move
* Team
* Player

## Wiki
Se você precisar de ajuda e as informações do README não forem suficientes para resolver
seu problema, consulte a [Wiki do projeto](https://github.com/carlosecmacedo/quince/wiki).
Lá você pode encontrar informações importantes sobre ferramentas utilizadas e setup --
incluindo [como instalar o PostgreSQL](https://github.com/carlosecmacedo/quince/wiki/Instalando-o-PostgreSQL-em-distribui%C3%A7%C3%B5es-baseadas-no-Ubuntu)

##  Setup

### Banco de dados
Para configurar o banco de dados devidamente usando o framework Rails, é necessário
dispor do arquivo config/database.yml. Esse arquivo indica qual banco de dados
será utilizado e como abrir conexão com ele. Além disso, é independente do projeto
-- isto é, desenvolvedores do mesmo projeto podem utilizar bancos diferentes (um
utilizando Postgres, outro MySQL e outro SQLite, por exemplo). [Exemplo](https://gist.github.com/embs/3708848).
#### Criar Bancos e Tabelas
Com o database.yml devidamente configurado, basta
```shell
# Criar banco de dados do ambiente de produção
$ rake db:create

# Criar todos os bancos de dados setados em database.yml
$ rake db:create:all

# Criar as tabelas
$ rake db:migrate
```
#### Derrubar Bancos
Pode ser que seja necessário dropar os bancos e recriar as tabelas, assim:
```shell
$ rake db:drop # ou rake db:drop:all para dropar todos os bancos
```
e depois criar os bancos e tabelas novamente com os comandos supracitados.
#### Resetar Bancos
Se o intuito for apenas limpar as linhas de todas as tabelas, o reset é usado
```shell
$ rake db:reset
```
*Atenção!* esse comando não altera as estruturas da tabela. Portanto, se qualquer
migration for alterada, é necessário dropar e recriar os bancos para que as modificações
façam efeito.

### Testes
Para rodar os testes, é necessário criar as tabelas no ambiente de testes com
```shell
$ rake db:test:prepare # que é análogo a rake db:migrate RAILS_ENV=test
```
e então, para rodar todas as specs:
```shell
$ rspec
```
É possível rodar somente algumas specs das seguintes maneiras:
```shell
$ rspec spec/controllers/moves_controller_spec.rb # indicando o nome do arquivo

# Ou indicando o nome do arquivo e o número da linha do caso de teste que se quer rodar!
$ rspec spec/controllers/moves_controller_spec.rb:81
```

## Pusher
### Ativar WebHooks no ambiente de desenvolvimento
```ruby
#TODO
```

## Delayed::Job
[Delayed::Job](https://github.com/collectiveidea/delayed_job) é a biblioteca utilizada para
realizar ações em background -- de modo que elas não impactem na performance do servidor da
aplicação ao responder a requisições de clientes.

### Fazendo com que delayed jobs funcionem no ambiente de desenvolvimento
Para tal, é necessário rodar o Foreman:
```bash
$ foreman start
```

## Quick Start
Vamos supor que você instalou o Linux agora, e que não tem nada do projeto no seu
PC. A partir dos passos a seguir, é possível dar um quick start no projeto, com o
objetivo de otimizar o tempo nessa etapa.

### Configurando um repositório Git
1. A maioria das distribuições Linux já possui o Git instalado, mas caso não esteja,
instale a partir do comando `sudo apt-get install git`
2. Configure o seu usuário e seu email a partir dos comandos a seguir. O email precisa
ser o mesmo cadastrado no github.
```shell
$ git config --global user.name "seu nome"
$ git config --global user.email "seu email do github"
```
3. Você precisa agora criar uma chave SSH para poder autorizar o seu computador no
github. Supondo que não exista nenhuma no seu sistema, execute o comando a seguir,
usando seu email do github. Não é necessário configurar uma passphrase (pode apertar
enter).
```shell
$ ssh-keygen -t rsa -C "your_email@example.com"
```
4. Copie a chave gerada (até o final, inclusive o email).
Acesse esse [link](https://github.com/settings/ssh) e clique em 'Add SSH key'.
Insira a chave e clique em "Add key" e confirme com sua senha do Github. Teste a
configuração com o comando `ssh -T git@github.com` (esse email mesmo). Caso tenha
dado algo errado, visite este [link](https://help.github.com/articles/generating-ssh-keys).
5. Em uma pasta qualquer (a pasta que conterá a pasta do repositório), digite o
seguinte comando no terminal:
```shell
git clone git@github.com:carlosecmacedo/quince.git
```
Isto irá criar automaticamente um repositório contendo todos os arquivos do projeto.

## Deploy no Heroku
O [Heroku](https://www.heroku.com/) é o provedor de infraestrutura que estamos utilizando
para hostear o uSport. Há várias motivações para a escolha desse provedor -- no entanto,
a principal é que eles oferecem um bom plano gratuito.

### Enviando código pro Heroku (também chamado fazer / dar deploy)
Antes de mais nada, você precisa estar entre os colaboradores da aplicação usport no Heroku.
Se você não faz parte dessa seleta lista de desenvolvedores, contate um dos atuais
colaboradores (atualmente, Diogo, Matheus ou Romero) e peça para que ele o adicione como
colaborador. Depois disso, basta adicionar o repositório remoto à sua lista de repositórios
do git, assim:
```bash
$ git remote add heroku git@heroku.com:usport.git
```
Depois é só dar um push comum:
```bash
$ git push heroku master
```

### Delayed::Job no Heroku
Se você não sabe o que é Delayed::Job, leia [esta seção](https://github.com/carlosecmacedo/quince#delayedjob)

Para que os 'delayed jobs' funcionem adequadamente no Heroku, é necessário configurar um
worker. Isso é feito da seguinte maneira:
```bash
$ heroku ps:scale worker=1
```
Também é possível iniciar o worker através do toolbelt do Heroku (caso haja algum problema na
inicialização automática) assim:
```bash
$ heroku run bundle exec rake jobs:work
```
Para mais informações, consulte o [artigo do Heroku sobre Delayed::Job](https://devcenter.heroku.com/articles/delayed-job)

## Como Colaborar
### O jeito certo
1. Escolha um [issue no Github](https://github.com/carlosecmacedo/quince/issues)
que não esteja atribuído a alguém e atribua a você mesmo ou detecte alguma necessidade
no projeto (melhoria, conserto de bug, nova funcionalidade, concepção de tela, etc.),
crie um issue para isso e atribua a você se quiser trabalhar nele;
2. Crie um novo branch (a partir do master) com o nome da modificação que você
irá realizar. Por exemplo: se quero mudar o nome da rota pro usuário, então crio o
branch e mudo pra ele com `git checkout -b user-url-refactor`;
3. Implemente;
4. Commit. Por exemplo: já alterei a rota para usuário e todos os testes estão
passando, então eu adiciono tudo ao meu commit com `git add .`, crio o novo commit
com `git commit -m "Altera a URL para visualização de perfil de usuário de maneira
que a URL agora é /users/usernamedousuario. Closes #número-do-issue-relacionado"`
e faço o push pro repositório remoto com `git push origin user-url-refactor`;
5. Através da interface [gráfica do Github](https://github.com/carlosecmacedo/quince),
crie um novo Pull Request informando que quer dar merge das mudanças contidas no
branch user-url-refactor para o branch master;
6. Aguarde revisão de outros colaboradores até que não haja ressalvas quanto ao merge;
7. Tudo certo, o merge é feito (por você ou por outro colaborador) e o branch é removido
(se não houver outras modificações a ser pushadas para ele);

### O jeito "vai assim mesmo"
1. Implemente;
2. Commit com `git push origin master`;
3. Reze para que dê certo;
4. Dois passos:
  * se deu certo, sorte sua;
  * se não deu, dê `git pull origin master` para atualizar seu repositório local,
  resolva os conflitos e tente dar o push novamente;

*ATENÇÃO!!!* Cuidado pra não apagar nenhuma modificação importante na hora de
resolver os conflitos!

## Licença
```ruby
#TODO
```
