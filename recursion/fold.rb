def fold acc, list, &block
  return acc if list.empty?
  fold(block.call(acc, list.first), list[1..-1], &block)
end


def foldr acc, list, &block
  return acc if list.empty?
  foldr(block.call(acc, list.last), list[0..-2], &block)
end

def fold_r(acc, list, &block)
  return acc unless head
  block.call(fold_r(acc, list[1..-1], &block), list.first)
end


require 'minitest/spec'
require 'minitest/autorun'


describe "fold" do
  it "works" do
    fold(0, [1, 2, 3, 4]) {|acc, i| acc + i}.must_equal 10
  end

  it "works" do
    fold(1, [1, 2, 3, 4]) {|acc, i| acc * i}.must_equal 24
  end

  it "works from left to right" do
    fold('z', ['a', 'b', 'c', 'd']) {|acc, i| acc + i}.must_equal 'zabcd'
  end
end

describe "foldr" do
  it "works" do
    fold_r(0, [1,2,3,4]) {|acc, i| acc + i}.must_equal 10
  end

  it "works from left to right" do
    fold_r('z', ['a', 'b', 'c', 'd']) {|acc, i| acc + i}.must_equal 'zdcba'
  end
end
