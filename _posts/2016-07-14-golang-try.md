---
layout:     post
title:      "线性递归、线性迭代和树形递归"
date:       2016-07-14
summary:	玩玩golang
categories: dev
---

### 开端

刚刚看到线性递归、线性迭代和树形递归这几个概念，一时兴起，便模仿起来，也算是入门练手吧，恰巧最近在看Golang这门很简陋(是的，贬义，哈哈~~)的语言。

* 线性递归

```golang
//线性递归方法求阶乘

package main
import "fmt"
func main() {
	fmt.Println(factorial(6))
}
func factorial(i int) (n int) {
	if i == 1 {
		return 1
	} else {
		return i * factorial(i-1)
	}
}
```

* 树形递归

```golang
//树形递归方法求某个斐波那契数

package main
import "fmt"
func main() {
	fmt.Println(fib(8))
}
func fib(i int) int {
	switch i {
	case 0:
		return 0
	case 1:
		return 1
	default:
		return fib(i-1) + fib(i-2)
	}
}
```
* 线性迭代

```golang
//线性迭代方法求某个斐波那契数

package main
import "fmt"
func main() {
	fmt.Println(fib(8))
}
func fib(i int) (n int) {
	return fibIter(1, 0, i)
}
func fibIter(x, y, z int) (n int) {
	if z == 0 {
		return y
	} else {
		return fibIter(x+y, x, z-1)
	}
}
```
