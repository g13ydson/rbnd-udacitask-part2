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

  def format_priority(priority)
    value =  case priority
    when "high" then " ⇧".colorize(:red)
    when "medium" then " ⇨".colorize(:yellow)
    when "low" then " ⇩".colorize(:green)
    else ""
    end
  end

end
