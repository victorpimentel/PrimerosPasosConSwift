class Cashier2 {
  var name: String

  func process(payment: Payment, inCash: Bool) {
    println(payment)
  }

  init(name: String) {
    self.name = name
  }
}

let secondCashier = Cashier2(name: "Maria")

class FastCashier2: Cashier2 {
  var seniority: Int

  init(seniority: Int) {
    self.seniority = seniority
    super.init(name: "Apu")
    println(self.name)
  }

  override func process(payment: Payment, inCash: Bool) {
    super.process(payment, inCash: false)
  }

  func process(payment: Payment) {
    process(payment, inCash: false)
  }
}

let fastSecondCashier = FastCashier2(seniority: 4)