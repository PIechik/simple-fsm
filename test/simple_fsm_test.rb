# frozen_string_literal: true

require "test_helper"
require_relative "fixtures/user"

class SimpleFsmTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SimpleFsm::VERSION
  end

  def test_it_does_something_useful
    assert User.new
  end
end
