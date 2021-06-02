+++
title = "2300年前的欧几里得算法"
date = 2016-02-01
draft = false
toc = false
+++




2300年前的欧几里得算法，做的是这样一件事情：**找出两个数的最大公约数**。

自然语言描述：
<br></br>
*计算两个非负整数p和q的最大公约数：若q是0，则最大公约数为p。否则，将p除以q得到余数r,p和q的最大公约数即为q和r的最大公约数。*
<br></br>

PS: 欧几里得大概是很无聊的，那么奇怪的规律也能找到。

**实现:**

```elixir
defmodule Alt do
  def gcd(p, 0), do: p
  def gcd(p, q), do: gcd(q, rem(p, q))
end


IO.puts Alt.gcd(10,4)
#-> 2 
IO.puts Alt.gcd(10,0)
#-> 10
```



