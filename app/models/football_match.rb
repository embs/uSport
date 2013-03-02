class FootballMatch < Match
  validate :has_two_teams

  private

  def has_two_teams
    errors.add(:teams, :invalid, :count => 2) if teams.size != 2
  end
end
