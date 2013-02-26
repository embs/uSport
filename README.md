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

## Licença
```ruby
#TODO
```
