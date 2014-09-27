extension Payment {
  func prettyPrint() -> String {
    return "\(currency) \(amount)"
  }
}

firstPayment.prettyPrint()