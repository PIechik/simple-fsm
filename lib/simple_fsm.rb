# frozen_string_literal: true

require_relative "simple_fsm/version"

module SimpleFsm
  attr_reader :state

  def self.included(class_name)
    class_name.extend StateMethods
  end

  def initialize
    @state = self.class.initial_state
    super
  end

  module StateMethods
    attr_accessor :initial_state

    def fsm
      yield
    end

    def state(name, options = {})
      define_method "#{name}?" do
        name == instance_variable_get("@state")
      end
      self.initial_state = name if options[:initial]
    end

    def event(name)
      next_state = yield

      define_method name do
        if next_state && send("can_transfer_to_#{next_state}?")
          instance_variable_set("@state", next_state) ? true : false
        end
      end
    end

    def transition(from: nil, to: nil)
      define_method "can_transfer_to_#{to}?" do
        current_state = instance_variable_get("@state")
        if from.is_a? Array
          from.include?(current_state)
        else
          from == current_state
        end
      end
      to
    end
  end
end
