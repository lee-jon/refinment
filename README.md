# Example of a Refinement Type in Ruby

Used as an example of using logical predicates and type checking of a single value.

## Use
Create a Refinement Type the normal way. It takes the format: @type, @block, @value. Type should be a ruby Object representative of a core type but it doesn't have to be. Examples could be Fixnum, FalseClass, String, Array. @block is a logical predicate that must return true or false. An optional third parameter can be passed as the initial value. Currently the initialization value does not need to be validated against TypeError.

The value of the

    x = Refinement.new( Fixnum, lambda {|x| x > 0} )

    x << "1"   # => TypeError (String != Fixnum)
    x << -5    # => TypeError (-5 > 0 != true)
    x << 10    # => true

Getters and setters work on the value variable.

    header = Refinement.new(String, lambda{|x| ["404","400","501"].includes(x)})

    header.value, body = http_error #=> only varible assigned on match

Values can be made immutable.

    x = Refinement.new(Fixnum, lambda {|x| x > 0} )
    x << 17
    x.fix

    x << 20    # => Error

## Examples
I'll endeavour to post why this is and is not a really good / bad idea later.
