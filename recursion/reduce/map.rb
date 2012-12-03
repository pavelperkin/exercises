def map arr, &block
  arr.reduce([]) {|acc, x| acc << block.call(x) }
end

def include? arr, elem
  arr.reduce(false){|acc, x| elem==x ? true : acc}
end

def flatten arr
  arr.reduce([]){|acc, x| (x.respond_to? :reduce) ? acc + flatten(x)  : acc << x  }
end

def to_h1 keys, values
  keys.zip(values).reduce({}){|acc, (k, v)| acc.merge({ k => v)  }
end

def to_h2 keys, values
  keys.zip(values).reduce({}){|acc,x|  acc.merge({ x.first => x.last)  }
end


def to_h keys, values
  Hash[keys.zip(values)]
end


def select arr, &block
 arr.reduce([]){|acc, x| block.call(x) ? acc << x : acc }
end

def compact arr
  arr.reduce([]){|acc, x| x.nil? ? acc : acc << x }
end

def concat arr1, arr2
  arr2.reduce(arr1){| acc, x| acc << x }
end

def drop arr, n
  arr[n..-1].reduce([]){|acc, x| acc << x }
end

def join arr, separator=''
  arr.reduce(''){|acc, x| acc +  x + separator}[0..-(separator.length+1)]
end




require 'minitest/autorun'

describe 'map' do
  it 'work' do
    map([1, 2, 3, 4,5]){ |x| x + 1 }.must_equal([2, 3, 4, 5, 6])
  end
end

describe 'include?' do
  it 'work' do
    include?([1, 2, 3, 4, 5], 4).must_equal(true)
    include?(['a', 'b', 'c', 'd', 'e'], 'c').must_equal(true)
    include?([1, 2, 3, 4, 5], 9).must_equal(false)
    include?(['a', 'b', 'c', 'd', 'e'], 'z').must_equal(false)

  end
end

describe 'flatten' do
  it 'work' do
    flatten([ [1, 2, 3], [4, 5, 6], [7, 8, 9]]).must_equal([1, 2, 3, 4, 5, 6, 7, 8, 9])
    flatten([ [1, 2, 3], [[4], [5, 6]], [7, 8, 9]]).must_equal([1, 2, 3, 4, 5, 6, 7, 8, 9])
  end
end

describe 'to_h' do
  it 'work' do
    to_h([1, 2, 3], [4, 5, 6]).must_equal({1 => 4, 2 => 5, 3=> 6})
  end
end

describe 'select' do
  it 'work' do
    select([1, 2, 3, 4, 5]){|x| x%2==0 }.must_equal([2, 4])
  end
end

describe 'compact' do
  it 'work' do
    compact([1, nil, 3, nil, 5]).must_equal([1, 3, 5])
  end
end

describe 'concat' do
  it 'work' do
    concat([1, 2, 3], [4, 5, 6]).must_equal([1, 2,  3, 4, 5, 6])
  end
end

describe 'drop' do
  it 'work' do
    drop([1, 2, 3, 4, 5, 6], 2).must_equal([ 3, 4, 5, 6])
  end
end

describe 'join' do
  it 'work' do
    join([ 'a', 'b', 'c', 'd', 'e'], '-').must_equal('a-b-c-d-e')
    join([ 'a', 'b', 'c', 'd', 'e'], '!!!').must_equal('a!!!b!!!c!!!d!!!e')
    join([ 'a', 'b', 'c', 'd', 'e']).must_equal('abcde')
  end
end





