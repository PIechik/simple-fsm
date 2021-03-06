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
    assert !@user.under_moderation?
  end

  def test_transition_to_another_state
    @user.send_to_moderate
    assert @user.under_moderation?
  end

  def test_imposible_transition
    assert @user.blocked?
    @user.unblock
    assert !@user.unblocked?
  end

  def test_method_can_transfer_to
    assert @user.can_transfer_to_under_moderation?
    assert !@user.can_transfer_to_unblocked?
  end
end
