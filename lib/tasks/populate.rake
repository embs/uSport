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
  c.name = "Nóbrega Football Class"
  c.owner << u
  c.save
  u.channels << c
  m = FootballMatch.new
  m.name = "Recife X Olinda"
  m.date = Time.now
  m.save
  c.matches << m
  p = Player.new
  p.first_name = "Arthur"
  p.last_name = "Oliveira"
  p.number = 404
  p.save
  p = Player.new
  p.first_name = "João"
  p.last_name = "das Palmeiras"
  p.number = 39
  p.save

  t1 = Team.new
  t1.name = "Recife"
  t1.sport_type = "Football"
  m.teams << t1

  t2 = Team.new
  t2.name = "Olinda"
  t2.sport_type = "Football"
  m.teams << t2

  v = Move.new
  v.kind = "Field Goal is Good"
  v.match = m
  v.team = t1
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Kickoff"
  v.match = m
  v.description = 'Essa jogada foi arretada'
  v.team = t1
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Interceptação"
  v.match = m
  v.team = t1
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Punt"
  v.match = m
  v.team = t2
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Fumble"
  v.match = m
  v.team = t2
  v.save
  p.moves << v

  v = Move.new
  v.kind = "Touchdown"
  v.match = m
  v.team = t2
  v.save
  p.moves << v
end
