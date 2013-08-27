class PagesController < HighVoltage::PagesController
  #before_filter :authenticate
  layout :layout_for_page
  def index

  end
  def contact_us_form

  end

  protected
  def layout_for_page
    
    if params[:id].nil?
      params[:id] = params[:action]
    end
    #debugger
    case params[:id]

      when 'index'
        'home_layout'
      when 'index.html'
    	  'home_layout'
      when nil
      	'home_layout'
      when 'accaday'
        false
      when 'accaday.html'
        false
      else
        'application'
      end
   end


end