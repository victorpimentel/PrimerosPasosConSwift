# Primeros Pasos con Swift

Con este playground intentaremos echarle un vistazo al nuevo lenguaje de programación de Apple partiendo desde el punto de vista de un programador de Objective C, pero intentando explicar los nuevos conceptos de manera más generalista.

Como lenguaje en general, Swift intenta traer a la comunidad funcionalidades modernas exploradas en los últimos años (o décadas) en otros lenguajes, y aumentar la facilidad para escribir código seguro, de ahí la distancia que de manera voluntaria toma de C. A la vez, intenta seguir una sintaxis limpia, elegante y clara.

Swift se postula como un reemplazo a Objective C como lenguaje de programación preferente de las plataformas de Apple. Esta realidad causa algunas ásperezas al tratar con las APIs tradicionales como Cocoa, que no están pensadas o adaptadas de manera óptima para Swift.

Los playgrounds son una herramienta integrada en Xcode muy sencilla y muy útil a la hora de aprender. Incluso cuando ya estemos familiarizados con el lenguaje, son muy útiles para experimentar con nuevos conceptos o nuevas APIs. Sin duda es una de las cosas más espectaculares respecto a Objective C.

## Variables

### Inferencia de tipos

En Swift una variable se declara de la siguiente manera:

```swift
var firstCat: String = "Félix"
```

Normalmente no escribiremos el tipo de lo que queremos tener, la mayor parte del tiempo aprovecharemos la inferencia de tipos que Swift implementa, quedando mucho más natural:

```swift
var secondCat = "😺"
```

Swift automáticamente detecta en tiempo de compilación que la variable es un String y refuerza ese tipado, así que no podremos más adelante tratarlo como, por ejemplo, un entero:

```swift
//! secondCat = 42
```

Esta inferencia funciona en la mayoría de los casos: literales, llamadas a funciones, llamadas a inicializadores, etc.

```swift
var allCats = [firstCat, secondCat, "Isidoro"]

var catCount = allCats.count
```

Truco: en los casos donde no tengamos claro qué tipo se está infiriendo, Alt + Click sobre el texto nos sirve para revisar el tipo de una variable o expresión.

### Mutabilidad

Si declaramos una variable con la palabra clave var, podremos modificar su valor cuántas veces queramos, pero si la declaramos con la palabra let no se podrá redefinir. Es decir, en Swift utilizamos let para declarar constantes:

```swift
let friendsCount = 5

//! friendsCount = 3
```

Esto funciona en structs (los tipos básicos están definidos en el propio lenguaje como structs), enumerados y tuplas, pero no en clases: podremos modificar sus valores internos pero no podremos asignarle otro objeto a esa constante. Más adelante hablaremos más sobre estos tipos compuestos.

Estos modificadores funcionan en todos los contextos, así que los veremos muy a menudo: para definir variables globales, variables locales, propiedades de clases, funciones/bloques, etc.

## Funciones

Conocer la estructura de una función es básico en Swift, dado que exactamente la misma sintaxis se usa en funciones globales, lambdas (bloques) y métodos de una clase.

```swift
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
```

Swift soporta sobrecarga de funciones, y en tiempo de compilación elegirá la versión de la función más adecuada al contexto.

El tipo de retorno por defecto es Void (al contrario que otros lenguajes como C, donde es int). Si ese es el caso de nuestra función no hace falta especificarlo.

Los parámetros de entrada de la función deben especificar el tipo, y pueden definirse como opcionales si definimos un valor por defecto.

Para llamar a una función decimos adiós a los corchetes y utilizamos una forma mucho más familiar a otros lenguajes:

```swift
//! doAwesomeStuff()

//! let awesomeStuff = doAwesomeStuff()

var awesomeStuffInt: Int = doAwesomeStuff()

let awesomeStuffVoid: Void = doAwesomeStuff()

var awesomeStuff = doAwesomeStuff("Hello Kitty")
awesomeStuff = doAwesomeStuff("Hello Kitty", doItFast: false)
```

En las funciones los parámetros pueden ser nombrados o no. Las reglas son relativamente complejas, principalmente para ser compatible con las APIs de Objective C como Cocoa.

Por defecto los parámetros no tienen nombre, salvo que sean opcionales como en el caso anterior.

```swift
func printCat(catName: String, catSurname: String) {
  println(catName + catSurname)
}

printCat("😼", "🇪🇸")
```

Pero se puede optar por añadir un nombre externo a los parámetros, que puede ser independiente del interno:

```swift
func printCat2(name catName: String) {
  println(catName)
}

printCat2(name: "😽")
```

Si los nombre son iguales, como atajo podemos usar #:

