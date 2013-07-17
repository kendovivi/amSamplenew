require 'create_json'
require 'caculate_data'

class AmChartsController < ApplicationController
  def mygraph
    result_hash = caculate_data("public/data/temp.csv")
	  result = create_json(result_hash)
	  @json_val = result[0]
	  @json_arr = result[1]
  end
  
  def month
    result_hash = caculate_data("public/data/month.csv")
    result = create_json(result_hash)
    @json_val = result[0]
    @json_arr = result[1]
    @max = result[2]
  end
  
  def week
    result_hash = caculate_data("public/data/week.csv")
    result = create_json(result_hash)
    @json_val = result[0]
    @json_arr = result[1]
  end
  
  def weekInHours
    result_hash = caculate_data("public/data/weekinhours.csv")
    result = create_json(result_hash)
    @json_val = result[0]
    @json_arr = result[1]
  end
  
  def hours
    result_hash = caculate_data("public/data/CSV_2013060100.csv")
    result = create_json(result_hash)
    @json_val = result[0]
    @json_arr = result[1]
    @max = result[2]
    @headers = result[3]
  end
  
  def hoursSale
    result_hash = caculate_data("public/data/hoursSale.csv")
    result = create_json(result_hash)
    @json_val = result[0]
    @json_arr = result[1]
  end
  
  def welcome
    
  end
  
end
