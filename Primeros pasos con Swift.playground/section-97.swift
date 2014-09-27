var surprise: Any
surprise = "Not any object"
//! surprise.startIndex

let surprisedString = surprise as String
surprisedString.startIndex
let surprisedStringOptional = surprise as? String
surprisedStringOptional?.startIndex