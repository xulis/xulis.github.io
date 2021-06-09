#!/bin/ruby
o = []
10.times do |x|
p x
o << x
o.length % 3 == 0 ? (p "ccbang") : "true"
end
