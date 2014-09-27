class Person2 {
  var name = "Víctor"

  var initial: Character {
    get {
        return first(name)!
    }
    set {
        name = String(newValue) + name
    }
  }
}

let yo2 = Person2()

yo2.initial
yo2.initial = "B"