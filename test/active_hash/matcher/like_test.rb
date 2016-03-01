require 'test_helper'

class ActiveHash::Matcher::LikeTest < Minitest::Test
  def test_that_like_matcher_has_match_type
    assert_equal(:forward,  ActiveHash::Matcher::Like.forward('test').match_type)
    assert_equal(:forward,  ActiveHash::Matcher::Like.new('test%').match_type)

    assert_equal(:backward, ActiveHash::Matcher::Like.backward('test').match_type)
    assert_equal(:backward, ActiveHash::Matcher::Like.new('%test').match_type)

    assert_equal(:partial,  ActiveHash::Matcher::Like.partial('test').match_type)
    assert_equal(:partial,  ActiveHash::Matcher::Like.new('%test%').match_type)

    assert_equal(:none,     ActiveHash::Matcher::Like.new('test').match_type)
  end

  def test_forward_matcher_match_value
    matcher = ActiveHash::Matcher::Like.forward('test')

    assert(matcher.call('test'))
    assert(matcher.call('test-hoge'))
    refute(matcher.call('hoge-test'))
    refute(matcher.call('hoge-test-hoge'))
  end

  def test_backward_matcher_match_value
    matcher = ActiveHash::Matcher::Like.backward('test')

    assert(matcher.call('test'))
    refute(matcher.call('test-hoge'))
    assert(matcher.call('hoge-test'))
    refute(matcher.call('hoge-test-hoge'))
  end

  def test_partial_matcher_match_value
    matcher = ActiveHash::Matcher::Like.partial('test')

    assert(matcher.call('test'))
    assert(matcher.call('test-hoge'))
    assert(matcher.call('hoge-test'))
    assert(matcher.call('hoge-test-hoge'))
  end

  def test_full_matcher_match_value
    matcher = ActiveHash::Matcher::Like.new('test')

    assert(matcher.call('test'))
    refute(matcher.call('test-hoge'))
    refute(matcher.call('hoge-test'))
    refute(matcher.call('hoge-test-hoge'))
  end

  def test_ignore_case
    matcher = ActiveHash::Matcher::Like.partial('test')

    assert(matcher.call('TEST'))
    assert(matcher.call('TEST-HOGE'))
    assert(matcher.call('HOGE-TEST'))
    assert(matcher.call('HOGE-TEST-HOGE'))
  end
end
