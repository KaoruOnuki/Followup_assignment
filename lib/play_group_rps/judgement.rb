class Judgement < Game
  class << self
    def extract_each_game_result
      @results_by_game = []
      for n in 0..@@number_of_games-1 do
        result_by_game = []
        for i in 0..@@number_of_computers do
          result_by_game << @@plays[i][n]
          i += 1
        end
        @results_by_game << result_by_game
      end
    end

    def win_loose_or_tie(i, axis, other_numbers, tournament)
      all_hands = [0,1,2]
      if @results_by_game[i].permutation(all_hands.size).include?(all_hands) || @results_by_game[i].uniq.count == 1
        tournament[i] = "あいこ"
      else
        case axis
        when 0
          tournament[i] = "勝ち" if other_numbers.include?(1)
          tournament[i] = "負け" if other_numbers.include?(2)
        when 1
          tournament[i] = "勝ち" if other_numbers.include?(2)
          tournament[i] = "負け" if other_numbers.include?(0)
        when 2
          tournament[i] = "勝ち" if other_numbers.include?(0)
          tournament[i] = "負け" if other_numbers.include?(1)
        end
      end
    end

    def extract_all_game_results
      extract_each_game_result

      puts "\nプレイヤー全員の結果発表です。"
      @tournaments = []
      for n in 0..@@number_of_computers do
        i = 0
        tournament = []
        while i < @results_by_game.size
          original_result = @results_by_game[i].dup
          sliced_result = @results_by_game[i].dup
          axis = sliced_result.slice!(n)
          other_numbers = sliced_result

          win_loose_or_tie(i, axis, other_numbers, tournament)
          i += 1
        end
        @tournaments << tournament

        if n >= @@number_of_computers
          puts "あなたの結果#{tournament}"
        else
          puts "コンピュータ#{n}の結果#{tournament}"
        end
        n += 1
      end
    end

    def self.announce_sum_result
      extract_all_game_results

      puts "\nじゃんけん大会の結果です。"
      i = 0
      while i < @tournaments.size
        tournament_result = []
        tournament_result << "あいこの数#{@tournaments[i].count("あいこ")}"
        tournament_result << "勝ちの数#{@tournaments[i].count("勝ち")}"
        tournament_result << "負けの数#{@tournaments[i].count("負け")}"

        if i >= @@number_of_computers
          puts "あなたの総合結果#{tournament_result}"
        else
          puts "コンピュータ#{i}の総合結果#{tournament_result}"
        end
        i += 1
      end
    end
  end
end
