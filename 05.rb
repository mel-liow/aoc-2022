module Day05
  class << self

    def process_stacks(lines)
      num_stacks = lines[-1].split("   ")[-1].to_i

      stacks = Array.new(num_stacks){[]}

      lines[0...-1].reverse_each do |row|
        num_stacks.times do |i|
          letter_index = 1 + 4 * i
          if letter_index < row.length and !row[letter_index].strip.empty?
            stacks[i] << row[letter_index]
          end
        end
      end
      stacks
    end

    def parse_input(input)
      grid_lines = [] 
      stacks = []

      i = 0
      while !input[i].empty?
        grid_lines << input[i]
        i += 1
      end

      stacks = process_stacks(grid_lines)
      moves_input = input[i+1..input.length-1]
      return stacks, moves_input
    end

    def process_moves(line)
      num_items, stack_from, stack_to = line.scan(/\d+/).map(&:to_i)
      return num_items, stack_from - 1, stack_to - 1
    end

    def part_one(input)
      stacks, moves_input = parse_input(input)
      moves_input.each do |line|
        num_items, source, dest = process_moves(line.strip)
        num_items.times do
          stacks[dest] << stacks[source].pop
        end
      end
      stacks.map{ |stack| stack[-1] }.join
    end

    def part_two(input)
      stacks, moves_input = parse_input(input)
      moves_input.each do |line|
        num_items, source, dest = process_moves(line.strip)

        temp = []
        num_items.times do
          temp << stacks[source].pop
        end
        num_items.times do
          stacks[dest] << temp.pop
        end
      end

      stacks.map{ |stack| stack.length > 0 ? stack[-1] : " "}.join
    end
  end
end
