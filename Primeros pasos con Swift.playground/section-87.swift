struct Stack<ContainedType> {
  var items = [ContainedType]()

  mutating func push(item: ContainedType) {
    items.append(item)
  }

  mutating func pop() -> ContainedType {
    return items.removeLast()
  }
}

var intGenericStack = Stack<Int>()

intGenericStack.push(1)
intGenericStack.push(2)
intGenericStack.push(3)

intGenericStack.pop()
intGenericStack.pop()
intGenericStack.pop()