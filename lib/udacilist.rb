class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? options[:title] : "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    allowed_types = { todo: TodoItem, link: LinkItem, event: EventItem }
    if allowed_types.keys.include? type.to_sym
      @items.push allowed_types[type.to_sym].new description, options
    else
      raise UdaciListErrors::InvalidItemType, "#{type} type doesn't exist"
    end
  end

  def delete(index)
    check_delete(index)
    @items.delete_at(index - 1)
  end
  def all
    formatador = Formatador.new
    formatador.display_line("*"*30 +"#{@title.upcase}"+"*"*30)
    res = @items.each_with_index.map { |item,position| {item: position + 1, details: item.details} }
    formatador.display_table(res,[:item, :"details"])    
  end

  def filter(type)
    formatador = Formatador.new
    formatador.display_line("-"*30 +"#{@title.upcase}"+"-"*30)

    list = get_list_by_type(type)
    if list.length == 0 
      puts "There is no such item"
    else
      res = list.each_with_index.map {|item,position| {num:position + 1, type:item.class.to_s[0...-4], name: item.description, details: item.details}}
      formatador.display_table(res,[:num,:type, :"name", :details])    

      #list.each do |item|
       # puts "#{item.class.to_s[0...-4]}: #{item.description}"
      #end  
    end
  end

  def change_priority(index,priority)
    @items[index-1].is_a?(TodoItem) ? @items[index-1].change_priority(priority) : nil
  end

  def delete_multiply(*args)
    args.reverse!
    @items.delete_if.with_index { |_, index| args.include? index+1}
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

  def get_list_by_type(type)
    if type == "event"
        @items.find_all {|item| item.is_a?(EventItem)}
    elsif type == "link"
        @items.find_all {|item| item.is_a?(LinkItem)}
    else
        @items.find_all {|item| item.is_a?(TodoItem)}
    end
  end


end
