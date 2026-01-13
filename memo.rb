require "csv"
require "fileutils" # FileUtilsライブラリを読み込みます

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
memo_type = gets.to_i

if memo_type == 1
  puts "新規でメモを作成します。"
  puts "ファイル名を入力してください（例: my_memo.csv）:"
  
  file_name = gets.chomp
  file_name += ".csv" unless file_name.downcase.end_with?('.csv')

  puts "#{file_name} にメモを記入します。"
  puts "入力を終了するには、何も入力せずにEnterキーを押してください。"


  CSV.open(file_name, "a") do |csv|
    loop do
      print "> "
      input = gets.chomp
      
      if input.empty?
        break
      else
        csv << [input]
      end
    end
  end

  puts "メモを #{file_name} に保存しました。"

elsif memo_type == 2
  puts "編集したい既存のメモファイル名を入力してください（例: my_memo.csv）:"
  edit_file_name = gets.chomp
  edit_file_name += ".csv" unless edit_file_name.downcase.end_with?('.csv') 

  if File.exist?(edit_file_name)
    puts "#{edit_file_name} を編集します。"
    
    puts "--- 現在のメモ一覧 ---"
    memos = CSV.read(edit_file_name)
    memos.each_with_index do |row, index|
      puts "#{index + 1}: #{row.join(',')}"
    end
    puts "------------------------"
    
    puts "編集したい行の番号を入力してください。"
    line_number = gets.to_i
    
    if line_number > 0 && line_number <= memos.length
      puts "#{line_number}行目を編集します。新しい内容を記入してください。"
      new_content = gets.chomp
      
      memos[line_number - 1] = [new_content]
      
      CSV.open(edit_file_name, "w") do |csv|
        memos.each do |row|
          csv << row
        end
      end
      
      puts "メモを編集（上書き）しました。"
    else
      puts "無効な行番号です。"
    end
  else
    puts "#{edit_file_name} が見つかりません。"
  end

else
  puts "無効な選択です。1か2を入力してください。"
end

