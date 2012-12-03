def reverse_ar in_array
  return [] if in_array.empty?
  a, *b, c = in_array
  [c, *reverse_ar(b), a].compact
end


def reverse_arr in_array
  return [] if in_array.empty?
  *a, b = in_array
  [b, *reverse_arr(a)]
end

def reverse list
  return [] if list.empty?
  reverse(list[1..-1]) << list.first
end


require 'minitest/spec'
require 'minitest/autorun'



describe 'reverse array' do
  it 'should return empty array if input array was empty' do
    reverse_ar([]).must_equal([])
  end

  it 'should reverse input array if array.length%2==0' do
    reverse_ar([1, 2, 3, 4, 5, 6]).must_equal([6, 5, 4, 3, 2, 1])
  end


  it 'should reverse input array if array.length%2==1' do
    reverse_ar([1, 2, 3, 4, 5, 6, 7]).must_equal([7, 6, 5, 4, 3, 2, 1])
  end
end


describe 'reverse array 2' do
  it 'should return empty array if input array was empty' do
    reverse_arr([]).must_equal([])
  end

  it 'should reverse input array if array.length%2==0' do
    reverse_arr([1, 2, 3, 4, 5, 6]).must_equal([6, 5, 4, 3, 2, 1])
  end


  it 'should reverse input array if array.length%2==1' do
    reverse_arr([1, 2, 3, 4, 5, 6, 7]).must_equal([7, 6, 5, 4, 3, 2, 1])
  end
end
