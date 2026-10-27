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
== 线性表的顺序实现
维护`data`, `size`, `capacity`
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`| $O(1)$|申请`capacity`大小空间|
  |`clear()`|$O(1)$|`size = 0`|
  |`length()`|$O(1)$|`return size`|
  |`insert(i, x)`|$O(n)$|后续元素全部后移一位后插入，`++size`，数组满时调用`doubleSpace()`|
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
  |`clear()`|$O(n)$|`size = 0`并遍历析构所有结点|
  |`length()`|$O(1)$|`return size`|
  |`insert(i, x)`|$O(n)$|前驱`next`指向插入结点，插入结点`next`指向后继，`++size`|
  |`remove(i)`|$O(n)$|前驱`next`指向后继，析构当前结点，`--size`|
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
  |`clear()`|$O(n)$|`size = 0`并遍历析构所有结点|
  |`length()`|$O(1)$|`return size`|
  |`insert(i, x)`|$O(n)$|前驱`next`，后继`prior`指向插入结点，插入结点`next`指向后继，`prior`指向前驱，`++size`|
  |`remove(i)`|$O(n)$|前驱`next`指向后继，后继`prior`指向前驱，析构当前结点，`--size`|
  |`search(x)`|$O(n)$|遍历|
  |`visit(i)`|$O(n)$|遍历|
  |`traverse()`|$O(n)$|遍历|
]
=== 循环链表
尾结点`next`指向头结点，头结点`prior`指向尾结点
= 栈
LIFO
== 栈的顺序实现
维护`data`, `top`指向栈顶元素
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`|$O(1)$|申请空间，`top = -1`|
  |`push(x)`|$O(1)$|`++top; data[top] = x`，数组满时调用`doubleSpace()`|
  |`pop()`|$O(1)$|`return data[top]; --top`|
  |`top()`|$O(1)$|`return data[top]`|
  |`isEmpty()`|$O(1)$|`return top == -1`|
  |`doubleSpace()`|$O(n)$|拷贝到新空间后释放原空间，更新`data`, `capacity`|
]

