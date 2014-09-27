func doAwesomeStuff() {
}

func doAwesomeStuff() -> Int {
	var total = 0
	for i in 1...5 {
		total += i
	}
	return total
}

func doAwesomeStuff(catName: String, doItFast:Bool = true) -> Int {
  if doItFast {
    return catName.hashValue
  } else {
    return countElements(catName)
  }
}