```swift
func printCat3(#catName: String) {
  println(catName)
}

printCat3(catName: "Menino")
```

Las reglas para métodos de clase son distintas, como veremos más adelante.

# Tipos de datos compuestos

Swift tiene diversos tipos de datos compuestos, pero al contrario que en otros lenguajes, todos los tipos son de primera clase. De hecho, una de las dudas que tendremos al tener que crear un modelo será qué tipo es el más adecuado.

## Enumerados

Los enumerados de Swift son muy potentes respecto a otros lenguajes. En el caso más básico su aspecto es:

```swift
enum CoolAnimals {
  case Cat
  case Pig
}
```

A partir de ahora podemos definir variables de este tipo, utilizando la inferencia de tipos para hacer más ameno trabajar con ellas:

```swift
let coolAnimal = CoolAnimals.Cat

var coolAnimal2: CoolAnimals

coolAnimal2 = .Pig
```

Podemos añadir un valor a cada uno de los valores si tipamos el enumerado:

```swift
enum CoolAnimals2: String {
  case Cat = "🙀"
  case Pig = "🐷"
}

CoolAnimals2.Cat.toRaw()
```

Por último también podemos enlazar valores dependiente de cada tipo por cada variable, pero para acceder a él tendremos que utilizar switches:

```swift
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
```

## Estructuras

Las estructuras de Swift también son increíblemente potentes. De hecho, los tipos básicos como String o Int son estructuras, adaptando interesantes propiedades.

```swift
struct Payment {
  var amount = 0.0
  var currency: String
}
```

Automáticamente las estructuras generan un constructor con el orden en el que se han definido sus propiedades.

```swift
var firstPayment = Payment(amount: 25, currency: "EUR")
```

Las estructuras pueden tener también métodos, y también pueden ser extendidas (útil para extender los tipos comunes):

```swift
extension Payment {
  func prettyPrint() -> String {
    return "\(currency) \(amount)"
  }
}

firstPayment.prettyPrint()
```

La semántica de mutabilidad está presente en las estructuras, de tal manera que no podremos modificar sus datos si las definimos como constantes:

```swift
firstPayment.amount = 35
firstPayment.prettyPrint()

let staticPayment = Payment(amount: 39, currency: "USD")

//! staticPayment.amount = 35
```

Los métodos tienen permitido modificar los valores internos de una estructura, pero deben estar marcados con la palabra clave mutating para especificar su comportamiento. Estos métodos no pueden usarse en constantes.

```swift
extension Payment {
  mutating func doubleIt() {
    amount *= 2
  }
}

firstPayment.doubleIt()
firstPayment.prettyPrint()
//! staticPayment.doubleIt()
```

## Clases

Las clases siguen una estructura muy similar

```swift
class Cashier {
  var name = "Unnamed"

  func process(payment: Payment, inCash: Bool) {
      println(payment)
  }
}
```

Como vemos, la semántica de mutabilidad es diferente, en constantes podemos modificar un modelo pero no asignar otro objeto.

```swift
let firstCashier = Cashier()

firstCashier.name = "Paco"
```

También el constructor generado por defecto es distinto a las estructuras, simplemente tenemos un constructor vacío.

Respecto a Objective C, podemos notar varios cambios:

- No hay distinción de header/implementation (.h/.m)
- (Normalmente) no hace falta heredad de NSObject.
- En general es mucho más sucinto.

Para llamar a métodos las reglas también son distintas a las funciones normales, aunque sigan manteniendo la misma sintaxis:

```swift
firstCashier.process(firstPayment, inCash: true)
```

Por defecto, el primer parámetro no tiene nombre y el resto sí. Si quisiéramos borrar el nombre de cualquiera de los parámetros adicionales, podríamos utilizar el símbolo _.

Las clases, al contrario que las estructuras, admiten herencia, así que podríamos crear una nueva clase que extienda de la primera. Todos los métodos que se sobreescriban deben estar marcados con la palabra clave override:

```swift
class FastCashier: Cashier {
  func process(payment: Payment) {
    super.process(payment, inCash: false)
  }

  override func process(payment: Payment, inCash: Bool) {
    super.process(payment, inCash: false)
  }
}

let fastCashier = FastCashier()
```

Las clases pueden incluir constructores, que deben cumplir ciertas reglas para asegurar la correcta inicialización de una clase. Son relativamente complejas, así que intentaremos simplificar centrándonos en los inicializadores más comunes (required, no convenience):

- Un constructor debe primero asignar un valor a todas sus variables (luego matizaremos con los opcionales).
- Luego debe llamar a un constructor de la clase padre.
- Al final puede hacer cualquier trabajo adicional que crea oportuno.

