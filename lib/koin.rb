require "koin/version"
require 'bigdecimal'

class Koin < BigDecimal
  attr_accessor :currency

  def initialize(value, currency = nil)
    @currency = currency&.upcase

    if value.is_a?(Float)
      puts "VALUE IS A FLOAT! #{value}"
      super(value, 16)
    elsif value.is_a?(Koin)
      @currency ||= value.currency
      super(value)
    elsif value.is_a?(String) || value.is_a?(Integer) || value.is_a?(BigDecimal) || value.is_a?(Numeric)
      super(value)
    else
      raise NotImplementedError("Invalid `value` type: #{value.class}.")
    end
  end

  # TODO: Make sure comparisons actually work.
  # def <=>(other)
  #   raise ArgumentError.new("`currency` must be identical to compare two Koin objects. Got `#{self.currency}` and `#{other.currency}`") \
  #     unless self.currency == other.currency

  #   super
  # end
  # Koin.new(1, 'eth') == Koin.new(1)
  # Koin.new(1, 'eth') == Koin.new(1, 'eth')
  # Koin.new(1, 'btc') == Koin.new(1, 'eth')
  # Koin.new(1) == Koin.new(1)
  # Koin.new(1) == Koin.new(2)

  def to_s(*args)
    "#{super} #{currency}".strip
  end
  alias_method :inspect, :to_s
end
