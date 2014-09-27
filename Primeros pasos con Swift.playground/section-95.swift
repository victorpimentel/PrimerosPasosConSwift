sorted(unsortedList, {
  (first: Int, second: Int) -> Bool in
  return first > second
})

sorted(unsortedList, {
  first, second in
  return first > second
})

sorted(unsortedList) {
    (first: Int, second: Int) -> Bool in
    return first > second
}

sorted(unsortedList) {
    first, second in
    return first > second
}

sorted(unsortedList) {
    return $0 > $1
}

sorted(unsortedList) {
    $0 > $1
}

sorted(unsortedList, >)