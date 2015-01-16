class Phone

  attr_reader(:number, :type)

  define_method(:initialize) do |attributes = {}|
    @number = attributes[:number]
    @type = attributes[:type]
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
