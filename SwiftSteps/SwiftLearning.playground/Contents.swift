  
import UIKit
//operator cheatsheat
  
  var assignment = "="
  var math = "+, -, *, /"
  var mod = "%"
  
  var compound = "+=, -=, *="
  var comparison = "==, !=, >, <, >=, <="
  
  var logic = "!, &&, ||"

  var closedRange = "value1...value2"
  var halfOpenRange = "value1..<value2"

// Declaring mutable vs immutable
  var mutable = "can change"
  let immutable = "can't change"
  
// Swift does infered typed
  var explicit: String = "This is explicit"
  var inferred = "This is an inferred string"
  
// Casting an variable
  var anInt: Int = 1
  
  var floatFromInt = Float(anInt)
  
// printing with variables
  var theVariable = "this is the message"
  print("Look I am a weird printf \"\(theVariable)\"")

// Array Syntax
  var arrayOfFloats = [Float]()
  var AnotherFloatArray: [Float] = []
  var placeHolderArray: [Float]
  var inferredArray = ["testing", "testing2"]
  
  inferredArray.count
  inferredArray.capacity
  inferredArray.isEmpty
  
  inferredArray[0] = "New Item"
  inferredArray.append("Appended Item")
  inferredArray += ["Shorthand Appended Item"]
  inferredArray.insert("Inserted Item", at: 2)
  
  inferredArray
  
  var itemAtIndex = inferredArray[1]
  var itemAtRange = inferredArray[1...2]
  
//  Dictionary Syntax
  var emptyDict = [Int: String]()
  var emptyDictAgain: [Int: String] = [:]
  var placeholderDict: [Int: String]
  
  var inferredDict = ["Key 1": "Value 1", "Key 2": "Value 2"]
  
  var dictValues = [String](inferredDict.values)
  inferredDict["Key 3"] = "Value 3"
  inferredDict.updateValue("Updated Value", forKey: "Key 3")
  inferredDict.removeValue(forKey: "Key 3")
  
//  Tuples
  var basicTuple = (2, 3)
  var descriptiveTuple = (playerLives: 2, playerName: "Eric")
  
  var firstValue = descriptiveTuple.0
  var (first, second) = descriptiveTuple
  first
  second
  
  var ourTuples: (playerLives:Int, playerName: String)
  ourTuples.playerName = "John"
  ourTuples.playerLives = 3
  
// Enums
  enum PlayerState_Basic {
    case Alive, KO, Unknown
  }
  
  var basicState  = PlayerState_Basic.Alive
  basicState.hashValue
  
  enum PlayerState_RawValues: Int {
    case Alive = 1, KO = 2, Unknown = 3
  }
  
  var rawValueEnum = PlayerState_RawValues.KO
  rawValueEnum.hashValue
  rawValueEnum.rawValue
  
  var rawInitalializedState = PlayerState_RawValues (rawValue: 3)
  
//  Associated Values
  enum PlayerState_AssociatedValues {
    case Alive
    case KO(restartLevel: Int)
    case Unknown(debug: String)
  }

//  If Statements
  var myAge = 27
  var drivingAge = 16
  
  if myAge >= drivingAge {
    print("yes")
  } else {
    print("no")
  }
  
//  For Loop
  for i in 1...3 {
    print(i)
  }
  
  var itemArray = [1,2,3]
  for i in itemArray{
    print(i)
  }
  
  var levelDict = ["Level 1": 1, "Level 2": 2, "Level 3": 3]
  for (name, number) in levelDict{
    print("\(name) \(number)")
  }
  
  var firstName = "Eric"
  for i in firstName.characters {
    if i == "i"{
        continue
    } else if i == "c"{
        break
    }
    print (i)
  }
  
//  While Loop
  var alive = true
  var playerLives = 3
  
  while alive {
    playerLives -= 1
    if playerLives <= 0 {
        alive = false
    }
    print("Still Alive")
  }
  
