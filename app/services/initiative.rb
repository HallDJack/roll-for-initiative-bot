class Initiative

  DEV = <<-DEV
1d20 - Adam Glover
1d20 - Chris
1d20 - David
1d20 - E'lon
1d20 - Franco
1d20 - Harsh
1d20 - James
1d20 - Jose
1d20 - Nick
1d20 - Preet
1d20 - Sara
1d20 - Wes
  DEV
  PRODUCT = <<-PRODUCT
1d20 - Stephanie
1d20 - Mary
1d20 - Kim
1d20 - Jen
1d20 - Jared
1d20 - Adam Leon
  PRODUCT
  OTHER = <<-OTHER
1d20 - Michael
1d20 - Jack
1d20 - Jim
  
  TEAM = { 'Engineering' => DEV, 'Product' => PRODUCT, 'Other' => OTHER }

  EVERYONE = <<-EVERYONE
1d20 - Michael
1d20 - Stephanie
1d20 - Jack
1d20 - Sara
1d20 - Chris
1d20 - Nick
1d20 - Harsh
1d20 - E'lon
1d20 - Preet
1d20 - Adam Glover
1d20 - Wes
1d20 - Mary
1d20 - Kim
1d20 - Jen
1d20 - Jared
1d20 - Adam Leon
1d20 - Jim
1d20 - James
1d20 - Jose
1d20 - Franco
1d20 - David
  EVERYONE

  SOLO = { 'Everyone' => EVERYONE }

  def self.roll(type)
    input = type == 'TEAM' ? TEAM : SOLO
    input.map do |name, input_string|
      lines = input_string.split("\n")
      output = []
      lines.each do |line|
        code, team_or_member = line.split(" - ")
        raise "Invalid Format: #{code}" unless /\d+d\d+\+?\d+?/.match?(code)
        number_of_dice, type_of_dice, bonus = /(\d+)d(\d+)\+?(\d+)?/.match(code).captures.map(&:to_i)
        roll = (1..number_of_dice).to_a.inject(0) { |sum, n| sum + rand(1..type_of_dice) } + bonus
        output << [team_or_member, roll]
      end

      rolls = output.group_by { |x| x.last }. # group duplicate rolls together
        sort { |a, b| b.first <=> a.first }. # sort groups by roll
        map(&:last). # grab just the groups
        map(&:shuffle). # shuffle members within each group of duplicates (so the order of the duplicates is random)
        flatten(1). # flatten back to the ungrouped structure
        map { |team_or_member, total_roll| "#{team_or_member} - #{total_roll}" }. # generate each output line
        join("\n") # bind the output lines together

        "#{name} #{'='*(30 - name.length)}\n#{rolls}"
    end.join("\n")
  end
end
