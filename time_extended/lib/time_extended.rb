# Extend and simplify Ruby class `DateTime`
class DateTime
  def method_missing(method)
    params = "%#{method.to_s.split('').join(' %')}"
    strftime(params)
  end
end
