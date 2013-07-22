require 'create_json'
require 'calculate_data'

class AmChartsController < ApplicationController
  
  def welcome   
  end
  
  def hours
    # ************************get selector sessions 【選択された項目名】***************************
    if params[:typecolumn1].blank? then

    else
      session[:typecolumn1] = params[:typecolumn1]
    end
    
    @type1_value = if session[:typecolumn1].blank?
      "AIR"
    else
      session[:typecolumn1] 
    end
    
    if params[:typecolumn2].blank? then

    else
      session[:typecolumn2] = params[:typecolumn2]
    end
    
    @type2_value = if session[:typecolumn2].blank?
      "AIR"
    else
      session[:typecolumn2] 
    end
    # **********↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑*********
    
    # ************************get selector sessions 【選択された日付と時間】***************************
    if params[:start_dt].blank? then

    else
      session[:start_dt] = params[:start_dt]
    end
    
    @start_dt = if session[:start_dt].blank?
      "2013/6/5"
    else
      @start_dt_html = session[:start_dt]
      year, month, day = session[:start_dt].split("-")
      year << "/" << sprintf("%d", month) << "/" << sprintf("%d", day) 
    end
    
    #--------------------------------
    if params[:finish_dt].blank? then
    
    else
      session[:finish_dt] = params[:finish_dt]
    end
    
    @finish_dt = if session[:finish_dt].blank?
      "2013/6/5"
    else
      @finish_dt_html = session[:finish_dt]
      year, month, day = session[:finish_dt].split("-")
      year << "/" << sprintf("%d", month) << "/" << sprintf("%d", day)
    end
    
    #--------------------------------
    if params[:start_hm].blank? then

    else
      session[:start_hm] = params[:start_hm]
    end
    
    @start_hm = if session[:start_hm].blank?
      "0:00"
    else
      session[:start_hm]
    end
    
    #--------------------------------
    if params[:finish_hm].blank? then

    else
      session[:finish_hm] = params[:finish_hm]
    end
    
    @finish_hm = if session[:finish_hm].blank?
      "0:59"
    else
      session[:finish_hm]
    end 
    # **********↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑*********
    
    
    # ************************計算メソッドとcreate_json()を呼び出し***************************
    selHeader_arr = [@type1_value, @type2_value]
    selTime_arr = ["#{@start_dt} #{@start_hm}", "#{@finish_dt} #{@finish_hm}"]
    result_hash = Cal.new.calculate_data("public/data/CSV_2013060500.csv", selHeader_arr, selTime_arr)
    result = create_json(result_hash)
    @json_val = result[0]
    @json_arr = result[1]
    @max = result[2]
    @headers = result[3]
    @timeshow = result[4]
    @suffix = result[5]
   
  end 
end
