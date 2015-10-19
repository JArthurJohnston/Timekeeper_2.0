module ExpectedMethods

  def expect_method a_symbol

  end

  class ExpectedMethod

    def initialize a_symbol
      @method_symbol = a_symbol
    end

    def on an_object
      @method_object = an_object
    end

    def to_be_protected

    end
  end
end