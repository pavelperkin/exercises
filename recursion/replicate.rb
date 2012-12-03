def replic ( a, b )
  return [] if b == 0
  return [a] + replic(a, b-1)
end

require 'minitest/spec'
require 'minitest/autorun'

describe "replic" do
  it 'should work correct' do
    replic( 5, 10).must_equal([ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5])
  end
end
