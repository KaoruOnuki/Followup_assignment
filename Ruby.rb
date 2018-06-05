class Rule
  def plays
    puts "こんにちは\n始める前にじゃんけん大会の基本設定をします。何回戦行いますか？（半角入力）"
    input = gets.to_s.chomp

    if input =~ /^[1-9][0-9]*$/
      return input.to_i
    else
      until input =~ /^[1-9][0-9]*$/ do
        puts "ERROR: 1以上の整数を半角入力してください。"
        input = gets.to_s.chomp
      end
      return input.to_i
    end
  end

  def players
    puts "対戦相手の人数を設定します。何人にしますか？（半角入力）"
    input = gets.to_s.chomp

    if input =~ /^[1-9][0-9]*$/
      $number_of_computers = input.to_i
    else
      until input =~ /^[1-9][0-9]*$/ do
        puts "ERROR: 整数を半角入力してください。"
        input = gets.to_s.chomp
      end
      $number_of_computers = input.to_i
    end

    $players_list = []
    i = 0
    while i < $number_of_computers
      $players_list[i] = "computer#{i}"
      i += 1
    end
    puts "あなたの対戦相手#{$players_list}を生成しました。彼らの手はランダムに選ばれます。"
  end
end
number_of_games = Rule.new.plays
Rule.new.players
puts "\nさあ、いよいよじゃんけん大会を開始します。"
# じゃんけん大会を何回戦行うかと、対戦相手の人数を決める



class PlayerHand
  def hand
    your_choice = gets.to_s
    if your_choice == "0\n" || your_choice == "1\n" || your_choice == "2\n"
      return your_choice
    else
      until your_choice == "0\n" || your_choice == "1\n" || your_choice == "2\n" do
        puts "ERROR: 0-2の数字を半角入力してください。"
        your_choice = gets.to_s
      end
      return your_choice
    end
  end

  def random_choice
    (0..2).to_a.shuffle[1]
  end
end
# 自分の手は入力してもらう、コンピュータの手はランダムに選ぶ



class Game
  def your_play(number_of_games)
    $my_hands = []
    i = 0
    while i < number_of_games
      puts "#{i+1}回戦目の手を選びましょう。\n0:グー、1:チョキ、2:パー"
      $my_hands[i] = PlayerHand.new.hand.to_i
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

  def hands_list(number_of_games)
    $plays = []
    $output_plays = []
      $players_list.each do |play|
        $play = []
        $output_play = []
        i = 0
        while i < number_of_games
          $play[i] = PlayerHand.new.random_choice
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
Game.new.your_play(number_of_games)
puts "\nあなたの対戦プレイヤーの結果を見てみましょう。"
Game.new.hands_list(number_of_games)



class Judgement
  def each_game_result(number_of_games)
    $results_by_game = []
      for n in 0..number_of_games-1 do
        i = 0
        result_by_game = []
        while i < $number_of_computers+1
          result_by_game << $plays[i][n]
          i += 1
        end
        $results_by_game << result_by_game
      end
  end
# sorted by games: 回戦ごとの結果をだす時に使えるようにする（＊class Gameで出した配列の組み替え）（p "回戦ごとの結果#{$results_by_game}"で中身確認できる）

  def win_or_loose(i, axis, other_numbers)
    case axis
    when 0
      $tournament[i] = "勝ち" if other_numbers.include?(1)
      $tournament[i] = "負け" if other_numbers.include?(2)
    when 1
      $tournament[i] = "勝ち" if other_numbers.include?(2)
      $tournament[i] = "負け" if other_numbers.include?(0)
    when 2
      $tournament[i] = "勝ち" if other_numbers.include?(0)
      $tournament[i] = "負け" if other_numbers.include?(1)
    end
  end
# axisは基準となる人、ここで指定された人が買ったか負けたかを定義する（＊１対１の時とは違って計算式ではできない。あいこの場合を除いてaxisがグーの時他に一人でもチョキがいれば負ける）

  def win_loose_or_tie(i, axis, other_numbers)
    all_hands = [0,1,2]
    if $results_by_game[i].permutation(all_hands.size).include?(all_hands) || $results_by_game[i].uniq.count == 1
      $tournament[i] = "あいこ"
    else
      win_or_loose(i, axis, other_numbers)
    end
  end
# あいこの定義（全員同じが、違う手が全部出た時）あいこじゃない時def win_or_looseで勝ち負けの判定をする

  def all_game_results
    $tournaments = []
      for n in 0..$number_of_computers do
        i = 0
        $tournament = []
        while i < $results_by_game.size
          $original_result = $results_by_game[i].dup
          $sliced_result = $results_by_game[i].dup
          axis = $sliced_result.slice!(n)
          other_numbers = $sliced_result

          win_loose_or_tie(i, axis, other_numbers)
          i += 1
        end

        $tournaments << $tournament

        if $players_list[n].nil? == true
          puts "あなたの結果#{$tournament}"
        else
          puts "#{$players_list[n]}の結果#{$tournament}"
        end
      end

  end
# axisで軸となる手を決める （sliceで取り出す）、残りの手が何を出しているかで勝敗を決める。
# 診断（『プレイヤー１：１回戦目勝ち、２回戦目負け、３回戦目あいこ。。。』）を一人一人にapplyしていく（for n in 0..$number_of_computers do...）（＊総合結果（全回戦終わった時の勝敗、あいこの数）をだす時に使えるようにする）（p $tournamentsで中身確認できる）
# ＊sliceで取り出すとループで戻った時に元々の$results_by_game[i]が取り出した後の配列になってるので、$original_resultで予め元々の配列をとっておく（dupでobejctIDを変えられるから別物としてとっておける）
# コンピュータが存在しない時”あなた”の手（自分の手は配列の最後にいれてるから、配列の中身の数は$players_listの数（＝コンピュータの数）＋１になってる）

  def sum_result
    i = 0
    while i < $tournaments.size
      $tournament_result = []
      $tournament_result << "あいこの数#{$tournaments[i].count("あいこ")}"
      $tournament_result << "勝ちの数#{$tournaments[i].count("勝ち")}"
      $tournament_result << "負けの数#{$tournaments[i].count("負け")}"

      if $players_list[i].nil? == true
        puts "あなたの総合結果#{$tournament_result}"
      else
        puts "#{$players_list[i]}の総合結果#{$tournament_result}"
      end
      i += 1
    end
  end
# 勝敗、あいこの数を数える

end
Judgement.new.each_game_result(number_of_games)
puts "\nプレイヤー全員の結果発表です。"
Judgement.new.all_game_results
puts "\nじゃんけん大会の結果です。"
Judgement.new.sum_result
