module Listable
  # Listable methods go here
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(options={})
  	if options[:due]
  		options[:due].strftime("%D")
  	elsif(options[:start_date])
  		dates = options[:start_date].strftime("%D") 
    	dates << " -- " + options[:end_date].strftime("%D") if options[:end_date]
    	dates = "N/A" if !dates
    	dates
    else
    	"No due date"
  	end
  end

  #I do not understand why "format priority" because this method is used only for "TodoItem"
  def format_priority
  	
  end

end
