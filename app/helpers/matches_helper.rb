module MatchesHelper
  def many_yards
    yards = []
    (-50..50).to_a.each do |n|
      yards << [n.to_s, n]
    end

    yards
  end
end
