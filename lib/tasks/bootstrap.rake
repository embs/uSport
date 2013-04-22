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

  task baltimore: :environment do
    m = Team.create(name: "Baltimore Ravens", abbreviation: 'BAL',
      sport_type: 'Futebol Americano', is_official: true,
      avatar: open('app/assets/images/escudos/3.gif'))
    Player.create(first_name: 'Joe', last_name: 'Flaco', number: 5, team: m, position: 'quarterback')
    Player.create(first_name: 'Anthony', last_name: 'Allen', number: 35, team: m, position: 'running-back')
    Player.create(first_name: 'Vonta', last_name: 'Leach', number: 44, team: m, position: 'full-back')
    Player.create(first_name: 'Bernard', last_name: 'Pierce', number: 30, team: m, position: 'running-back')
    Player.create(first_name: 'Ray', last_name: 'Rice', number: 27, team: m, position: 'running-back')
    Player.create(first_name: 'Anquan', last_name: 'Boldin', number: 81, team: m, position: 'wide-receiver')
    Player.create(first_name: 'Jacoby', last_name: 'Jones', number: 12, team: m, position: 'wide-receiver')
    Player.create(first_name: 'Torrey', last_name: 'Smith', number: 82, team: m, position: 'wide-receiver')
    Player.create(first_name: 'Ed', last_name: 'Dickson', number: 84, team: m, position: 'tight-end')
    Player.create(first_name: 'Dennis', last_name: 'Pitta', number: 88, team: m, position: 'tight-end')
    Player.create(first_name: 'Terrence', last_name: 'Cody', number: 62, team: m, position: 'defensive-line')
    Player.create(first_name: 'Arthur', last_name: 'Jones', number: 97, team: m, position: 'defensive-line')
    Player.create(first_name: "Ma'ake", last_name: 'Kemoeatu', number: 96, team: m, position: 'defensive-line')
    Player.create(first_name: 'Haloti', last_name: 'Ngata', number: 92, team: m, position: 'defensive-line')
    Player.create(first_name: 'DeAngelo', last_name: 'Tyson', number: 93, team: m, position: 'defensive-line')
    Player.create(first_name: 'Josh', last_name: 'Bynes', number: 56, team: m, position: 'linebacker')
    Player.create(first_name: 'Dannel', last_name: 'Ellerbe', number: 59, team: m, position: 'linebacker')
    Player.create(first_name: 'Paul', last_name: 'Kruger', number: 99, team: m, position: 'defensive-line')
    Player.create(first_name: 'Ray', last_name: 'Lewis', number: 52, team: m, position: 'linebacker')
    Player.create(first_name: 'Albert', last_name: 'McClellan', number: 50, team: m, position: 'linebacker')
    Player.create(first_name: 'Terrell', last_name: 'Suggs', number: 55, team: m, position: 'linebacker')
    Player.create(first_name: 'Courtney', last_name: 'Upshow', number: 91, team: m, position: 'defensive-line')
    Player.create(first_name: 'Corey', last_name: 'Graham', number: 24, team: m, position: 'cornerback')
    Player.create(first_name: 'James', last_name: 'Ihedigbo', number: 32, team: m, position: 'safety')
    Player.create(first_name: 'Bernard', last_name: 'Pollard', number: 31, team: m, position: 'safety')
    Player.create(first_name: 'Ed', last_name: 'Reed', number: 20, team: m, position: 'safety')
    Player.create(first_name: 'Cary', last_name: 'Williams', number: 29, team: m, position: 'safety')
    Player.create(first_name: 'Sam', last_name: 'Koch', number: 4, team: m, position: 'punter')
    Player.create(first_name: 'Justin', last_name: 'Tucker', number: 9, team: m, position: 'kicker')
  end

  task san_francisco: :environment do
    m = Team.create(name: "San Francisco 49ers", abbreviation: 'SF',
      sport_type: 'Futebol Americano', is_official: true,
      avatar: open('app/assets/images/escudos/28.gif'))
    Player.create(first_name: 'Colin', last_name: 'Kaepernick', number: 7, team: m, position: 'quarterback')
    Player.create(first_name: 'Anthony', last_name: 'Dixon', number: 24, team: m, position: 'running-back')
    Player.create(first_name: 'Frank', last_name: 'Gore', number: 21, team: m, position: 'running-back')
    Player.create(first_name: 'LaMichael', last_name: 'James', number: 23, team: m, position: 'running-back')
    Player.create(first_name: 'Michael', last_name: 'Crabtree', number: 15, team: m, position: 'wide-receiver')
    Player.create(first_name: 'Ted', last_name: 'Ginn, Jr.', number: 19, team: m, position: 'wide-receiver')
    Player.create(first_name: 'Randy', last_name: 'Moss', number: 84, team: m, position: 'wide-receiver')
    Player.create(first_name: 'Vernon', last_name: 'Davis', number: 85, team: m, position: 'tight-end')
    Player.create(first_name: 'Delanie', last_name: 'Walker', number: 46, team: m, position: 'tight-end')
    Player.create(first_name: 'Ricky', last_name: 'Jean-Francois', number: 95, team: m, position: 'defensive-line')
    Player.create(first_name: 'Ray', last_name: 'McDonald', number: 91, team: m, position: 'defensive-line')
    Player.create(first_name: 'Justin', last_name: 'Smith', number: 94, team: m, position: 'defensive-line')
    Player.create(first_name: 'Isaac', last_name: 'Sopoaga', number: 90, team: m, position: 'defensive-line')
    Player.create(first_name: 'NaVorro', last_name: 'Bowman', number: 52, team: m, position: 'linebacker')
    Player.create(first_name: 'Ahmad', last_name: 'Brooks', number: 55, team: m, position: 'linebacker')
    Player.create(first_name: 'Tavares', last_name: 'Gooden', number: 56, team: m, position: 'linebacker')
    Player.create(first_name: 'Aldon', last_name: 'Smith', number: 99, team: m, position: 'defensive-line')
    Player.create(first_name: 'Patrik', last_name: 'Willis', number: 52, team: m, position: 'linebacker')
    Player.create(first_name: 'Tarell', last_name: 'Brown', number: 25, team: m, position: 'cornerback')
    Player.create(first_name: 'Chris', last_name: 'Culliver', number: 29, team: m, position: 'cornerback')
    Player.create(first_name: 'Dashon', last_name: 'Goldson', number: 38, team: m, position: 'safety')
    Player.create(first_name: 'Darcel', last_name: 'McBath', number: 28, team: m, position: 'safety')
    Player.create(first_name: 'Carlos', last_name: 'Rogers', number: 22, team: m, position: 'cornerback')
    Player.create(first_name: 'Donte', last_name: 'Whitner', number: 31, team: m, position: 'safety')
    Player.create(first_name: 'David', last_name: 'Akers', number: 2, team: m, position: 'kicker')
    Player.create(first_name: 'Andy', last_name: 'Lee', number: 4, team: m, position: 'punter')
  end

  task :all => [:environment, :mariners]
end