```swift
class Cashier2 {
  var name: String

  func process(payment: Payment, inCash: Bool) {
    println(payment)
  }

  init(name: String) {
    self.name = name
  }
}

let secondCashier = Cashier2(name: "Maria")

class FastCashier2: Cashier2 {
  var seniority: Int

  init(seniority: Int) {
    self.seniority = seniority
    super.init(name: "Apu")
    println(self.name)
  }

  override func process(payment: Payment, inCash: Bool) {
    super.process(payment, inCash: false)
  }

  func process(payment: Payment) {
    process(payment, inCash: false)
  }
}

let fastSecondCashier = FastCashier2(seniority: 4)
```

También podemos generar propiedades computadas:

```swift
class Person {
  var name = "Víctor"

  var initial: Character {
      return first(name)!
  }
}

let yo = Person()
yo.initial
```

Estas propiedades pueden ser de lectura o de lectura y escritura:

```swift
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
```

Además podemos añadir observadores a las propiedades que se ejecutarán antes o después de cambiarlas:

```swift
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
```

## Protocols

Los protocolos definen un contrato formal sobre una particular tarea sin definir cómo debería estar implementado (como las interfaces en lenguajes como Java).

En Swift, tanto las clases como las estructuras y los enumerados pueden conformar un protocolo.

```swift
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
```

Podemos también conformar protocolos en extensiones.

```swift
extension Cashier: Describable {
  func description() -> String {
    return "I'm cashier " + name
  }
}

firstCashier.description()
```

## Tuplas

El tipo de datos más básico son las tuplas, una simple combinación de otros valores. Se definen así

```swift
var myFirstTuple: (Int, Double, String)
```

La forma literal es muy simple:

```swift
let mySecondTuple = (42, "Wait a little")
```

Para acceder a los valores de una tupla podemos acceder a sus índices numéricos:

```swift
mySecondTuple.0
mySecondTuple.1
```

Pero podemos definir etiquetas para explicar su contenido:

```swift
let myThirdTuple = (code: 42, message: "Wait a little")

myThirdTuple.code
myThirdTuple.message
```

Sí vamos a reusar una tupla en particular, podemos definir un tipo con los parámetros exactos de la tupla:

```swift
typealias ErrorTuple = (code: Int, message: String)
```

Así será más fácil referirse a ellas en funciones y otros contextos:

```swift
var myGreatTuple: ErrorTuple

func whereIsMyError(input: String) -> (code: Int, message: String) {
  return (42, input)
}

func whereIsMyError2(input: String) -> ErrorTuple {
  return (42, input)
}
```

Lamentablemente esta clase de tipos no es compatible con las APIs de Objective C, así que cualquier código escrito con esta clase es estructuras no será accesible fuera de Swift.

### ¿Qué elegir?

No es una tarea fácil decidir qué tipo debemos usar a la hora de modelar, así que :

- Las tuplas son las más rápidas de definir, pero las menos extensibles.
- Las estructuras son muy potentes y bastante rápidas de definir, aparte de soportar la semántica de mutabilidad. En su contra está el no poder heredar, solo extender.
- Las clases son las menos rápidas de definir y no soportan la semántica de mutabilidad. Sin embargo la posibilidad de extensión y su enorme presencia en las APIs de Cocoa las hacen la única solución para muchos problemas.
- Los enumerados tienen un ámbito distinto al del resto de estructuras de datos, pero los datos enlazados pueden ampliar su uso.

También habría que tener en cuenta el aspecto de la memoria: las clases son pasadas por referencia, mientras que el resto son pasados por valor. Eso significa, entre otras cosas, que si pasamos una estructura a una función y la modificamos dentro de la función, esos cambios no serán visibles por quién llamó originalmente a esa función.

## Opcionales

En Objective C y otros lenguajes cualquier variables que pueda contener un objeto puede ser nullable. Esto causa null pointer exceptions en algunos lenguajes y en Objective C puede llevar a errores muy sutiles (aunque muy poco frecuentes en el día a día). En otros lenguajes existe la posibilidad de marcar un variable como nullable, anotando explícitamente que puede contener el valor null.

En Swift por defecto una variable no puede contener el valor null (o no estar asignada), en caso contrario ni siquiera compilará:

```swift
var nonOptional = "Hey there"

//! nonOptional = nil
```

Para modelar el concepto de nullable Apple ha introducido los opcionales, que no es más que un enumerado que modela dos estados: tener contenido y no tener contenido.

```swift
var firstOptional = Optional("Hey there")

firstOptional = Optional()

firstOptional = nil

firstOptional = "Hey there"
```

