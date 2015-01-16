class Phone

  attr_reader(:number, :type)

  define_method(:initialize) do |attributes = {}|
    @number = attributes[:number]
    @type = attributes[:type]
  end

  define_method(:edit) do |attributes|
    old = {:number => number(), :type => type()}
    Phone.new(old.merge({:type => attributes[:type], :number => attributes[:number]}))
  end

end
