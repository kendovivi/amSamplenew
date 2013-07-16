#encoding: utf-8
require 'csv'

def create_json(file_path)
  # headersはｃｓｖファイルの第一行である
  # scoresはｃｓｖファイルの第二行からの全部のデータ
  headers, *scores = CSV.read(file_path)
  
  # transposeメソッドでscoresデータの行と列を入りかえる
  #　arr_tは入りかえる前の第一列（時間）
  #　arr_vは入りかえる前の第二以後の列（温度）
  arr_t, *arr_v = scores.transpose

  result = []
  json_arr = []
  
  # 時間の項目を除いた項目リスト
  for m in 1..headers.length - 1 do
    json_arr << ["#{headers[m]}","temp#{m}"]
  end

  # 以下のようなamchartsが解析できるデータを作成する
  # [{ 時間1, 温度11, 温度12, 温度13, 温度14 },{ 時間2, 温度21, 温度22, 温度23, 温度24 }, ... ]
  json_val = "["
  arr_t.each_with_index{|line, i|
    t = Time.parse(line).to_i.to_s + "000"
    val_str = "{date: new Date(#{t})"
    json_arr.each_with_index{ |arr_h, j|
      val_str << ", #{arr_h[1]}: #{arr_v[j][i]}"
    }
    json_val << "#{val_str}},"
  }
  json_val.chop
  json_val << "]"

  result << json_val << json_arr
  return result
end