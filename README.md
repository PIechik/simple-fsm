# SimpleFsm
[![Test and lint](https://github.com/PIechik/simple-fsm/actions/workflows/main.yml/badge.svg)](https://github.com/PIechik/simple-fsm/actions/workflows/main.yml)

This gem is a simple implementation of a final state machine

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple-fsm', git: 'https://github.com/PIechik/simple-fsm.git'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install simple-fsm

## Usage

You need to include the SimpleFsm module and define states and events with their transitions. Each state must be declaired on a new line. You also must pass option `initial: true` with one of the states.
```ruby
class User
  include SimpleFsm

  fsm do
    state :blocked, initial: true
    state :under_moderation
    state :unblocked

    event :send_to_moderate do
      transition from: :blocked, to: :under_moderation
    end

    event :unblock do
      transition from: :under_moderation, to: :unblocked
    end
  end
end
```
You will be provided with several methods to change and check current state
```ruby
user = User.new
user.blocked?                          # => true
user.can_transfer_to_under_moderation? # => true
user.send_to_moderate                  # => true
user.blocked?                          # => false
user.under_moderation?                 # => true
user.can_transfer_to_under_moderation? # => false
user.send_to_moderate                  # => false
```