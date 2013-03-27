# encoding: utf-8
namespace :bootstrap do
  task mariners: :environment do
    2.times do |n|
      m = Team.create(name: "Recife Mariners #{n+1}", abbreviation: 'MAR',
        sport_type: 'Futebol Americano', is_official: true,
        avatar: open('app/assets/images/escudos/mariners.jpg'))
      Player.create(first_name: 'Rafael', last_name: 'Palmeira', number: 1, team: m)
      Player.create(first_name: 'Gringo', last_name: '.', number: 2, team: m)
      Player.create(first_name: 'Eduardo', last_name: 'Mendonça', number: 3, team: m)
      Player.create(first_name: 'Adolfo', last_name: '.', number: 4, team: m)
      Player.create(first_name: 'Arthur', last_name: 'Lima', number: 5, team: m)
      Player.create(first_name: 'Guto', last_name: 'Lima', number: 6, team: m)
      Player.create(first_name: 'Murilo', last_name: 'Avelino', number: 7, team: m)
      Player.create(first_name: 'Samuel', last_name: 'Brás', number: 8, team: m)
      Player.create(first_name: 'Petrus', last_name: 'Moneta', number: 9, team: m)
      Player.create(first_name: 'Vitor', last_name: 'Rossiter', number: 10, team: m)
      Player.create(first_name: 'Bruno', last_name: 'Melo', number: 11, team: m)
      Player.create(first_name: 'Rafael', last_name: 'Freitas', number: 12, team: m)
      Player.create(first_name: 'Mario', last_name: 'Paulo', number: 13, team: m)
      Player.create(first_name: 'Tiago', last_name: 'Mago', number: 14, team: m)
      Player.create(first_name: 'Eduardo', last_name: 'Xaxi', number: 15, team: m)
      Player.create(first_name: 'Tadeu', last_name: 'Augusto', number: 16, team: m)
      Player.create(first_name: 'Yuji', last_name: 'Tashiro', number: 17, team: m)
      Player.create(first_name: 'Filipe', last_name: 'Medeiros', number: 18, team: m)
      Player.create(first_name: 'Mateus', last_name: 'Camarote', number: 19, team: m)
      Player.create(first_name: 'Mateus', last_name: 'Veras', number: 20, team: m)
      Player.create(first_name: 'Diogo', last_name: 'Sales', number: 21, team: m)
      Player.create(first_name: 'Lucas', last_name: 'Adolfo', number: 22, team: m)
      Player.create(first_name: 'David', last_name: 'Gilton', number: 23, team: m)
      Player.create(first_name: 'Eduardo', last_name: 'Caldas', number: 24, team: m)
      Player.create(first_name: 'André', last_name: 'Hugo', number: 25, team: m)
      Player.create(first_name: 'Gabriel', last_name: 'Ferreira', number: 26, team: m)
      Player.create(first_name: 'Tiago', last_name: 'Lages', number: 27, team: m)
      Player.create(first_name: 'Vinicius', last_name: 'Cantareli', number: 28, team: m)
      Player.create(first_name: 'Vitor', last_name: 'Pizon', number: 29, team: m)
      Player.create(first_name: 'Filipe', last_name: 'Nascimento', number: 30, team: m)
      Player.create(first_name: 'José', last_name: 'Antônio', number: 31, team: m)
      Player.create(first_name: 'Sérgio', last_name: 'Mendes', number: 32, team: m)
      Player.create(first_name: 'Rômulo', last_name: 'Albuquerque', number: 33, team: m)
      Player.create(first_name: 'Pedro', last_name: 'Fernandes', number: 34, team: m)
      Player.create(first_name: 'Artur', last_name: 'Novato', number: 35, team: m)
      Player.create(first_name: 'Lucas', last_name: 'Novato', number: 36, team: m)
      Player.create(first_name: 'Aspira', last_name: '.', number: 37, team: m)
      Player.create(first_name: 'Sérgio', last_name: 'Novato', number: 38, team: m)
      Player.create(first_name: 'Eduardo', last_name: 'Mendonça', number: 39, team: m)
      Player.create(first_name: 'Emerson', last_name: 'Veloso', number: 40, team: m)
    end
  end

  task :all => [:environment, :mariners]
end
