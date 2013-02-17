task :create_all => :environment do
  u = User.new
  u.email = "diogo.nobrega@outlook.com"
  u.first_name = "Diogo"
  u.last_name = "Nobrega"
  u.username = "diogo"
  u.password = "12345678"
  u.save
  c = Channel.new
  c.name = "Bissa Online"
  c.save
  u.channels << c
  m = Match.new
  m.name = "Copa Bissa"
  m.date = Time.now
  m.save
  c.matches << m
  p = Player.new
  p.first_name = "Arthur"
  p.last_name = "Oliveira"
  p.number = 24
  p.save
  v = Move.new
  v.kind = "Apito inicial"
  v.match = m
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Touchdown"
  v.match = m
  v.description = 'aldkjfalkdjfioai'
  v.save

  p.moves << v
  v = Move.new
  v.kind = "Homerun"
  v.match = m
  v.save
  p.moves << v
  v = Move.new
  v.kind = "Strike"
  v.match = m
  v.save
  p.moves << v

  t = Team.new
  t.name = "Recife"
  t.sport_type = "Football"
  m.teams << t

  t = Team.new
  t.name = "Olinda"
  t.sport_type = "Football"
  m.teams << t
end