# encoding: utf-8
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
  v.kind = "Field Goal is Good"
  v.match = m
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Kickoff"
  v.match = m
  v.description = 'Essa jogada foi arretada'
  v.save

  p.moves << v
  v = Move.new
  v.kind = "Interceptação"
  v.match = m
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Punt"
  v.match = m
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Fumble"
  v.match = m
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Touchdown"
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
