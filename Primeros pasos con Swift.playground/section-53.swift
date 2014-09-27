class Person3 {
  var name: String = "Víctor" {
    willSet {
        println("I'll be " + newValue)
    }
    didSet {
        println("I was " + oldValue)
    }
  }

  var initial: Character {
    get {
        return first(name)!
    }
    set {
        name = String(newValue) + name
    }
  }
}

let yo3 = Person2()

yo3.initial
yo3.initial = "B"
yo3.name = "Victoria"