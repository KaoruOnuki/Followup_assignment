class Rule
  def decide_rules
    puts "こんにちは\n始める前にじゃんけん大会の基本設定をします。何回戦行いますか？（半角入力）"
    input = gets.to_s.chomp

    if input =~ /^[1-9][0-9]*$/
      input.to_i
    else
      until input =~ /^[1-9][0-9]*$/ do
        puts "ERROR: 1以上の整数を半角入力してください。"
        input = gets.to_s.chomp
      end
      input.to_i
    end
  end

  def decide_players
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
# じゃんけん大会を何回戦行うかと、対戦相手の人数を決める
