#encoding: utf-8
require 'csv'
require 'time'

#CSV ファイルを読み込み、指定された計算を行う。結果をHashフォーマットでam_charts_controllerに返す
#Input file_path
#Return result_hash
def caculate_data(file_path)
  headers, *scores = CSV.read(file_path)
  arr_t, *arr_v = scores.transpose                        #arr_tは入りかえる前の第一列（時間）, arr_vは入りかえる前の第二以後の列（温度）
  result_hash = {}                                        #result_hash[:headerName] = arr_v[]
                                      
  headers.each_with_index {|header, i|                    #caculate avg in 10 mins
      
    next if i == 0
    

    k = 0
    2.times do
      sub = 0; 
      arr_t[k..k+9].each do                                       
         sub += arr_v[i-1][k].to_i       
      end
      #time = Time.parse(arr_t[k]).to_i.to_s              #change to time format if the 1st column is date format
      time = arr_t[k]                                     #do nothing if the 1st column is string format
      result_hash["#{header},#{time}"] = sub
      k += 10
    end


=begin     
    arr_t.each_with_index{|t, j|
      #time = Time.parse(t).to_i.to_s
      time = arr_t[j]  
      result_hash["#{header},#{time}"] = arr_v[i-1][j]    #put all results into result_hash
    }
=end
}
  
return result_hash
  
end

#puts caculate_data("../public/data/CSV_test1.csv")

