module Day02

  OPPONENT_SCORES = {
    A: 1, 
    B: 2,
    C: 3
  }

  LOSE = 0
  DRAW = 3
  WIN = 6

  class << self

    def calculate_score(input, score_map, scoref)
      total_score = 0
      input.each do |line|
        elf_shape, second_shape = line.split(" ")
    
        elf_score, second_score = OPPONENT_SCORES[elf_shape.to_sym], score_map[second_shape.to_sym]
        total_score += second_score + scoref.call(elf_score, second_score)
      end
      total_score
    end


    def part_one(input)
      score_map = {
        X: 1,
        Y: 2,
        Z: 3
      }

      def score_fn(elf_score, my_score)
        score = 0
        if my_score == elf_score
            score = DRAW
        elsif my_score % 3 == (elf_score + 1) % 3
            score = WIN
        else
            score = LOSE
        end
      end

      total_score = self.calculate_score(input, score_map, method(:score_fn))
    end

    def part_two(input)
      score_map = {
        X: LOSE,
        Y: DRAW,
        Z: WIN
      }

      def score_fn(elf_score, outcome_score)
        score = 0
        if outcome_score == DRAW
            score = elf_score
        elsif outcome_score == WIN
            score = (elf_score + 1) % 3
            score = score == 0 ? 3 : score
        else
            score = (elf_score - 1) % 3 
            score = score == 0 ? 3 : score
        end
      end

      total_score = self.calculate_score(input, score_map, method(:score_fn))
    end
  end
end
