module Day03
  class << self

    def get_priority(char)
      priority = 0
      if char.ord >= "a".ord
        priority = char.ord - "a".ord + 1
      else
        priority = char.ord - "A".ord + 27
      end
    end

    def part_one(input)
      total = 0
      input.each do |line|
        first_half, second_half = line.strip.chars.each_slice(line.strip.length / 2).map(&:join)
        common_letter = first_half.chars & second_half.chars
        total += self.get_priority(common_letter.pop)
      end
      total
    end

    def part_two(input)
      total = 0
      group = []
      input.each do |line|
        group.push(line.strip.split(""))
        
        if group.length == 3
          common_letter = (group[0] & group[1] & group[2]).pop
          total += self.get_priority(common_letter)
          group = []
        end
      end
      total
    end
  end
end
