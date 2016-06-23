class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    check_type(type)
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  def delete(index)
    check_delete(index)
    @items.delete_at(index - 1)
  end
  def all
    res = @items.each_with_index.map { |item,position| {item: position + 1, details: item.details} }
    Formatador.display_table(res,[:item,:details])    
  end
  private

  def check_type(typeItem)
    if  !["todo", "event", "link"].include? typeItem
        raise UdaciListErrors::InvalidItemType, "'#{typeItem}' InvalidItemType error"
    end
  end

  def check_delete(index)
    if index > @items.length 
      raise UdaciListErrors::IndexExceedsListSize, "'#{index}' IndexExceedsListSize error"
    end
  end


end
