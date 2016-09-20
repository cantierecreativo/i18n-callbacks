# Rails I18n Key Debug

Often the strings used in a Rails app come from many different places: from
your app and from various different gems (i.e. 'activerecord', 'devise',
or 'kaminari').

When this happens, you often want to know what keys are producing the
translations you are seeing in your views.

# Setup

Add an initializer for I18n (config/initializers/i18n.rb):

```
if Rails.env.development?
  I18n.backend = I18n::Backend::Callbacks.new(I18n::Backend::Simple.new)
end
```

Add an around hook in ApplicationController:

```
class ApplicationController < ActionController::Base
  around_action :debug_i18n

  private

  def debug_i18n
    if !Rails.env.development?
      yield
      return
    end

    if params[:debug_i18n]
      I18n.backend.after = ->(locale, key, options={}, result) do
        "[#{key}] #{result}"
      end
    end

    yield

    I18n.backend.after = nil
  end
end
```

# Use

When you want to see which keys are in use, add `?debug_i18n=1` in your
browser's address bar.
