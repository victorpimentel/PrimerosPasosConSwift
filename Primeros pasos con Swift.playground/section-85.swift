struct IntStack {
  var items = [Int]()

  mutating func push(item: Int) {
    items.append(item)
  }

  mutating func pop() -> Int {
    return items.removeLast()
  }
}

var intStack = IntStack()

intStack.push(1)
intStack.push(2)
intStack.push(3)

intStack.pop()
intStack.pop()
intStack.pop()