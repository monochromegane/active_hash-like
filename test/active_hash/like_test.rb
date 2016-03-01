require 'test_helper'

class ActiveHash::LikeTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ActiveHash::Like::VERSION
  end

  class Country < ActiveHash::Base
    self.data = [
      {:id => 1, :name => "US"},
      {:id => 2, :name => "Canada"}
    ]
  end

  def test_active_hash_has_like_method
    assert_respond_to(Country, :like)
  end

  def test_where_method_receive_colum_and_string_hash
    countries = Country.where(name: 'Canada')

    assert_equal(1,        countries.size)
    assert_equal('Canada', countries.first.name)
  end

  def test_where_method_receive_colum_and_matcher_hash
    countries = Country.where(name: ActiveHash::Matcher::Like.new('Cana%'))

    assert_equal(1,        countries.size)
    assert_equal('Canada', countries.first.name)
  end

  def test_like_method_receive_column_and_string_hash
    countries = Country.like(name: 'Cana%')

    assert_equal(1,        countries.size)
    assert_equal('Canada', countries.first.name)
  end
end
