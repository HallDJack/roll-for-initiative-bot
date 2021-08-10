class Initiative

  TEAM = <<-TEAM
1d20+15 - Dan with +15 Lucky Fishing Hat
1d20+10 - Justin with +10 Fiber Suit of Haste
1d20+9 - Julia with +9 Chalice of Wine
1d20+5 - Stephanie with +5 Product Warhammer
1d20 - Jack
1d20 - Bhadresh
1d20 - Paul
1d20 - Sara
1d20 - Chris
  TEAM

  SOLO = <<-SOLO
1d20+15 - Dan with +15 Lucky Fishing Hat
1d20+10 - Justin with +10 Fiber Suit of Haste
1d20+9 - Julia with +9 Chalice of Wine
1d20+5 - Stephanie with +5 Product Warhammer
1d20 - Jack
1d20 - Bhadresh
1d20 - Paul
1d20 - Sara
1d20 - Chris
  SOLO

  def self.roll(type)
    input_string = type == 'TEAM' ? TEAM : SOLO
    lines = input_string.split("\n")
    output = []
    lines.each do |line|
      code, team_or_member = line.split(" - ")
      raise "Invalid Format: #{code}" unless /\d+d\d+\+?\d+?/.match?(code)
      number_of_dice, type_of_dice, bonus = /(\d+)d(\d+)\+?(\d+)?/.match(code).captures.map(&:to_i)
      roll = (1..number_of_dice).to_a.inject(0) { |sum, n| sum + rand(1..type_of_dice) } + bonus
      output << [team_or_member, roll]
    end

    output.group_by { |x| x.last }. # group duplicate rolls together
      sort { |a, b| b.first <=> a.first }. # sort groups by roll
      map(&:last). # grab just the groups
      map(&:shuffle). # shuffle members within each group of duplicates (so the order of the duplicates is random)
      flatten(1). # flatten back to the ungrouped structure
      map { |team_or_member, total_roll| "#{team_or_member} - #{total_roll}" }.
      join("\n")
  end
end
