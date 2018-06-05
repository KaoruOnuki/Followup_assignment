class Judgement
  def extract_each_game_result(number_of_games)
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

  def extract_all_game_results
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

  def announce_sum_result
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
