module Day01
  class << self
    def part_one(input)
      max_calories = 0
      curr_calories = 0

      input.each do |line|
        calorie = line.to_i
        if calorie == 0
            max_calories = max_calories > curr_calories ? max_calories : curr_calories
            curr_calories = 0
        else 
            curr_calories += calorie
        end
      end
      max_calories = max_calories > curr_calories ? max_calories : curr_calories
    end

    def part_two(input)
      curr_calories = 0
      elves = Array.new
      
      input.each do |line|
        calorie = line.to_i
        if calorie == 0
            elves.push(curr_calories)
            curr_calories = 0
        else 
            curr_calories += calorie
        end
      end
      # deal with last elf
      elves.push(curr_calories)

      sorted_elves = elves.sort_by { |number| -number }
      sorted_elves[0..2].sum()
    end
  end
end
