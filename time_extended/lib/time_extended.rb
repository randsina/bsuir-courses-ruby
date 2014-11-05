# Extend and simplify Ruby class `DateTime`
class DateTime
  def method_missing(method)
    params = method.to_s.split('')
    params.map!.with_index do |el, i|
      unless el.to_i == 0
        el = "#{el}#{params[i + 1]}"
        params.delete_at(i + 1)
      end
      el
    end
    strftime("%#{params.join(' %')}")
  end
end
