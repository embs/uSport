# USport
Aplicativo para a disciplina de Projetão do Centro de Informática.

## Setup
### [Faye](http://faye.jcoglan.com/)
Iniciar a instância do servidor:
```shell
$ rackup private_pub.ru -s thin -E production
```

## Descrição do projeto
Aplicativo web que permite a trasmissão e acompanhamento de jogos de futebol americano.

Os modelos principais do aplicativo são:
* User
* Channel
* Match
* Move
* Team
* Player
