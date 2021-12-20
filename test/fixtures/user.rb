# frozen_string_literal: true

require_relative "../../lib/simple_fsm"

class User
  include SimpleFsm

  fsm do
    state :blocked, initial: true
    state :moderation

    event :moderate do
      transition from: :blocked, to: :moderation
    end
  end
end
