class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    check_priority(options[:priority])
    @priority = options[:priority]
  end
  
  def format_priority
    value =  case @priority
    when "high" then " ⇧".colorize(:red)
    when "medium" then " ⇨".colorize(:yellow)
    when "low" then " ⇩".colorize(:green)
    else ""
    end
  end

  def details
    format_description(description) + "due: " +
    format_date(due: due) +
    format_priority
  end

  def check_priority(priority)
    if  !["high", "medium", "low", nil].include? priority
        raise UdaciListErrors::InvalidPriorityValue, "'#{priority}' InvalidPriorityValue error"
    end
  end

  def change_priority(priority)
    ["high", "medium", "low", nil].include? priority ? @priority = priority : nil
  end

end
