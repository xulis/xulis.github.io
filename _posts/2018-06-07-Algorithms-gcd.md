---
layout:     post
title:      "[抄算法 - 0 ] 2300年前的欧几里得算法"
date:       2018-06-07
summary:    "懒得写摘要了-。-"
categories: dev
---



> 人生特漫长，这日子怎的又短促？
>
> 今天开始，无聊就抄点算法吧...



### 描述

2300年前的欧几里得算法，做的是这样一件事情：**找出两个数的最大公约数**。

自然语言描述：

*计算两个非负整数p和q的最大公约数：若q是0，则最大公约数为p。否则，将p除以q得到余数r,p和q的最大公约数即为q和r的最大公约数。*

PS: 欧几里得大概是很无聊的，那么奇怪的规律也能找到。

**实现:**

```elixir
defmodule Alt do
  def gcd(p, 0), do: p
  def gcd(p, q), do: gcd(q, rem(p, q))
end

# => oo

IO.puts Alt.gcd(10,4)
# -> 2 
IO.puts Alt.gcd(10,0)
#-> 10
```



