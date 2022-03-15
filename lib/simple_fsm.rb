# frozen_string_literal: true

require_relative "simple_fsm/version"

module SimpleFsm
  class Error < StandardError; end

  def self.included(class_name)
    class_name.extend StateMethods
  end

  def self.initial_state=(name)
    @initial_state = name
  end

  def self.initial_state
    @initial_state
  end

  def initialize
    @state = SimpleFsm.initial_state
  end

  module StateMethods
    def fsm
      yield
    end

    def state(name, options = {})
      define_method "#{name}?" do
        name == instance_variable_get("@state")
      end
      SimpleFsm.initial_state = name if options[:initial]
    end

    def event(name)
      transition_to = yield

      define_method name do
        instance_variable_set "@state", transition_to if transition_to && send("can_transfer_to_#{transition_to}?")
      end
    end

    def transition(from: nil, to: nil)
      define_method "can_transfer_to_#{to}?" do
        state = instance_variable_get "@state"
        if from.is_a? Array
          from.include?(state)
        else
          from == state
        end
      end
      to
    end
  end
end
