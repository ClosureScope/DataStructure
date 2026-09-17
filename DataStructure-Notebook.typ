#set text(lang: "zh", region: "cn")
#import "template.typ": *
#set text(font: (font-en, font-song))
#show strong: set text(font: (font-en, font-hei), weight: "regular")
#show emph: text.with(font: (font-en, font-kai), style: "normal")
#show: frame-style(styles.hint)
#show: ilm.with(
  title: [数据结构],
  author: "Closure",
  raw-text: (
    custom-font: ("JetBrains Mono", "Noto Sans SC"),
  ),
  figure-index: (enabled: true),
)

= 线性表
== 线性表的定义
- `create()`
- `clear()`
- `length()`
- `insert(i, x)`
- `remove(i)`
- `search(x)`
- `visit(i)`
- `traverse()`

== 线性表的顺序实现
维护`data`, `size`, `capacity`
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`| $O(1)$|申请`capacity`大小空间|
  |`clear()`|$O(1)$|`size = 0`|
  |`length()`|$O(1)$|`return size`|
  |`insert(i, x)`|$O(n)$|后续元素全部后移一位后插入，`++size`|
  |`remove(i)`|$O(n)$|后续元素全部前移一位，`--size`|
  |`search(x)`|$O(n)$|遍历|
  |`visit(i)`|$O(1)$|`return data[i]`|
  |`traverse()`|$O(n)$|遍历|
  |`doubleSpace()`|$O(n)$|拷贝到新空间后释放原空间，更新`data`, `capacity`|
]

== 线性表的链接实现
=== 单链表
维护`head`, `size`
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`| $O(1)$|申请空间|
  |`clear()`|$O(n)$|`size = 0`并遍历析构所有节点|
  |`length()`|$O(1)$|`return size`|
  |`insert(i, x)`|$O(1)$|前驱`next`指向插入节点，插入节点`next`指向后继，`++size`|
  |`remove(i)`|$O(1)$|前驱`next`指向后继，析构当前节点，`--size`|
  |`search(x)`|$O(n)$|遍历|
  |`visit(i)`|$O(n)$|遍历|
  |`traverse()`|$O(n)$|遍历|
]
=== 双链表
维护`head`, `tail`, `size`
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`| $O(1)$|申请空间|
  |`clear()`|$O(n)$|`size = 0`并遍历析构所有节点|
  |`length()`|$O(1)$|`return size`|
  |`insert(i, x)`|$O(1)$|前驱`next`，后继`prior`指向插入节点，插入节点`next`指向后继，`prior`指向前驱，`++size`|
  |`remove(i)`|$O(1)$|前驱`next`指向后继，后继`prior`指向前驱，析构当前节点，`--size`|
  |`search(x)`|$O(n)$|遍历|
  |`visit(i)`|$O(n)$|遍历|
  |`traverse()`|$O(n)$|遍历|
]
=== 循环链表
尾节点`next`指向头节点，头节点`prior`指向尾节点
= 栈
FILO
- `create()`
- `push()`
- `pop()`
- `top()`
- `isEmpty()`
== 栈的顺序实现
维护`data`, `top`
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`|$O(1)$|申请空间，`top = -1`|
  |`push(x)`|$O(1)$|`++top; data[top] = x`，数组满时调用`doubleSpace()`|
  |`pop()`|$O(1)$|`return data[top]; --top`|
  |`top()`|$O(1)$|`return data[top]`|
  |`isEmpty()`|$O(1)$|`return top == -1`|
  |`doubleSpace()`|$O(n)$|拷贝到新空间后释放原空间，更新`data`|
]

== 栈的链接实现
维护`top`
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`|$O(1)$|申请空间，`top = nullptr`|
  |`push(x)`|$O(1)$|表头插入节点，更新`top`指向当前节点|
  |`pop()`|$O(1)$|`return top->data`，更新`top`指向后继节点，析构头节点|
  |`top()`|$O(1)$|`return top->data`|
  |`isEmpty()`|$O(1)$|`return top == -1`|
]
== 栈的应用
=== 函数调用
`call`入栈，`ret`出栈
=== 符号平衡检查
遇到`(`入栈，遇到`)`出栈，需要元素出栈时栈不为空且最终栈为空即为合法表达式
=== 表达式的计算
- 前缀式：`+ a b`
- 中缀式：`a + b`
- 后缀式：`a b +`
后缀式计算算法：

读到操作数时将其入栈，读到运算符时将栈顶两个操作数出栈，把运算结果进栈

中缀式转换为后缀式算法：

