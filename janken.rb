def game_start
  janken_kekka = janken
  if janken_kekka == :draw
    puts "あいこです。もう一度じゃんけんをします。"
    game_start # あいこのため再帰呼び出し
  elsif janken_kekka == :exit
    puts "じゃんけんを終了しました。"
    return # ゲーム終了
  else
    # あっち向いてホイに進む
    atchimuitehoi(janken_kekka == :win)
  end
end

def janken
  hands = ["グー", "チョキ", "パー", "戦わない"]
  
  puts "じゃんけん…"
  puts "0: グー 1: チョキ 2: パー 3:戦わない"

  player_hand_str = gets.chomp
  if !player_hand_str.match?(/\A[0-3]\z/)
    puts "無効な入力です。0〜3の数字を入力してください。"
    return janken 
  end
  player_hand = player_hand_str.to_i
  computer_hand = rand(0..2)

  if player_hand == 3
    return :exit
  end

  puts "あなたの手: #{hands[player_hand]}"
  puts "コンピュータの手: #{hands[computer_hand]}"

  if player_hand == computer_hand
    return :draw
  elsif (player_hand == 0 && computer_hand == 1) ||
        (player_hand == 1 && computer_hand == 2) ||
        (player_hand == 2 && computer_hand == 0)
    puts "あなたの勝ちです！あっち向いてホイに進みます。"
    return :win
  else
    puts "あなたの負けです。あっち向いてホイに進みます。"
    return :lose
  end
end

def atchimuitehoi(player_won_janken)
  directions = ["上", "下", "左", "右"]
  puts "あっち向いてホイ…"
  puts "0: 上 1: 下 2: 左 3: 右"

  player_direction_str = gets.chomp
  if !player_direction_str.match?(/\A[0-3]\z/)
    puts "無効な入力です。0〜3の数字を入力してください。"
    return atchimuitehoi(player_won_janken) 
  end
  player_direction = player_direction_str.to_i
  computer_direction = rand(0..3)
  
  puts "あなたの指した方向: #{directions[player_direction]}"
  puts "コンピュータの指した方向: #{directions[computer_direction]}"

  if player_direction == computer_direction
    if player_won_janken
      puts "あなたの勝ちです！"
    else
      puts "あなたの負けです。"
    end
  else
    puts "引き分けです。じゃんけんからやり直します。"
    game_start 
  end
end

game_start
