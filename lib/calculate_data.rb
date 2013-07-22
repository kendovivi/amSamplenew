#encoding: utf-8
require 'csv'
require 'time'

#CSV ファイルを読み込み、指定された計算を行う。結果をHashフォーマットでam_charts_controllerに返す
#Input file_path
#Return result_hash
class Cal
  def calculate_data(file_path,selHeader_arr, selTime_arr)
    
    #load csv file
    headers, *scores = CSV.read(file_path)
    arr_t, *arr_v = scores.transpose                                  #arr_tは入りかえる前の第一列（時間）, arr_vは入りかえる前の第二以後の列（温度）
    header_index_hash = {}
  
  
    #set parameters
    #selHeader_arr = ["AIR","KWH"] if selHeader_arr == []              #set default for selHeader_arr
    #selTime_arr = ["2013/6/5 0:40", "2013/6/5 0:59"] if selTime_arr == nil         # set default for selTime_arr
    arr_t_selIndex = [arr_t.rindex("#{selTime_arr[0]}"),arr_t.rindex("#{selTime_arr[1]}")]
    suffix = if arr_t.rindex("#{selTime_arr[0]}").blank? || arr_t.rindex("#{selTime_arr[1]}").blank? 
      1
    else 
      0 
    end
    timePeriod = 2      
    # set header index hash 
    headers.each_with_index{|header,i|  
      next if i == 0
      header_index_hash["#{header}"] = i 
    }
    
    
    #***********************************start calculating**************************************
    #result_hash[:headerName] = arr_v[]
    result_hash = add(arr_v, arr_t, selHeader_arr, arr_t_selIndex, header_index_hash, timePeriod, suffix)  
    #***********************************finish calculating**************************************
    
    
    #***********************************result**************************************  
    result = []
    result << result_hash << headers[1..headers.length] << arr_t << suffix    #2013/07/19 @wang test
    #result << result_hash << headers[1..headers.length] << arr_t
    #result << testresult  
    #***********************************result**************************************
    
    return result
  end
  
  
  
  
  def add(value_arr, time_arr, selHeader_arr, selTimeIndex_arr, header_index_hash, timePeriodtoCal, suffix)
    
    result_hash = {}
    timeStartIndex = selTimeIndex_arr[0]
    timeLastIndex = selTimeIndex_arr[1]
    selTimePeriodLength = time_arr[timeStartIndex..timeLastIndex].length
    selTimePeriodLength / timePeriodtoCal == 0? cnt = 1: cnt = selTimePeriodLength / timePeriodtoCal     #garentee at least 1 cnt       
    lastcnt = selTimePeriodLength % timePeriodtoCal
    
    #start calculate***************************************
    selHeader_arr.each_with_index{|selHeader, i|
      headerIndex = header_index_hash["#{selHeader}"]
      break if suffix == 1                                                #can not find data error
      
      timeStartIndex = selTimeIndex_arr[0]
      cnt.times do |j|
        sub = 0
        f = timeStartIndex + timePeriodtoCal - 1
        f = timeStartIndex + lastcnt if f - timeStartIndex > selTimePeriodLength
        
        time_arr[timeStartIndex..f].each_with_index{|pass, t|
          sub += value_arr[headerIndex - 1][timeStartIndex + t].to_i
          t += 1
        }
        x = timeStartIndex
        time = Time.parse(time_arr[timeStartIndex]).to_i.to_s                  #change to time format if the 1st column is date format
        #time = arr_t[k]                                                    #do nothing if the 1st column is string format
        
        result_hash["#{selHeader},#{time}"] = if selHeader == "AIR"
          if j == 0 && cnt != 1
            0
          elsif cnt == 1
            value_arr[headerIndex-1][f].to_i - value_arr[headerIndex-1][timeStartIndex].to_i
          else
            value_arr[headerIndex-1][f].to_i - value_arr[headerIndex-1][timeStartIndex-1].to_i
          end
        else
          sub
        end
        
        timeStartIndex += timePeriodtoCal
      end   
    }
    #finish calculate**************************************
    
    return result_hash
  
  end
  
  def average(){}
    #finish calculate**************************************
    
    return result_hash
    
  end 
end


#arr = ["AIR","KWH"]
#selTime_arr = ["2013/6/5 0:00", "2013/6/5 0:59"]
  
#puts Cal.new.calculate_data("../public/data/CSV_2013060500.csv", arr, selTime_arr)
