[![Rubocop](https://github.com/leoncruz/injector/actions/workflows/rubocop.workflow.yml/badge.svg)](https://github.com/leoncruz/injector/actions/workflows/rubocop.workflow.yml)
[![Rubycritic](https://github.com/leoncruz/injector/actions/workflows/rubycritic.workflow.yml/badge.svg)](https://github.com/leoncruz/injector/actions/workflows/rubycritic.workflow.yml)
[![Tests](https://github.com/leoncruz/injector/actions/workflows/test.workflow.yml/badge.svg)](https://github.com/leoncruz/injector/actions/workflows/test.workflow.yml)
# SimpleInjector

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add simple_injector

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install simple_injector

## Usage

First, declare your contract to your class

```ruby
class CreateUserContract < SimpleInjector::Contract
  register :api_client, -> { ApiClient.new }
end
```

The `register` method receive a key, as a identifier of that instance and a proc that returns the object to be injectable into class

```ruby
class CreateUser
  include SimpleInjector

  contract CreateUserContract

  attr_injector :api_client

  def initialize(user_params)
    @user_params = user_params
  end

  def create
    api_client.post @user_params
  end
end
```
In your service class, include the `SimpleInjector` module. This will be add the `contract` and `attr_injector` methods

The `contract` method receives a class, your contract defined previously

The `attr_injector` receives the key, has to be the same key defined in the contract and add a method in service class to retrieve the instance.
If you define more than one instance on contract class, you could add an `attr_injector` for each instance. Ex:

```ruby
class CreateUserContract < SimpleInjector::Contract
  register :api_client, -> { ApiClient.new }
  register :notify_user, ->  { NotifyUser.new }
  register :user_model, ->  { User }
end

class CreateUser
  include SimpleInjector

  contract CreateUserContract

  attr_injector :api_client
  attr_injector :notify_user
  attr_injector :user_model

  def initialize(user_params)
    @user_params = user_params
  end

  def create
    user = user_model.save @user_params

    api_client.post '/users/create/token', { id: user.id }

    notify_user.notify(user)
  end
end
```

## License

The code is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
