extension Payment {
  mutating func doubleIt() {
    amount *= 2
  }
}

firstPayment.doubleIt()
firstPayment.prettyPrint()
//! staticPayment.doubleIt()