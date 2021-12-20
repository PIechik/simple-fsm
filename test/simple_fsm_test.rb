# frozen_string_literal: true

require "test_helper"
require_relative "fixtures/user"

class SimpleFsmTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SimpleFsm::VERSION
  end

  def setup
    @user = User.new
  end

  def test_class_predicate_methods
    assert @user.blocked?
    assert !@user.moderation?
  end

  def test_transition_to_another_state
    @user.moderate
    assert @user.moderation?
  end

  def test_imposible_transition
    assert @user.blocked?
    @user.unblock
    assert !@user.unblocked?
  end
end
