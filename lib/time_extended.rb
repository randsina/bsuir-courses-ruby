# Extend and simplify Ruby class `DateTime`
class DateTime
  def method_missing(method, *args)
    options = ''

    params = method.to_s.split('')
    params.each do |el|
      options = "#{options}#{el}"
      options = "#{options} " if el.to_i == 0
    end
    options = "%#{options.split(' ').join(' %')}"

    self.class.send(:define_method, method) { strftime(options) }
    strftime(options)
  end
end
