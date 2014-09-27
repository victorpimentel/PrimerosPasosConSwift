class Person {
  var name = "Víctor"

  var initial: Character {
      return first(name)!
  }
}

let yo = Person()
yo.initial