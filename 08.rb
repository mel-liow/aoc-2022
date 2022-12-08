module Day08
  class << self
    
    def parse_input_to_grid(input)
      grid = []
      input.each_with_index { |row, index| grid[index] = row.chars.map {|x| x.to_i} }
      grid
    end

    def process_grid(grid)
      m, n = grid.length-1, grid[0].length-1
      # Initialise grid with empty hash
      grid_maximums = Array.new(m+1) {Array.new(n+1) {{}}}

      # Deal with Left and Right
      (0..m).each do |i|
        max_so_far = 0
        (0..n).each do |j|
          grid_maximums[i][j]["L"] = max_so_far
          max_so_far = [grid[i][j], max_so_far].max
        end
        max_so_far = 0
        (0..n).reverse_each do |j|
          grid_maximums[i][j]["R"] = max_so_far
          max_so_far = [grid[i][j], max_so_far].max
        end
      end

      # Deal with Up and Down
      (0..n).each do |j|
        max_so_far = 0
        (0..m).each do |i|
          grid_maximums[i][j]["U"] = max_so_far
          max_so_far = [grid[i][j], max_so_far].max
        end
        max_so_far = 0
        (0..m).reverse_each do |i|
          grid_maximums[i][j]["D"] = max_so_far
          max_so_far = [grid[i][j], max_so_far].max
        end
      end
      grid_maximums
    end


    def process_grid_2(grid)
      m, n = grid.length-1, grid[0].length-1
      # Initialise grid with empty hash
      closest_index_map = Array.new(m+1) {Array.new(n+1) {{}}}

      # Deal with Left and Right
      (0..m).each do |i|
        tree_hash = {}
        (0..n).each do |j|
          curr_height = grid[i][j]

          max_index = 0
          tree_hash.keys.each do |key|
            index = tree_hash[key]
            if key >= curr_height
              max_index = [index, max_index].max
            end
          end
          closest_index_map[i][j]["L"] = max_index
          tree_hash[curr_height] = j
        end

        tree_hash = {}
        (0..n).reverse_each do |j|
          curr_height = grid[i][j]

          min_index = n
          tree_hash.keys.each do |key|
            index = tree_hash[key]
            if key >= curr_height
              min_index = [index, min_index].min
            end
          end
          closest_index_map[i][j]["R"] = min_index
          tree_hash[curr_height] = j
        end
      end

      # Deal with Up and Down
      (0..n).each do |j|
        tree_hash = {}
        (0..m).each do |i|
          curr_height = grid[i][j]

          max_index = 0
          tree_hash.keys.each do |key|
            index = tree_hash[key]
            if key >= curr_height
              max_index = [index, max_index].max
            end
          end
          closest_index_map[i][j]["U"] = max_index
          tree_hash[curr_height] = i
        end

        tree_hash = {}
        (0..m).reverse_each do |i|
          curr_height = grid[i][j]
          min_index = m
          tree_hash.keys.each do |key|
            index = tree_hash[key]
            if key >= curr_height
              min_index = [index, min_index].min
            end
          end
          closest_index_map[i][j]["D"] = min_index
          tree_hash[curr_height] = i
        end
      end
      closest_index_map
    end

    def part_one(input)
      grid = parse_input_to_grid(input)
      grid_maximums = process_grid(grid)

      total = 0
      m, n = grid.length-1, grid[0].length-1

      grid.each_with_index do |row, i|
        grid.each_with_index do |col, j|
          if i == 0 or i == m or j == 0 or j == n 
            total += 1
            next
          end
          
          height = grid[i][j]
          if height > grid_maximums[i][j].values.min
            total += 1
          end
        end
      end
      total
    end

    def part_two(input)
      grid = parse_input_to_grid(input)
      grid_mapping = process_grid_2(grid)

      best_score = 0

      m, n = grid.length-1, grid[0].length-1
      grid.each_with_index do |row, i|
        grid.each_with_index do |col, j|
          tree_indexes = grid_mapping[i][j]
          score = (j - tree_indexes["L"]) * (tree_indexes["R"] - j) \
          * (i - tree_indexes["U"]) * (tree_indexes["D"] - i)

          best_score = [best_score, score].max
        end
      end
      best_score
    end
  end
end
