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
|函数|时间复杂度|实现|
| --- | --- | --- |
|`create()`|||
|`clear()`|||
|`push(x)`|||
|`pop()`|||
|`top()`|||
|`isEmpty()`|||
