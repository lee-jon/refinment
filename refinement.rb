# Example of how to use Objects as Types in Ruby
# This is an example of a Refinement Type, which takes a type,
# a logical predicate, and an optional value.
#
# Don't go too crazy about Static types (without Logical predicates)...
# https://bugs.ruby-lang.org/issues/5583
# its may not be a good idea!

class Refinement
  def initialize(type=nil, block=nil, value=nil)
    @type  = type
    @block = block
    @value = value
    @immutable = false
  end

  #Getter and setter methods for @value
  def value
    @value
  end

  def value=(value)
    @value = value if type_test(value)
  end

  alias_method :<<, :value=

  # Test as to whether a value is allowed in the type

  def fix
    @immutable = true
  end

  def accepts?(value)
    begin
      test(value)
      true
    rescue TypeError
      false
    end
  end

  # Comparison and inspect methods
  def inspect
    @value.to_s
  end

  def ==(other_object)
    @value == other_object ? true : false
  end

  def !=(other_object)
    @value != other_object ? true : false
  end


  private

  def test(value)
    type_test(value)
  end

  def type_test(value)
    raise StandardError, "Object is fixed" if @immutable == true
    raise TypeError,"Cannot accept #{value.class} into #{@type}" unless @type==nil || value.is_a?(@type)
    raise TypeError,"Does not meet logical requirement" unless @block==nil || @block.call(value) == true

    return true
  end

  # def validity(value)
  #   !fixed
  # end

end
