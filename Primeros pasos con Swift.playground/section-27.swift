enum CoolAnimals3 {
  case Cat(name: String)
  case Pig
}

let coolAnimal3 = CoolAnimals3.Cat(name: "Mordisquitos")

switch (coolAnimal3) {
  case .Pig:
    println("Unnamed pig")
  case .Cat(let name):
    println(name)
}