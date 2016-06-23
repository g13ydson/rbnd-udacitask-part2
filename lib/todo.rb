class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    check_priority(options[:priority])
    @priority = options[:priority]
  end
  def format_priority
    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    return value
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

end
