#------- Methods ------------------
def zip_with list1, list2, &block            # without recursion
  result = []
  for i in 0...[list1.length, list2.length].min do
    result << block.call(list1[i], list2[i])
  end
  result
end

def rzip_with list1, list2, &block           # with recursion
  return [] if list1.empty? || list2.empty?
  first1, rest1 = list1.first, list1[1..-1]
  first2, rest2 = list2.first, list2[1..-1]
  [block.call(first1, first2)] + rzip_with(rest1, rest2, &block)
end

def zip_with_n(*lists, &block)               # without recursion
  result = []
  for i in 0...(lists.map(&:length).min || 0) do
    result << block.call(lists.map {|list| list[i]})
  end
  result
end

def rzip_with_n(*lists, &block)              # with recursion
  return [] if lists.empty? || lists.any?(&:empty?)
  firsts = lists.map(&:first)
  rests = lists.map { |list| list[1..-1]}
  [block.call(firsts)] + rzip_with_n( *rests, &block)
end

def zip(list1, list2)
  zip_with(list1, list2) {|a, b| [a, b] }
end

def zips (*lists)
  zip_with_n(*lists) {|x| x }
end

#------------- Tests -------------------

require 'minitest/autorun'

describe 'zip_with_n' do
  it 'should zip N arrays' do
    zip_with_n([1, 2, 3], [4, 5, 6], [7, 8, 9]) {|(x, y, z)| x + y + z}.must_equal [12, 15, 18]
  end

  it 'should zip N arrays part 2' do
    zip_with_n([1, 2, 3], [4, 5, 6], [7, 8, 9]) {|tuple| tuple.reduce :+}.must_equal [12, 15, 18]
  end

  it 'should zip N arrays part 2' do
    zip_with_n([1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]) {|tuple| tuple.reduce :+}.must_equal [22, 26, 30]
  end

  it 'is fool-proof' do
    zip_with_n() {|x| x.to_s}.must_equal []
  end

end

describe 'rzip_with_n' do
  it 'should zip N arrays' do
    rzip_with_n([1, 2, 3], [4, 5, 6], [7, 8, 9]) {|(x, y, z)| x + y + z}.must_equal [12, 15, 18]
  end

  it 'should zip N arrays part 2' do
    rzip_with_n([1, 2, 3], [4, 5, 6], [7, 8, 9]) {|tuple| tuple.reduce :+}.must_equal [12, 15, 18]
  end

  it 'should zip N arrays part 2' do
    rzip_with_n([1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12]) {|tuple| tuple.reduce :+}.must_equal [22, 26, 30]
  end

  it 'is fool-proof' do
    rzip_with_n() {|x| x.to_s}.must_equal []
  end
end

describe 'zip_with' do
  it 'zips two array with block' do
    zip_with([1, 2, 3], [4, 5, 6], &:+).must_equal [5, 7, 9]
  end

  it 'zips two array with block' do
    zip_with([1, 2, 3, 10], [4, 5, 6], &:+).must_equal [5, 7, 9]
  end

  it 'zips two array with block' do
    zip_with([1, 2, 3], [4, 5, 6, 10], &:+).must_equal [5, 7, 9]
  end

  it 'zip two arrays with block part 2' do
    zip_with(%w[a b c], %w[d e f]) {|x, y| "#{x.upcase} - #{y}"}.must_equal ["A - d", "B - e", "C - f"]
  end
end

describe 'rzip_with' do
  it 'zips two array with block' do
    rzip_with([1, 2, 3], [4, 5, 6], &:+).must_equal [5, 7, 9]
  end

  it 'zips two array with block' do
    rzip_with([1, 2, 3, 10], [4, 5, 6], &:+).must_equal [5, 7, 9]
  end

  it 'zips two array with block' do
    rzip_with([1, 2, 3], [4, 5, 6, 10], &:+).must_equal [5, 7, 9]
  end

  it 'zip two arrays with block part 2' do
    rzip_with(%w[a b c], %w[d e f]) {|x, y| "#{x.upcase} - #{y}"}.must_equal ["A - d", "B - e", "C - f"]
  end
end


describe 'zip' do
  it 'should work' do
    zip([1, 2, 3], [4, 5, 6]).must_equal [[1, 4], [2, 5], [3, 6]]
  end
end

describe 'zips' do
  it 'should work' do
    zips([1, 2, 3], [4, 5, 6], [7, 8, 9]).must_equal [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  end
end