Para facilitar el trabajo con los opcionales, el lenguaje introduce el símbolo ? para definir un opcional de manera más sucinta:

```swift
var secondOptional: String?

secondOptional = "Hey there"
```

Vemos que automáticamente (gracias a unos protocolos que nuestras clases/estructuras también pueden implementar) la asignación de valores es muy intuitiva. Quizás demasiado, ya que podemos perder de vista lo que realmente hay por debajo.

Sin embargo, para acceder a su contenido tenemos explícitamente que tratar con los dos posibles casos, no podemos usarlos directamente:

```swift
//! secondOptional + " :("

if let secondOptional = secondOptional {
  secondOptional + " :)"
}
```

Podemos pensar que los opcionales son como envoltorios de caramelos: pueden contener o no un caramelo, pero para saber si lo tienen tenemos que abrirlo antes.

Para evitar este baile de condicionales, en los casos en los que estemos 100% seguros podemos unwrappear directamente el valor con el operador !. Hay que tener mucho cuidado con ese operador porque si el valor interno es nil, crasheará la aplicación en tiempo de ejecución.

```swift
secondOptional! + " :|"
firstOptional! + " :S"
```

Por último también tenemos otra opción que veremos lamentablemente muy a menudo: los implicitly unwrapped optionals. Estas son variables definidas con el símbolo ! en vez de ?, y se comportan exactamente igual que una variable normal, pero si contienen nil crashean al intentar usarlos.

```swift
var implicitlyUnwrappedHell: String! = "Let's roll the dice"

implicitlyUnwrappedHell + " Yeah!"
implicitlyUnwrappedHell = nil
//! implicitlyUnwrappedHell + " Noooooo!"
```

Si queremos acceder a un método de un valor que pueda ser nulo de manera simple, podemos utilizar:

```swift
var mayBeNil: String?

mayBeNil?.startIndex
```

Aunque a primera vista no parezca muy complicado, el concepto de opcional será probablemente uno de los que mayores dolores de cabeza nos cause, al estar impregnado por toda la API de Cocoa. Encima la API de Cocoa no está 100% auditada en estos momentos, así que veremos los opcionales implícitamente desenvueltos por todos lados.

Por la inevitabilidad de lidiar con todos estos problemas, es imprescindible saberse manejar bien con los opcionales.

## Genéricos

Este tema da para hablar mucho, simplemente vamos a repasar lo mínimo indispensable para entender este concepto en Swift.

Los genéricos son una herramienta increíblemente potente que nos ayudará a reutilizar código sin perder la seguridad que nos da el tipado fuerte. 

Imaginemos que queremos construir una pila (stack) que guarde enteros:

```swift
struct IntStack {
  var items = [Int]()

  mutating func push(item: Int) {
    items.append(item)
  }

  mutating func pop() -> Int {
    return items.removeLast()
  }
}

var intStack = IntStack()

intStack.push(1)
intStack.push(2)
intStack.push(3)

intStack.pop()
intStack.pop()
intStack.pop()
```

Funciona como esperamos, pero esta estructura es poco reutilizable. ¿Y si ahora queremos guardar Strings o Cashiers? En principio todo el código que hemos escrito no tiene que ver específicamente con enteros, estamos simplemente añadiendo y quitando elementos. Que sean enteros o cualquier otro tipo es un simple detalle concreto.

Los genéricos nos permiten abstraer esa concreción y ampliar la utilidad del código que escribimos. Una versión genéricas sería similar a:

```swift
struct Stack<ContainedType> {
  var items = [ContainedType]()

  mutating func push(item: ContainedType) {
    items.append(item)
  }

  mutating func pop() -> ContainedType {
    return items.removeLast()
  }
}

var intGenericStack = Stack<Int>()

intGenericStack.push(1)
intGenericStack.push(2)
intGenericStack.push(3)

intGenericStack.pop()
intGenericStack.pop()
intGenericStack.pop()
```

Funciona exactamente igual, simplemente hemos tenido que especificar que queríamos una pila de enteros al crear el objeto. Si quisieramos hacer una pila de Cashiers:

```swift
var cashierStack = Stack<Cashier>()

cashierStack.push(firstCashier)
//! cashierStack.push(2)
cashierStack.push(fastCashier)

cashierStack.pop()
cashierStack.pop()
```

Sin tener que escribir otra vez el algoritmo, hemos podido reutilizar el código sin perder ninguna ventaja del tipado fuerte.

Este concepto es importante porque en Swift puro, varias de las clases más usadas están basadas en genéricos, como los arrays o los diccionarios, colecciones que por defecto solo admiten elementos del mismo tipo (al contrario que en Objective C):

