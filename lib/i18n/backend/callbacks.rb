require "i18n"

class I18n::Backend::Callbacks < Delegator
  attr_reader :wrapped
  attr_reader :before
  attr_reader :after

  def initialize(wrapped, before: nil, after: nil)
    super(wrapped)
    @wrapped = wrapped
    @before = before
    @after = after
  end

  def translate(locale, key, options = {})
    locale, key, options = before.call(locale, key, options) if before
    result = wrapped.translate(locale, key, options)
    result = after.call(locale, key, options, result) if after
    result
  end

  # implement the Delegator interface

  def __setobj__(obj)
    @wrapped = obj
  end

  def __getobj__
    wrapped
  end
end