== 栈的链接实现
维护`top`为单链表的头指针
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`|$O(1)$|申请空间，`top = nullptr`|
  |`push(x)`|$O(1)$|表头插入结点，更新`top`指向当前结点|
  |`pop()`|$O(1)$|`return top->data`，更新`top`指向后继结点，删除头结点|
  |`top()`|$O(1)$|`return top->data`|
  |`isEmpty()`|$O(1)$|`return top == nullptr`|
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
- 读入操作数，立刻输出
- 读入`(`，进栈
- 读入`)`，将栈中运算符不断出栈直到弹出`(`
- 读入运算符，若栈顶运算符优先级高，则不断出栈直到栈顶运算符优先级低为止，压入新运算符
- 读取结束时，出栈所有运算符
= 队列
FIFO
== 队列的顺序实现
若队头位置固定，出队会引起大量数据移动；若队头位置不固定，浪费空间

维护`data`, `front`, `rear`

循环队列：将数组首尾相连，`front`, `rear`分别指向队头前一个位置和队尾，然而这样`front == rear`时无法判断是队列空还是队列满，
故强制规定`front`指向的队头前一个位置保持为空，则`front == rear`时队列空，`front == (rear + 1) % capacity`时队列满

#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`|$O(1)$|申请空间，`front = 0; rear = 0`|
  |`enqueue(x)`|$O(1)$|`rear = (rear + 1) % capacity; data[rear] = x`，数组满时调用`doubleSpace()`|
  |`dequeue()`|$O(1)$|`front = (front + 1) % capacity; return data[front]`|
  |`front()`|$O(1)$|`return data[(front + 1) % capacity]`|
  |`isEmpty()`|$O(1)$|`return front == rear`|
  |`doubleSpace()`|$O(n)$|从`front`位置开始拷贝到新数组头部，更新`data`, `capacity`|
]
== 队列的链接实现
维护`front`, `rear`为单链表的头指针，尾指针
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`|$O(1)$|`front = nullptr; rear = nullptr`|
  |`enqueue(x)`|$O(1)$|表尾插入结点，使`rear`指向当前结点；队列为空时必须使`front`和`rear`同时指向当前结点|
  |`dequeue()`|$O(1)$|`return front -> data`，更新`front`指向后继结点，删除头结点；队列只有一个元素时必须使`front`和`rear`同时置为`nullptr`|
  |`front()`|$O(1)$|`return front -> data`|
  |`isEmpty()`|$O(1)$|`return front == nullptr`|
]

= 树
== 二叉树
=== 二叉树的概念
#definition[满二叉树][一棵高度为$k$并具有$2^k - 1$个结点的二叉树]
#definition[完全二叉树][满二叉树的最底层自右至左依次去掉若干结点得到的二叉树]
=== 二叉树的性质
#proposition[][一棵非空二叉树的第$i$层上最多有$2^(i-1)$个结点]
#proposition[][一棵高度为$k$的二叉树，最多具有$2^k-1$个结点]
#proposition[][对于一棵非空二叉树，叶子结点数为$n_0$，度数为$2$的结点数为$n_2$，则$ n_0 = n_2 + 1 $]
#proof[][
  $ abs(E) = n_0 + n_1 + n_2 - 1 = n_1 + 2 n_2 $
]
#proposition[][具有$n$个结点的完全二叉树的高度$ k = floor(log_2 n) + 1 $]
#proposition[][对一棵完全二叉树的结点按层自上而下，每一层自左至右一次编号，根结点编号为$1$，则对任一编号为$i$的结点，
  + 父结点编号为$floor(i/2)$
  + 左儿子编号为$2 i$
  + 右儿子编号为$2 i + 1$
]
=== 二叉树的遍历
+ 前序遍历 根 $->$ 左 $->$ 右
+ 中序遍历 左 $->$ 根 $->$ 右
+ 后序遍历 左 $->$ 右 $->$ 根
+ 层序遍历

#strategy[欧拉遍历得到前序，中序，后序遍历][

  沿着二叉树的外轮廓，从根结点左侧出发，始终贴着树的边缘逆时针绕一圈
  + 经过结点左侧时记录该结点 $->$ 前序遍历
  + 经过结点下侧时记录该结点 $->$ 中序遍历
  + 经过结点右侧时记录该结点 $->$ 后序遍历
]

#proposition[][

  前序+中序 / 后序+中序 能唯一确定一棵二叉树

  前序+后序 不能唯一确定一棵二叉树

  完全二叉树的层序遍历 能唯一确定一棵二叉树

  满二叉树的前序，中序，后序之一 能唯一确定一棵二叉树
]
#strategy[前序+中序确定二叉树][
  + 通过前序遍历确定根结点，在中序遍历中找到根结点，将中序遍历划分为左右子树的中序遍历
  + 通过中序遍历确定左右子树元素个数，进而找到前序遍历中左右子树的分界点，将前序遍历划分为左右子树的前序遍历
  + 递归解决左右子树的子问题
]

=== 二叉树的实现
==== 顺序实现
修补为完全二叉树
==== 链接实现
维护根指针`root`，每个`Node`维护`data`, `left`, `right`
#three-line-table[
  |函数|时间复杂度|实现|
  | --- | --- | --- |
  |`create()`|$O(1)$|`root = nullptr`|
  |`clear(Node* node)`|$O(n)$|`if (node == nullptr) return;
   clear(node->left);
    clear(node->right);
     delete node;`|
  |`isEmpty()`|$O(1)$|`return root == nullptr`|
  |`preOrder(Node* node)`|$O(n)$|`if (node == nullptr) return;
   visit(node);
    preOrder(node->left);
     preOrder(node->right);`|
  |`midOrder(Node* node)`|$O(n)$|`if (node == nullptr) return;
   midOrder(node->left);
    visit(node);
     midOrder(node->right);`|
  |`postOrder(Node* node)`|$O(n)$|`if (node == nullptr) return;
   postOrder(node->left);
    postOrder(node->right);
     visit(node);`|
  |`levelOrder()`|$O(n)$|从根结点开始BFS|
  |`height(Node* node)`|$O(n)$|`if (node == nullptr) return 0;
  return 1 + max(height(node->left), height(node->right));`|
  |`size(Node* node)`|$O(n)$|`if (node == nullptr) return 0;
  return 1 + size(node->left) + size(node->right);`|
  |`find(int x, Node* node)`|$O(n)$|`if (node == nullptr) return nullptr;
  if (node->data == x) return node;
  if (Node* tmp = find(x, node->left)) return tmp;
  return find(x, node->right);`|
]
=== 二叉树遍历的非递归实现
*使用栈模拟递归中的栈帧*

`node`出栈代表控制权移交给`xOrder(node)`，若不压回即代表销毁`xOrder(node)`的栈帧，注意到前序/中序/后序访问分别在控制权第一/二/三次移交给`xOrder(node)`时访问`node`，故只需在`node`第一/二/三次出栈时访问`node`。

前序遍历可看作`visit(node)`后连续调用两个函数的（广义）尾递归，故第一次出栈后访问，依次压入右，左子树，触发尾递归，销毁了`preOrder(node)`的栈帧，新建了`preOrder(node->right)`, `preOrder(node->left)`的栈帧

中序遍历为`visit(node)`后的尾递归，故第一次出栈后先压回并压入左子树，新建`midOrder(node->left)`的栈帧，第二次出栈后访问，并压入右子树，触发尾递归，销毁了`midOrder(node)`的栈帧，新建了`midOrder(node->right)`的栈帧。

后序遍历第一次出栈后压回并压入左子树，新建了`postOrder(node->left)`的栈帧，第二次出栈后压回并压入右子树，新建了`postOrder(node->right)`的栈帧，第三次出栈后访问，销毁`postOrder(node)`的栈帧。

*使用栈进行欧拉遍历*

欧拉遍历本质是左侧优先的DFS，每个结点需要出栈三次，分别代表到达结点的左侧/下侧/右侧，第一次出栈后压回并压入左子树，第二次出栈后压回并压入右子树，第三次出栈后不需要压回。在第一/二/三次出栈时访问即分别对应前序/中序/后序遍历。

== 哈夫曼树与哈夫曼编码
#strategy[构建哈夫曼树][

  执行$n-1$次循环，每次循环内执行：

  从剩余结点中选取权值最小的两个结点，新建一个结点，使该结点的左右儿子为这两个结点，该结点的权值为这两个结点的权值之和。
  从剩余结点中去除这两个结点，并添加该新建的结点。

  #note[][使用小顶堆来维护剩余结点以快速得到权值最小的两个结点。]
]

== 树和森林
=== 树的存储实现
==== 标准形式与广义标准形式
$k$为树的度

标准形式中，每个`Node`维护`data`，长度为$k$的孩子数组

共有$n k - (n - 1) = n (k - 1) + 1$个空指针字段

广义标准形式中，每个`Node`维护`data`，长度为$k$的孩子数组，`parent`

共有$n (k + 1) - 2 (n - 1) = n (k - 1) + 2$个空指针字段


==== 孩子链表示法
每个`Node`维护`data`，孩子链表
==== 孩子兄弟链表示法
每个`Node`维护`data`, `firstSon`, `nextSibling`

`firstSon`负责纵向移动，`nextSibling`负责横向移动

本质是将树表示成二叉树
==== 双亲表示法
每个`Node`维护`data`, `parent`

容易求祖先，不容易求子孙
=== 树的遍历
+ 前序遍历 根 $->$ 第一棵子树 $->$ $dots$ $->$ 最后一棵子树
+ 后序遍历 第一棵子树 $->$ $dots$ $->$ 最后一棵子树 $->$ 根
+ 层序遍历

#proposition[][
  - 孩子兄弟二叉树的前序遍历对应树的前序遍历
  - 孩子兄弟二叉树的中序遍历对应树的后序遍历
  #intuition[][

    处理根的`firstSon`对应处理根的所有子树

    处理根和`firstSon`对应处理根和根的所有子树，也即以根为根结点的子树


    孩子兄弟二叉树的前序遍历

    根 $->$ `firstSon` $->$ `nextSibling`
    #three-line-table[
      |孩子兄弟二叉树|树|
      | ---|--- |
      | 根 $->$ `firstSon`|根 $->$ 所有子树|
      |(根 $->$ `firstSon`) $->$ `nextSibling`| 子树 $->$ 下一棵子树|
    ]
    孩子兄弟二叉树的中序遍历

    `firstSon` $->$ 根 $->$ `nextSibling`
    #three-line-table[
      |孩子兄弟二叉树|树|
      | ---|--- |
      | `firstSon` $->$ 根 |所有子树 $->$ 根|
      |(`firstSon` $->$ 根) $->$ `nextSibling`| 子树 $->$ 下一棵子树|
    ]
  ]
]

#proposition[][
  树的前序+后序可以唯一确定一棵树
]
=== 树，森林和二叉树
前文已经提到孩子兄弟链表示法能将树用二叉树的形式表示

森林也能用二叉树的形式表示，只需认为森林中的每棵树是森林的虚拟根结点的子树，然后用孩子兄弟链表示法从第一棵树的根结点开始表示即可。
= 堆
以小顶堆为例

堆是一棵完全二叉树，堆具有有序性：父结点小于等于子结点

由于堆是完全二叉树，使用数组来存储堆

#intuition[堆的有序性能被快速恢复][

  如果仅仅有一个结点不符合有序性，堆的有序性能被快速恢复

  若该结点过小，上浮即可恢复有序性

  若该结点过大，下沉即可恢复有序性

  上浮和下沉的路径长度不超过树的高度$floor(log_2 n) + 1$，故时间复杂度为$O(log n)$
]


#strategy[上浮][

  若该结点小于父结点，交换父结点和该结点，直到该结点大于等于它的父结点
]

#strategy[下沉][

  若该结点大于任意一个子结点，交换该结点和较小的子结点，直到该结点小于等于任意一个它的子结点
]

#strategy[入队][

  新结点插入树的末尾，上浮该结点
  #intuition[][

    只有新结点可能不符合有序性，且由于其位于最后一层，仅有可能过小，故上浮该结点即可

    完全二叉树的末尾增加一结点仍是完全二叉树，且上浮过程中树的形状不变，故入队后仍是完全二叉树
  ]
]

#strategy[出队][

  根结点出队后将树的末尾元素移动到根结点位置，下沉根结点
  #intuition[][

    只有新的根结点可能不符合有序性，且由于其位于第一层，仅有可能过大，故下沉该结点即可

    完全二叉树的末尾减少一结点仍是完全二叉树，且下沉过程中树的形状不变，故出队后仍是完全二叉树
  ]
]

#intuition[建堆][

  给定任意一个完全二叉树，能在$O(n)$时间内将其调整为堆

  该问题可以被递归地解决：

  如果左右子树都已经是堆，那么此时仅有根结点可能不符合有序性，下沉根结点即可。因此只需先递归地调整左子树，右子树为堆，再下沉根结点即可。

  该解决方案也可有非递归实现。将上述递归过程展开成循环，即为自底向上地下沉每一个非叶子结点。处理每个结点时，其左右子树都已经是堆，故在这个子树内只有该结点不符合有序性。下沉该结点后以该结点为根结点的子树就成为了堆。

  接下来分析建堆的时间复杂度，对于一棵高度为$h+1$的满二叉树，其有$2^(h + 1) - 1$个结点，定义每个结点的高度为距离最底层的距离（叶结点高度为$0$），建堆的最坏时间即所有结点的高度和
  $ sum_(i = 0)^h 2^i (h - i) = n - h - 1 $
  故时间复杂度为$O(n)$
]
