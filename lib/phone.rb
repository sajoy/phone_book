class Phone

  attr_reader(:number, :type)

  define_method(:initialize) do |attributes|
    @number = attributes[:number]
    @type = attributes[:type]
  end

  
end