//  Switch Statement
  var carLives = 3
  
  switch carLives {
  case 1:
    print("doing good")
  case 2...3:
    print("okay okay")
  default:
    print("dead")
  }
 
  var compoundCaseCheck = "a"
  switch compoundCaseCheck {
  case "a","A":
    print("found")
  default:
    print("not found")
  }
  
  enum PlayerState {
    case Alive
    case KO(restartLevel: Int)
    
    var message: String {
        switch self {
        case .Alive:
            return "Phew, still alive"
        case .KO(let restartLevel):
            return "Restart at \(restartLevel)"
        }
    }
  }
  
  var playerState = PlayerState.KO(restartLevel: 2)
  playerState.message
  
//  Optionals - lets us deal with nil values effeciently
  var ourFirstOptional: String? = "Optional string"
  var secondOptional: String?
  var emptyOptional: [String]? = []
  ourFirstOptional = nil
  
  var wrappedOptional: Int? = 3
  print(wrappedOptional)
  if let unwrappedOptional = wrappedOptional{
    print("unwrapped Optional == \(unwrappedOptional)")
    print("unwrapped Optional Shorthand force unwrapped == \(wrappedOptional!)")
  }
  
  var optional1: Int? = 2
  var optional2: Int? = 3
  
  if let optionalA = optional1, let optionalB = optional2 {
    print("Working Smarter, not Harder")
  }
  
//  Guard Statement
  var userExists: Bool? = true
  var emailText: String? = ""
  var passwordText: String? = ""
  
  guard let hasUser = userExists else{
    print("YOU SHALL NOT PASS")
    fatalError()
  }
  
  guard let email = emailText, let password = passwordText else {
    print("YOU SHALL ENTER EMAIL AND PASSWORD")
    fatalError()
  }
  
//  Functions
  
  func CurrentDate() {
    print("Today")
  }
  
  CurrentDate()
  
  func CurrentDateWithMessage(message: String) {
    print("hi \(message)")
  }
  CurrentDateWithMessage(message: "banana")
  
  func CurrentDateWithReturn(message: String) -> String {
    return "true baby"
  }
  print(CurrentDateWithReturn(message: "o"))
  
  func AllTogetherNow(name: String, codingHours: Int, isTired: Bool? = true) -> String {
    let output = "\(name) has been coding for \(codingHours). Tired yet? \(isTired!)"
    return output
  }
  print(AllTogetherNow(name: "Eric", codingHours: 10))
  
// Variadic Parameter
  func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
  }
  arithmeticMean(1, 2, 3, 4, 5, 8, 9)

//  Function type as return type
  func stepForward(_ input: Int) -> Int {
    return input + 1
  }
  func stepBackward(_ input: Int) -> Int {
    return input - 1
  }
  func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
  }
  var currentValue = -4
  let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
  while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
  }
  print("0...")
  
//  Function in Function
  func HelloWorld(name: String)->String{
    return "Hello \(name)"
  }
  
  func FunctionAsParameter(HelloWorldFunctionParamater: (String)->String, name: String){
    print(HelloWorldFunctionParamater(name))
  }

  FunctionAsParameter(HelloWorldFunctionParamater: HelloWorld, name: "What happens")
  
//  Closures
  var closureDeclaration: () -> () = {}
  var basicClosure = { (stringParameter: String) -> Void in
    print(stringParameter)
  }
  basicClosure("Hello Closure")
  
  var shortHandClosure: (String) -> String = {message in
    return"\(message) Swift?"
  }
  
  shortHandClosure("Hello")

  func ClosureAsParameter(closure: (String) -> Void) {
    closure("Closure Parameter")
  }

  ClosureAsParameter{(message) in print(message)}
  
//  Type Aliasing
  typealias weirdTuple = (Int,String,Bool)
  typealias ClosureAlias = (String) -> Void
  
  func aliasAsParameter(closureAlias: ClosureAlias){
    closureAlias("I'm confused")
  }

  aliasAsParameter{(message) in print(message)}
