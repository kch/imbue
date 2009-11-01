require 'helper'

class TestImbue < MiniTest::Unit::TestCase
  def setup
    @narf_module = Module.new do
      def narf
        'narf'
      end
    end
  end

  def teardown
    @narf_module.send :undef_method, :narf
  end

  def test_plain_include_sucks
    Enumerable.send :include, @narf_module
    assert_raises(NoMethodError) { [].narf }
  end

  def test_imbue_totally_rules
    Enumerable.send :imbue, @narf_module
    assert_equal 'narf', [].narf
  end
end