```swift
var myStringArray: [String]
var myStringArray2: Array<String>
let myIntArray = [1, 2, 3]
//! let myWrongArray = [1, "wat", 3]

let myIntToDoubleDictionary = Dictionary<Int, Double>()
let myIntToDoubleDictionary2 = [Int: Double]()
let myIntToStringDictionary = [1: "one", 2: "two"]
//! let myWrongDictionary = [1: 5, 2: "two"]
```

Por debajo Swift directamente nos hará un puente a NSArray y NSDictionary, intentando mantener esa seguridad de tipado (al igual que con NSString).

## Bloques (Closures)

Las funciones son también ciudadanos de primera en Swift: se pueden asignar a variables, pasar como parámetro, etc.

La función sorted recibe una colección y una función que sepa distinguir el orden entre dos elementos de esa colección. Podemos pasarle directamente una función que creemos para tal efecto:

```swift
var unsortedList = [3, 1, 2]

func greaterThan(first: Int, second: Int) -> Bool {
  return first > second
}

sorted(unsortedList, greaterThan)
```

Quizás no nos interese o nos resulte tedioso crear una función adicional. Swift nos ofrece la opción de definirla directamente en línea de diferentes maneras:

```swift
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
```

Los bloques de Objective C son automáticamente convertidos a estas funciones sin necesidad de que el programador especifique nada. Esto significa que las mismas implicaciones de gestión de memoria de los bloques aplican aquí también.

## Casting e interoperabilidad con Objective C

Si queremos castear un objeto a otro tipo, podemos utilizar los operadores as y as?:

```swift
var surprise: Any
surprise = "Not any object"
//! surprise.startIndex

let surprisedString = surprise as String
surprisedString.startIndex
let surprisedStringOptional = surprise as? String
surprisedStringOptional?.startIndex
```

Swift automáticamente nos realizará un casting de tipos de Foundation a los tipos nativos:

- NSArray <-> Array
- NSDictionary <-> Dictionary
- NSString <-> String
- int <-> Int
- float <-> Float
- double <-> Double

Este casting automático solo sucede en ciertas ocasiones, por ejemplo al traducir funciones de Objective C. Si queremos utilizar explícitamente un tipo nativo, deberemos especificarlo al crear la variable.

```swift
import Foundation

let myString = "I'm native"
let myNSString: NSString = "I'm native"
```

En ciertas ocasiones tendremos que traducir a un tipo específico de Objective C y el casting (esperemos que por limitaciones actuales) no se puede hacer automáticamente, sino que necesitamos utilizar inicializadores.

```swift
import UIKit

let myDouble = 5.2

//! let myCGFloat = myDouble as CGFloat

let myCGFloat = CGFloat(myDouble)
```

Esta traducción de tipos también incluye enumerados, que quedan mucho más claros y potentes en Swift.

Por último, si queremos acceder a los tipos básicos de C, también lo podremos hacer, normalmente poniendo una C delante.

## Cosas Avanzadas

- Poderosísimos switches: potentes matches, también para genéricos.
- Sobrecarga de operadores: puedes sobreescribir operadores como los aritméticos o crear operadores nuevos.
- Rangos.
- Inicializadores requeridos/de conveniencia.
- Protocolos para convertir literales a tipos propios.

## Recursos

### Imprescindibles

- [The Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/): Libro básico oficial y documentación online.
- [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/): Trabajar con APIs de Cocoa y mezclar código Objective C y Swift.
- [Swift In Flux](https://github.com/ksm/SwiftInFlux): Documentación beta a beta.
- [Swift Blog](https://developer.apple.com/swift/blog/): Blog oficial de Apple.
- [NSHipster](http://nshipster.com/): Las mejores APIs de Swift y Objective C.
- [Objc.io sobre Swift](http://www.objc.io/issue-16/): Revista online con excelentes artículos sobre Swift.

### Blogs personales

- [Airspeed Velocity](http://airspeedvelocity.net/)
- [Mike Ash](http://www.mikeash.com/pyblog/)
- [Russ Bishop](http://www.russbishop.net/)
- [Alejandro Salazar](http://nomothetis.svbtle.com/)
- [Giant Robots Smashing Into Other Giant Robots](http://robots.thoughtbot.com/)
- [David Owens](http://owensd.io/)
- [Rob Napier](http://robnapier.net/)

## Repo

https://github.com/victorpimentel/PrimerosPasosConSwift

## ¡Estamos contratando!

Si quieres trabajar en pleno centro de Madrid en el fantástico equipo de Tuenti haciendo iOS, mándame un email a:

[vpimentel@tuenti.com](mailto:vpimentel@tuenti.com)

