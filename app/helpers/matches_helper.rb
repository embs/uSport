module MatchesHelper
  def many_yards
    yards = []
    151.times do |n|
      yards << [n.to_s, n]
    end

    yards
  end
end
