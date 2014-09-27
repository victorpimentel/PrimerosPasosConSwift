protocol Describable {
  func description() -> String
}

class Cesar: Describable {
  func description() -> String {
    return "I'm awesome"
  }
}

enum Currency: String, Describable {
  case Euro = "EUR"
  case Dollar = "USD"

  func description() -> String {
    return "My symbol is " + toRaw()
  }
}