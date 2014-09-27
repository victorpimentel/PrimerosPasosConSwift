var myGreatTuple: ErrorTuple

func whereIsMyError(input: String) -> (code: Int, message: String) {
  return (42, input)
}

func whereIsMyError2(input: String) -> ErrorTuple {
  return (42, input)
}