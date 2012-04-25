class WhenbotController < ApplicationController

  # /whenbot/:channel/:trigger/callback
  def callback
    
    # ==== One-liner 13 ====
    response = validate_response response
    
    if response[:head_only]
      # ==== One-liner 15 ====
    else
      render response[:type] => response[:body], 
             :status => response[:status], 
             :layout => false
    end
  end

  private
  
  def validate_response(response)
    # ==== One-liner 16 ====
    response[:head_only]  ||= response[:body] ? false : true
    response[:status]     ||= :ok
    response[:type]       ||= :json
    response[:headers]    ||= ''
    response[:body]       ||= 'Success'
    # ==== One-liner 17 ====
  end
  

end
