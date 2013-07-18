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
    
    if params[:typecolumn2].blank? then

    else
      session[:typecolumn2] = params[:typecolumn2]
    end
    
    @type2_value = if session[:typecolumn2].blank?
      "AIR"
    else
      session[:typecolumn2] 
    end
    
    if params[:typecolumn1].blank? then

    else
      session[:typecolumn1] = params[:typecolumn1]
    end
    
    @type1_value = if session[:typecolumn1].blank?
      "AIR"
    else
      session[:typecolumn1] 
    end
    
    selHeader_arr = [@type1_value, @type2_value]
    result_hash = caculate_data("public/data/CSV_2013060100.csv",selHeader_arr)
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
