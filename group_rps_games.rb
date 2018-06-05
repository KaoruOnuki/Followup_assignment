class Game
  def generate_your_play(number_of_games)
    $my_hands = []
    i = 0
    while i < number_of_games
      puts "#{i+1}回戦目の手を選びましょう。\n0:グー、1:チョキ、2:パー"
      $my_hands[i] = PlayerHand.new.choose_hands.to_i
      i += 1
    end

    output_myhands = []
    i = 0
    while i < $my_hands.size
      output_myhands[i] = "グー" if $my_hands[i] == 0
      output_myhands[i] = "チョキ" if $my_hands[i] == 1
      output_myhands[i] = "パー" if $my_hands[i] == 2
      i += 1
    end
    puts "あなたの手は#{output_myhands}です。"
  end
# 自分が何回戦で何を出したかをだす

  def generate_hands_list(number_of_games)
    $plays = []
    $output_plays = []
      $players_list.each do |play|
        $play = []
        $output_play = []
        i = 0
        while i < number_of_games
          $play[i] = PlayerHand.new.choose_randomhands
          $output_play[i] = "グー" if $play[i] == 0
          $output_play[i] = "チョキ" if $play[i] == 1
          $output_play[i] = "パー" if $play[i] == 2
          i += 1
        end
        $plays << $play
        $output_plays << $output_play
      end

      n = 0
      while n < $number_of_computers
        puts "#{$players_list[n]}の手は#{$output_plays[n]}"
        n += 1
      end

    $plays << $my_hands
  end
# sorted by players: それぞれのコンピュータプレイヤーが何回戦で何を出したかをだす、結果を配列に入れる(自分の結果は一番後ろ)
# （＊回戦ごとの結果をだす時に使えるようにする）
end
