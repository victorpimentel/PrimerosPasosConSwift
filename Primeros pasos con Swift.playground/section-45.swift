class FastCashier: Cashier {
  func process(payment: Payment) {
    super.process(payment, inCash: false)
  }

  override func process(payment: Payment, inCash: Bool) {
    super.process(payment, inCash: false)
  }
}

let fastCashier = FastCashier()