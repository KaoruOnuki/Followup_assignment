class Game
  class << self
    def input_rule
      input = gets.to_s.chomp
      while true
        break if input =~ /^[1-9][0-9]*$/ && (@input_number = input.to_i)
        puts "エラー： 1以上の整数を半角入力してください"
        input = gets.to_s.chomp
      end
    end

    def decide_games
      input_rule
      @@number_of_games = @input_number
      puts "-> じゃんけん大会を#{@number_of_games}回戦行います"
    end

    def decide_players
      input_rule
      @@number_of_computers = @input_number
      puts "-> あなたの対戦相手の手はランダムに選ばれます"
    end

    def set_game_rules
      puts "じゃんけん大会の基本設定をします。何回戦行いますか？（半角入力）"
      decide_games

      puts "対戦相手の人数を設定します。何人にしますか？（半角入力）"
      decide_players
    end

    def integer_to_string(output_string, hands_integer, i)
      output_string[i] = 'グー' if hands_integer[i] == 0
      output_string[i] = 'チョキ' if hands_integer[i] == 1
      output_string[i] = 'パー' if hands_integer[i] == 2
    end

    def generate_hands_list
      set_game_rules

      puts "じゃんけん大会を開始します。"
      @@plays = []
      my_hands = []
      output_myhands = []
      for i in 0..@@number_of_games-1 do
        puts "#{i+1}回戦目の手を選びましょう。\n0:グー、1:チョキ、2:パー"
        your_choice = gets.to_s

        while true
          break if your_choice == "0\n" || your_choice == "1\n" || your_choice == "2\n"
          puts "エラー: 0-2の数字を半角入力してください。"
          your_choice = gets.to_s
        end
        my_hands[i] = your_choice.to_i
        integer_to_string(output_myhands, my_hands, i)
        i += 1
      end
      puts "あなたの手は#{output_myhands}です"

      for n in 0..@@number_of_computers-1 do
        play = []
        output_play = []
        for i in 0..@@number_of_games-1 do
          play[i] = (0..2).to_a.shuffle[1]
          integer_to_string(output_play, play, i)
          i += 1
        end
        puts "コンピュータ#{n}の手は#{output_play}です"
        @@plays << play
      end
      @@plays << my_hands
    end
  end
end
