def rec_sum in_arr
  return 0 if in_arr.empty?
  in_arr[0] + rec_sum(in_arr[1..-1])
end

require 'minitest/spec'
require 'minitest/autorun'

describe 'rec_sum' do
  it 'works' do
    rec_sum([1, 2, 3, 4, 5, 6]).must_equal(21)
    rec_sum([1, 2, 3, -4, 5, -6]).must_equal(1)
    rec_sum([]).must_equal(0)
  end
end
