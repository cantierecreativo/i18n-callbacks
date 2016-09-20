# Rails I18n Keys Used

This is a variation on 'rails-18n-key-debug.md', which will print out which
I18n keys have been used to render an action.

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

    keys = {}

    if params[:debug_i18n]
      I18n.backend.before = ->(locale, key, options={}) do
        keys[key] = true
        [locale, key, options]
      end
    end

    yield

    I18n.backend.before = nil

    Rails.logger.info "I18n key usage: #{keys.keys.inspect}"
  end
end
```

# Use

When you want to see which keys are in use, add `?debug_i18n=1` in your
browser's address bar.
