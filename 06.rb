require 'set'

module Day06
  class << self

    def processed_characters(input, packet_size)
      input.each do |line|
        i = packet_size - 1
        while i <= line.length do
          subset = line[i-packet_size-1, packet_size].chars
          i += 1
          return i if Set.new(subset).length == packet_size
        end
      end
    end
    
    def part_one(input)
      packet_size = 4
      processed_characters(input, packet_size)
    end

    def part_two(input)
      packet_size = 14
      processed_characters(input, packet_size)
    end
  end
end
