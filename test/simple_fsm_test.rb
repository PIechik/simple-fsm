# frozen_string_literal: true

require "test_helper"
require_relative "fixtures/user"

class SimpleFsmTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SimpleFsm::VERSION
  end

  def test_class_has_initial_state
    user = User.new

    assert user.blocked?
    assert !user.moderation?
  end
end
