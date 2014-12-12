# Rails Admin Become User

Rails Admin plugin to become a Devise user in the main application

[![Gem Version](https://badge.fury.io/gh/monkbroc%2Frails_admin_become_user.svg)](https://badge.fury.io/gh/monkbroc%2Frails_admin_become_user)
[![Code Climate](https://codeclimate.com/github/monkbroc/rails_admin_become_user.png)](https://codeclimate.com/github/monkbroc/rails_admin_become_user)

## Overview

It can be very useful to see from a user's perspective when troubleshooting user isues.

This plugin adds a custom action to the Rails Admin dashboard to sign in
as a user from your application without having to know their password.

This plugin only works for model classes that use [Devise](https://github.com/plataformatec/devise).

## Installation

To enable rails_admin_become_user, add the following to your `Gemfile`:

```ruby
gem 'rails_admin'
gem 'rails_admin_become_user'
```
`rails_admin_become_user` must be defined after `rails_admin` to work correctly.

Add in your `config/initializers/rails_admin.rb` initializer the configuration:

```ruby
RailsAdmin.config do |config|
  config.actions do
    dashboard
    index
    new
    export
    history_index
    bulk_delete
    show
    edit
    delete
    history_show
    show_in_app
    become_user   # Add the clone action
  end
end
```

## Routes

**Important:** The routes used Devise to redirect after sign in and the
routes used by Rails Admin are not in the same namespace. To prevent
routing errors, prepend `main_app` to all routes in
`ApplicationController.after_sign_in_path_for` and add the `router_name:
:main_app` to the `devise_for` route definition.

For example:
```ruby
class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || main_app.dashboard_path 
  end
```

```ruby
MyApp::Application.routes.draw do
  devise_for :users, :router_name => :main_app
end
```

## Authorization

If you are using CanCan for authorization, there will be an
authorization check for action `:become_user` on the target model. Make
sure you authorize it for the users of the Rails Admin dashboard.

For example:
```ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.administrator?
      can :become_user, User
	end
  end
end
```

## Options

By default, the plugin is enabled on all models that use Devise. You can
restrict which models will be included by using `only` or `except`.
```ruby
RailsAdmin.config do |config|
  config.actions do
    # ...
    become_user do
	  only 'User'
      # or
	  only ['User', 'Moderator']
      # or
	  except 'Admin'
	end
  end
end
```


## Contributing
Submitting a Pull Request:

1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Implement your feature or bug fix.
4. Add, commit, and push your changes.
5. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/

## License
**This project rocks and uses MIT-LICENSE.**

Copyright 2014 Julien Vanier

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

