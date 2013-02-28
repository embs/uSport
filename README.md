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

### [Faye](http://faye.jcoglan.com/)
O [Faye](http://faye.jcoglan.com/) é o serviço que faz funcionar o tempo real do lance-a-lance.
Para iniciar a instância do servidor:
```shell
$ rackup private_pub.ru -s thin -E production
```

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
