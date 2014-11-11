# Extend and simplify Ruby class `DateTime`
class DateTime
  def method_missing(method)
    options = ''

    params = method.to_s.split('')
    params.each do |el|
      options = "#{options}#{el}"
      options = "#{options} " if ('a'..'z').include?(el) || ('A'..'Z').include?(el)
    end
    options = "%#{options.split(' ').join(' %')}"

    self.class.send(:define_method, method) { strftime(options) }
    strftime(options)
  end
end
