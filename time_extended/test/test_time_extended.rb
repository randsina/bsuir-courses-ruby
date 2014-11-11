require 'minitest/autorun'
require 'date'
require 'time_extended'

class TestTimeExtended < Minitest::Test
  def setup
    @date = DateTime.now
  end

  def test_with_strftime_ymd
    assert_equal(@date.ymd, @date.strftime("%y %m %d"))
  end

  def test_with_strftime_Bd
    assert_equal(@date.Bd, @date.strftime("%B %d"))
  end

  def test_with_strftime_M3N
    assert_equal(@date.M3N, @date.strftime("%M %3N"))
  end

  def test_with_strftime_S24N
    refute_equal(@date.S21N, @date.strftime("%S %24N"))
  end
end
