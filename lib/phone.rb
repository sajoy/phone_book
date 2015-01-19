class Phone

  attr_reader(:number, :type)

  define_method(:initialize) do |attributes|
    @number = attributes[:number]
    @type = attributes[:type]
  end

  define_method(:id) do
    if type() != nil
      type = type().split("")
    else
      type = ["i"]
    end
    number = number().split("").reverse()

    6.times() do
      number.pop()
    end

    number = number.reverse()
    number.insert(0, type.at(0))
    number.join()
  end

  define_method(:edit) do |attributes|
    old = {:number => number(), :type => type()}
    if attributes[:number].==(nil)
      edit = {:type => attributes[:type]}
    elsif attributes[:type].==(nil)
      edit = {:number => attributes[:number]}
    else
      edit = {:type => attributes[:type], :number => attributes[:number]}
    end
    Phone.new(old.merge(edit))
  end

end
