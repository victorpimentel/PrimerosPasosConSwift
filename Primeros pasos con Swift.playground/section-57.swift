extension Cashier: Describable {
  func description() -> String {
    return "I'm cashier " + name
  }
}

firstCashier.description()