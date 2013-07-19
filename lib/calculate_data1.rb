#encoding: utf-8
require 'csv'
require 'time'

#CSV ファイルを読み込み、指定された計算を行う。結果をHashフォーマットでam_charts_controllerに返す
#Input file_path
#Return result_hash
def calculate_data(file_path,selHeader_arr, selTime_arr)
  
  #load csv file
  headers, *scores = CSV.read(file_path)
  arr_t, *arr_v = scores.transpose                                  #arr_tは入りかえる前の第一列（時間）, arr_vは入りかえる前の第二以後の列（温度）
  header_index_hash = {}


  #set parameters
  selHeader_arr = ["AIR","KWH"] if selHeader_arr == []              #set default for selHeader_arr
  selTime_arr = ["2013/6/1 0:40", "2013/6/1 0:59"] if selTime_arr == []         # set default for selTime_arr
  arr_t_selIndex = [arr_t.rindex("#{selTime_arr[0]}"),arr_t.rindex("#{selTime_arr[1]}")]
  suffix = if arr_t.rindex("#{selTime_arr[0]}").blank? || arr_t.rindex("#{selTime_arr[1]}").blank? 
    1
  else 
    0 
  end
  
  
  result_hash = {}                                                  #result_hash[:headerName] = arr_v[]
  
  
  # set header index hash 
  headers.each_with_index{|header,i|  
    next if i == 0
    header_index_hash["#{header}"] = i 
  }
   
   
#**********start calculate*************                                    
  selHeader_arr.each_with_index {|selHeader, i|                        #caculate avg in 10 mins
    break if suffix == 1                                               
    index = header_index_hash["#{selHeader}"]                          #get the index of header from hash
   
    flag = 10
    k = arr_t_selIndex[0]
    selLength = arr_t[arr_t_selIndex[0]..arr_t_selIndex[1]].length
    selLength / flag == 0? cnt = 1: cnt = selLength / flag     #garentee at least 1 cnt       
    lastcnt = selLength % flag
    
    
    lastSub = 0
    cnt.times do |cnt_index|
      sub = 0 
      
      f = k + flag-1
      f = k + lastcnt if f - k > selLength
      
      arr_t[k..f].each_with_index{|pass, j|  
         sub += arr_v[index-1][k+j].to_i
         j += 1      
      }
        
      time = Time.parse(arr_t[k]).to_i.to_s                #change to time format if the 1st column is date format
      #time = arr_t[k]                                     #do nothing if the 1st column is string format
      result_hash["#{selHeader},#{time}"] = if selHeader == "AIR"
        if cnt_index == 0 && cnt != 1
          0
        elsif cnt == 1
          arr_v[index-1][f].to_i - arr_v[index-1][k].to_i
        else
          arr_v[index-1][f].to_i - arr_v[index-1][k-1].to_i
        end
      else
        sub
      end
      lastSub = sub
      k += flag
    end


=begin     
    arr_t.each_with_index{|t, j|
      time = Time.parse(t).to_i.to_s
      #time = arr_t[j]  
      result_hash["#{header},#{time}"] = arr_v[i-1][j]    #put all results into result_hash
    }
=end
}
#**********calculate finished*************

result = []
result << result_hash << headers[1..headers.length] << arr_t << suffix    #2013/07/19 @wang test
#result << result_hash << headers[1..headers.length] << arr_t
return result
end

#arr = ["AIR","KWH"]
#selTime_arr = ["2013/6/5 0:00", "2013/6/5 0:59"]

#puts calculate_data("../public/data/CSV_2013060500.csv", arr, selTime_arr)

