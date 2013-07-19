#encoding: utf-8
require 'time'

class Method

def add(value_arr, time_arr, selHeader_arr, selTimeIndex_arr, header_index_hash, timePeriodtoCal, suffix)
  
  result_hash = {}
  timeStartIndex = selTimeIndex_arr[0]
  timeLastIndex = selTimeIndex_arr[1]
  selTimePeriodLength = time_arr[timeStartIndex..timeLastIndex].length
  selTimePeriodLength / timePeriodtoCal == 0? cnt = 1: cnt = selTimePeriodLength / timePeriodtoCal     #garentee at least 1 cnt       
  lastcnt = selTimePeriodLength % flag
  
  #start calculate***************************************
  selHeader_arr.each_with_index{|selHeader, i|
    headerIndex = header_index_hash["#{selHeader}"]
    
    break if suffix == 1                                                  #can not find data error
    cnt.times do |j|
      
      sub = 0
      f = timeStartIndex + timePeriodtoCal - 1
      f = timeStartIndex + lastcnt if f - timeStartIndex > selTimePeriodLength
      
      time_arr[timeStartIndex..f].each_with_index{|pass, t|
        sub += value_arr[headerIndex - 1][timeStartIndex + t].to_i
        t += 1
      }
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
end