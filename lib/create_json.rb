#encoding: utf-8
require 'csv'

json_val = ""
def create_json(result_arr)
  result_hash = result_arr[0]
  typeHeaders = result_arr[1]
  arr_t = result_arr[2]
  suffix = result_arr[3]
  
  #get the initial time to show in html 
  starttime_dt, starttime_hm = arr_t[0].split(" ")
  year, month, day = starttime_dt.split("/")
  starttime_dt = year << "-" << sprintf("%02d", month) << "-"<< sprintf("%02d", day)
  finishtime_dt, finishtime_hm = arr_t[arr_t.length-1].split(" ")
  year, month, day = finishtime_dt.split("/")
  finishtime_dt = year << "-" << sprintf("%02d", month) << "-"<< sprintf("%02d", day)
  
  timeshow = []
  timeshow << starttime_dt << starttime_hm << finishtime_dt << finishtime_hm
  #*************************************************************************
  
  
  
  headers = []
  times = []
  values = []
  json_arr = []
  result = []
  
  result_hash.each do |key,value|
    header, time = key.split(",")
    headers << header unless headers.include? header
    times << time unless times.include? time
    values << value.to_i unless values.include? value.to_i
  end

  times.sort!
  
  # 時間の項目を除いた項目リスト
  for m in 0..headers.length - 1 do
    json_arr << ["#{headers[m]}","temp#{m+1}"]
  end

  # 以下のようなamchartsが解析できるデータを作成する
  json_val = "["
  times.each do |time|
    t = time + "000";                                                   #if time format
    val_str = "{date: new Date(#{t})"
    #val_str = "{date:"
    #val_str << "\"#{time}\""                                           #if string format
    json_arr.each do |arr_h|
      val = result_hash["#{arr_h[0]},#{time}"]
      val_str << ", #{arr_h[1]}:"
      val_str << " #{val}"
    end
    json_val << "#{val_str}},"
  end
  

  json_val << "]"

  result << json_val << json_arr << values.max << typeHeaders << timeshow << suffix
  return result
end


