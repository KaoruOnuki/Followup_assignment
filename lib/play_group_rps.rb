$: << File.dirname(__FILE__)
# $: は$LOAD_PATHを意味する

require 'play_group_rps/group_rps_rules'
require 'play_group_rps/group_rps_players_hands'
require 'play_group_rps/group_rps_games'
require 'play_group_rps/group_rps_judgements'

number_of_games = Rule.new.decide_rules
Rule.new.decide_players
puts "\nさあ、いよいよじゃんけん大会を開始します。"

Game.new.generate_your_play(number_of_games)
puts "\nあなたの対戦プレイヤーの結果を見てみましょう。"
Game.new.generate_hands_list(number_of_games)

Judgement.new.extract_each_game_result(number_of_games)
puts "\nプレイヤー全員の結果発表です。"
Judgement.new.extract_all_game_results
puts "\nじゃんけん大会の結果です。"
Judgement.new.announce_sum_result
