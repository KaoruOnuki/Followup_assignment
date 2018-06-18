class PlayerHand
  def choose_hands
    your_choice = gets.to_s
    if your_choice == "0\n" || your_choice == "1\n" || your_choice == "2\n"
      your_choice
    else
      until your_choice == "0\n" || your_choice == "1\n" || your_choice == "2\n" do
        puts "エラー: 0-2の数字を半角入力してください。"
        your_choice = gets.to_s
      end
      your_choice
    end
  end

  def choose_randomhands
    (0..2).to_a.shuffle[1]
  end
end
# 自分の手は入力してもらう、コンピュータの手はランダムに選ぶ
