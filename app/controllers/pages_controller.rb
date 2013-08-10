class PagesController < HighVoltage::PagesController
  #before_filter :authenticate
  layout :layout_for_page
  def index

  end
  def contact_us_form
    c = 12
    debugger
  end

  protected
    def layout_for_page

      case params[:id]

      when 'index'
        'home_layout'
      when 'index.html'
    	  'home_layout'
      when nil
      	'home_layout'
      else
        'application'
      end
   end


end