module Day07

  class Node 
    attr_accessor :size, :name, :parent, :children

    def initialize(size, name, parent, children)
      @size = size
      @name = name
      @parent = parent
      @children = children
    end
  end

  class << self
    TOTAL_DISK_SPACE = 70000000
    REQUIRED_SPACE = 30000000

    def build_tree(input)
      root = nil
      curr_dir = nil

      input.each do |line|
        if line == "$ cd /"
           curr_dir = Node.new(0, "/", nil, {})
           root = curr_dir
           next
        end
        line = line.split(" ")
        
        if line[0] == "$" and line[1] == "cd"
          dir_name = line[2]
          curr_dir = dir_name == ".." ? 
            curr_dir.parent : 
            curr_dir.children[dir_name]
        elsif line[0] == "$" and line[1] == "ls"
          next
        else
          name = line[1]
          curr_dir.children[name] = line[0] == "dir" ? 
            Node.new(0, name, curr_dir, {}) : 
            Node.new(line[0].to_i, name, curr_dir, {})
        end
      end 
      root
    end

    def update_score_dfs(node)
      size = 0
      if node.children.empty?
        return node.size
      else
        node.children.each do |name, child_node|
          size += update_score_dfs(child_node)
        end
      end
      node.size = size
      size
    end


    def part_one(input)
      
      root = build_tree(input)
      update_score_dfs(root)

      def traverse(node, total)
        max_size = 100000
        temp_sum = 0
        if node.children.empty?
          return 0
        else
          if node.size <= max_size
            total += node.size
          end
          node.children.each do |name, child_node|
            total += traverse(child_node, 0)
          end
        end
        total
      end

      traverse(root, 0)
    end

    def part_two(input)
      root = build_tree(input)
      update_score_dfs(root)

      limit = REQUIRED_SPACE - (TOTAL_DISK_SPACE - root.size)

      def traverse(node, min_node, limit)

        if node.children.empty?
          return min_node
        else
          if node.size >= limit
            min_node = min_node.size == [node.size, min_node.size].min ? min_node : node
          end
          node.children.each do |name, child_node|
            min_node = traverse(child_node, min_node, limit)
          end
        end
        min_node
      end

      dir = traverse(root, root, limit).size
    end
  end
end
