module Day04
  class << self

    def get_windows(line)
      first, second = line.strip.split(",")
      start_1, end_1 = first.split("-").map!(&:to_i)
      start_2, end_2 = second.split("-").map!(&:to_i)
      return start_1, end_1, start_2, end_2
    end

    def part_one(input)
      count = 0
      input.each do |line|
        start_1, end_1, start_2, end_2 = self.get_windows(line)
        if ((start_1 >= start_2) && (end_1 <= end_2)) || 
          (start_2 >= start_1 && end_2 <= end_1)
          count += 1
        end
      end
      count
    end

    def part_two(input)
      count = 0
      input.each do |line|
        start_1, end_1, start_2, end_2 = self.get_windows(line)
        if end_1 >= start_2 && end_2 >= start_1
          count += 1
        end
      end
      count
    end
  end
end
