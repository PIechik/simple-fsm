# frozen_string_literal: true

require_relative "../../lib/simple_fsm"

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
