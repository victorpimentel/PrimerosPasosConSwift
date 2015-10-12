//: # Primeros Pasos con Swift
//:
//: Con este playground intentaremos echarle un vistazo al nuevo lenguaje de programación de Apple partiendo desde el punto de vista de un programador de Objective C, pero intentando explicar los nuevos conceptos de manera más generalista.
//:
//: Como lenguaje en general, Swift intenta traer a la comunidad funcionalidades modernas exploradas en los últimos años (o décadas) en otros lenguajes, y aumentar la facilidad para escribir código seguro, de ahí la distancia que de manera voluntaria toma de C. A la vez, intenta seguir una sintaxis limpia, elegante y clara.
//:
//: Swift se postula como un reemplazo a Objective C como lenguaje de programación preferente de las plataformas de Apple. Esta realidad causa algunas asperezas al tratar con las APIs tradicionales como Cocoa que no están pensadas o adaptadas de manera óptima para Swift.
//:
//: Los playgrounds son una herramienta integrada en Xcode muy sencilla y muy útil a la hora de aprender. Incluso cuando ya estemos familiarizados con el lenguaje, son muy útiles para experimentar con nuevos conceptos o nuevas APIs. Sin duda es una de las cosas más espectaculares respecto a Objective C.
//:
//: ---
//:
//: ## Variables
//:
//: ### Inferencia de tipos
//:
//: En Swift una variable se declara de la siguiente manera:

var firstCat: String

//: Si queremos especificar un valor inicial:

var secondCat: String = "Félix"

//: Normalmente no escribiremos el tipo de lo que queremos tener, la mayor parte del tiempo aprovecharemos la inferencia de tipos que Swift implementa, quedando algo mucho más natural:

var thirdCat = "😺"

//: Swift automáticamente detecta en tiempo de compilación que la variable es un String y refuerza ese tipado, así que no podremos más adelante tratarlo como, por ejemplo, un entero:

//! secondCat = 42

//: Esta inferencia funciona en la mayoría de los casos: literales, llamadas a funciones, llamadas a inicializadores, etc.

var allCats = [secondCat, thirdCat, "Isidoro"]

var catCount = allCats.count

//: **Truco**: en los casos donde no tengamos claro qué tipo se está infiriendo, Alt + Click sobre el texto nos sirve para revisar el tipo de una variable o expresión.
//:
//: ### Mutabilidad
//:
//: Si declaramos una variable con la palabra clave `var`, podremos modificar su valor cuántas veces queramos, pero si la declaramos con la palabra `let` no se podrá redefinir. Es decir, en Swift utilizamos let para declarar constantes:

let friendsCount = 5

//! friendsCount = 3

//: Esto funciona en estructuras (los tipos básicos están definidos en el propio lenguaje como structs), enumerados y tuplas, pero no en clases: podremos modificar sus valores internos pero no podremos asignarle otro objeto a esa constante. Más adelante hablaremos más sobre estos tipos compuestos.
//:
//: Estos modificadores funcionan en todos los contextos, así que los veremos muy a menudo: para definir variables globales, variables locales, propiedades de clases, funciones/bloques, etc. Como regla general, es preferible usar let, y el compilador nos avisará cuando sea posible.
//:
//: ## Funciones
//:
//: Conocer la estructura de una función es básico en Swift, dado que exactamente la misma sintaxis se usa en funciones globales, lambdas (bloques) y métodos de una clase.

func doAwesomeStuff() {
}

func doAwesomeStuff() -> Int {
	var total = 0
	for i in 1...5 {
		total += i
	}
	return total
}

func doAwesomeStuff(catName: String, doItFast: Bool = true) -> Int {
	if doItFast {
		return catName.hashValue
	} else {
		return catName.characters.count
	}
}

//: Swift soporta sobrecarga de funciones, y en tiempo de compilación elegirá la versión de la función más adecuada al contexto.
//:
//: El tipo de retorno por defecto es Void (al contrario que otros lenguajes como C, donde es int). Si ese es el caso de nuestra función no hace falta especificarlo.
//:
//: Los parámetros de entrada de la función deben especificar el tipo, y pueden definirse como omitibles si definimos un valor por defecto.
//:
//: Para llamar a una función decimos adiós a los corchetes y utilizamos una forma mucho más familiar a otros lenguajes:

//! doAwesomeStuff()

//! let awesomeStuff = doAwesomeStuff()

var awesomeStuffInt: Int = doAwesomeStuff()

let awesomeStuffVoid: Void = doAwesomeStuff()

var awesomeStuff = doAwesomeStuff("Hello Kitty")
awesomeStuff = doAwesomeStuff("Hello Kitty", doItFast: false)

//: En las funciones los parámetros pueden ser nombrados o no. Las reglas son relativamente complejas, principalmente para ser compatible con las APIs de Objective C como Cocoa.
//:
//: Por defecto el primer parámetro al ser llamado no tiene nombre, mientras que el resto sí.

func printCatName(name: String, surname: String) {
	print(name + surname)
}

printCatName("😼", surname: "🇪🇸")

//: Pero se puede optar por especificar un nombre externo a los parámetros, que puede ser independiente del interno:

func printCat(name catName: String) {
	print(catName)
}

printCat(name: "😽")

//: Estas reglas son las mismas tanto para funciones como para métodos.
//:
//: # Tipos de datos compuestos
//:
//: Swift tiene diversos tipos de datos compuestos, pero al contrario que en otros lenguajes, todos los tipos son de primera clase. De hecho, una de las dudas que tendremos al crear un modelo será qué tipo es el más adecuado.
//:
//: ## Enumerados
//:
//: Los enumerados de Swift son muy potentes respecto a otros lenguajes. En el caso más básico su aspecto es:

enum CoolAnimals {
	case Cat
	case Pig
}

//: A partir de ahora podemos definir variables de este tipo, utilizando la inferencia de tipos para hacer más ameno trabajar con ellas:

let coolAnimal = CoolAnimals.Cat

var otherCoolAnimal: CoolAnimals

otherCoolAnimal = .Pig

//: Podemos añadir un valor a cada uno de los valores si tipamos el enumerado:

enum CoolAnimalsStrings: String {
	case Cat = "🙀"
	case Pig = "🐷"
}

CoolAnimalsStrings.Cat.rawValue

//: Por último también podemos enlazar valores dependiente de cada tipo por cada variable, pero para acceder a él tendremos que utilizar _pattern matching_, por ejemplo con un `switch`:

enum CoolHeterogeneousAnimals {
  case Cat(name: String)
  case Pig
}

let coolHeterogenerousAnimal = CoolHeterogeneousAnimals.Cat(name: "Mordisquitos")

switch (coolHeterogenerousAnimal) {
	case .Pig:
		print("Unnamed pig")
	case .Cat(let name):
		print(name)
}

//: ## Estructuras
//:
//: Las estructuras de Swift también son increíblemente potentes. De hecho, los tipos básicos como `String` o `Int` son estructuras, adaptando interesantes propiedades.

struct Payment {
	var amount = 0.0
	var currency: String
}

//: Automáticamente las estructuras generan un constructor con el orden en el que se han definido sus propiedades.

var firstPayment = Payment(amount: 25, currency: "EUR")

//: Las estructuras pueden tener también métodos, y también pueden ser extendidas (útil para extender los tipos comunes o para organizar nuestro código):

extension Payment {
	func prettyPrint() -> String {
		return "\(currency) \(amount)"
	}
}

firstPayment.prettyPrint()

//: La semántica de mutabilidad está presente en las estructuras, de tal manera que no podremos modificar sus datos si las definimos como constantes:

firstPayment.amount = 35
firstPayment.prettyPrint()

let immutablePayment = Payment(amount: 39, currency: "USD")

//! immutablePayment.amount = 35

//: Los métodos tienen permitido modificar los valores internos de una estructura, pero deben estar marcados con la palabra clave **mutating** para especificar su comportamiento. Estos métodos no pueden usarse en constantes.

extension Payment {
	mutating func doubleIt() {
		amount *= 2
	}
}

firstPayment.doubleIt()
firstPayment.prettyPrint()

//! staticPayment.doubleIt()

//: ## Clases
//:
//: Las clases siguen una estructura muy similar

class Cashier {
	var name = "Unnamed"

	func processPayment(payment: Payment, inCash: Bool) {
		print(payment)
	}
}

//: Como vemos, la semántica de mutabilidad es diferente, en constantes podemos modificar un atributo/propiedad pero no asignar otro objeto.

let firstCashier = Cashier()

firstCashier.name = "Paco"

//! firstCashier = Cashier()

//: También el constructor generado por defecto es distinto a las estructuras, simplemente tenemos un constructor vacío.
//:
//: ---
//:
//: Respecto a Objective C, podemos notar varios cambios:
//:
//: - No hay distinción de header/implementation (.h/.m)
//: - (Teóricamente) no hace falta heredar de NSObject.
//: - En general es mucho más sucinto.
//:
//: Para llamar a métodos las reglas son iguales a las funciones normales y mantienen una sintaxis consistente:

firstCashier.processPayment(firstPayment, inCash: true)

//: Si quisiéramos borrar el nombre de cualquiera de los parámetros adicionales, podríamos utilizar el símbolo `_`.

extension Cashier {
	func processPaymentAndGuessTheSecondParam(payment: Payment, _ inCash: Bool) {
		print(payment)
	}
}

firstCashier.processPaymentAndGuessTheSecondParam(firstPayment, true)

//: Las clases, al contrario que las estructuras, admiten herencia, así que podríamos crear una nueva clase que extienda de la primera. Todos los métodos que se sobreescriban deben estar marcados con la palabra clave `override`:

class FastCashier: Cashier {
	func processPayment(payment: Payment) {
		super.processPayment(payment, inCash: false)
	}

	override func processPayment(payment: Payment, inCash: Bool) {
		super.processPayment(payment, inCash: false)
	}
}

let fastCashier = FastCashier()

//: Si queremos evitar que una clase sea heredable, podemos definirla con la palabra clave `final`.

final class StupiestClass {
}

//: Las clases pueden incluir constructores, que deben cumplir ciertas reglas para asegurar la correcta inicialización de una clase. Son bastante complejas, así que intentaremos simplificar centrándonos en los inicializadores más comunes (sin especificar **required** ni `convenience`):
//:
//: - Un constructor debe primero asignar un valor a todas sus variables (luego matizaremos con los opcionales).
//: - Luego debe llamar a un constructor de la clase padre.
//: - Al final puede hacer cualquier trabajo adicional que crea oportuno.

class NamedCashier {
	var name: String

	init(name: String) {
		self.name = name
	}
}

let namedCashier = NamedCashier(name: "Maria")

class SeniorCashier: NamedCashier {
	var seniority: Int

	init(seniority: Int) {
		self.seniority = seniority
		super.init(name: "Apu")
		print(self.name)
	}
}

let seniorCashier = SeniorCashier(seniority: Int.max)

//: También podemos generar propiedades computadas:

class Person {
	var name = "Víctor"

	var initial: Character {
		return name.characters.first!
	}
}

let yo = Person()
yo.initial

//: Estas propiedades pueden ser de lectura o de lectura y escritura:

class Person2 {
	var name = "Víctor"

	var initial: Character {
		get {
			return name.characters.first!
		}
		set {
			name = String(newValue) + name
		}
	}
}

let yo2 = Person2()

yo2.initial
yo2.initial = "B"

//: Además podemos añadir observadores a las propiedades que se ejecutarán antes o después de cambiarlas:

class Person3 {
	var name: String = "Víctor" {
		willSet {
			print("I'll be " + newValue)
		}
		didSet {
			print("I was " + oldValue)
		}
	}
}

let yo3 = Person2()

yo3.name = "Victoria"

//: No hay que confundir estos observadores con KVO: ni reemplazan ni ofrecen las mismas funcionalidades. Para empezar estos observadores solo pueden ser definidos junto a la propiedad.
//:
//: ## Protocolos
//:
//: Los protocolos definen un contrato formal sobre una particular tarea sin definir cómo debería estar implementada (como las interfaces en lenguajes como Java).
//:
//: En Swift, tanto las clases como las estructuras y los enumerados pueden conformar protocolos.

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
		return "My symbol is " + rawValue
	}
}

//: Podemos también conformar protocolos en extensiones:

extension Cashier: Describable {
	func description() -> String {
		return "I'm cashier " + name
	}
}

firstCashier.description()

//: Y desde Swift 2.0 también podemos implementar métodos en protocolos. En la práctica facilita añadir funcionalidad a una gran variedad de clases del sistema. A la vez, nos ofrece una nueva herramienta para organizar nuestro propio código.

extension Describable {
	func allCapsDescription() -> String {
		return self.description().uppercaseString
	}
}

//: ## Tuplas
//:
//: El tipo de datos compuesto más básico de Swift son las tuplas, una simple combinación de otros valores. Se definen así:

var myFirstTuple: (Int, Double, String)

//: La forma literal es muy simple:

let mySecondTuple = (42, "Wait a little")

//: Para acceder a los valores de una tupla podemos acceder a sus índices numéricos:

mySecondTuple.0
mySecondTuple.1

//: Pero podemos definir etiquetas para explicar su contenido:

let myThirdTuple = (code: 42, message: "Wait a little")

myThirdTuple.code
myThirdTuple.message

//: Sí vamos a reusar una tupla en particular, podemos definir un alias de tipo con los parámetros exactos de la tupla:

typealias ErrorTuple = (code: Int, message: String)

//: Así será más fácil referirse a ellas en funciones y otros contextos:

var myGreatTuple: ErrorTuple

func whereIsMyError(input: String) -> (code: Int, message: String) {
	return (42, input)
}

func whereIsMyErrorBetter(input: String) -> ErrorTuple {
	return (42, input)
}

//: Al igual que las estructuras o los enumerados, lamentablemente esta clase de tipos no es compatible con las APIs de Objective C, así que cualquier código escrito con esta clase es estructuras no será accesible fuera de Swift.
//:
//: ### ¿Qué elegir?
//:
//: No es una tarea fácil decidir qué tipo debemos usar a la hora de modelar.
//:
//: - Las tuplas son las más rápidas de definir, pero las menos extensibles.
//: - Las estructuras son muy potentes y bastante rápidas de definir, aparte de soportar la semántica de mutabilidad. En su contra (¿o a favor?) está el no poder heredar, solo extender.
//: - Las clases son las menos rápidas de definir y no soportan la semántica de mutabilidad. Sin embargo la posibilidad de extensión y su enorme presencia en las APIs de Cocoa las hacen la única solución para muchos problemas.
//: - Los enumerados tienen un ámbito distinto al del resto de estructuras de datos, pero los datos enlazados pueden ampliar su uso.
//:
//: También habría que tener en cuenta el aspecto de la memoria: las clases son pasadas por referencia, mientras que el resto son pasados por valor. Eso significa, entre otras cosas, que si pasamos una estructura a una función y la modificamos dentro de la función, esos cambios no serán visibles por quién llamó originalmente a esa función.
//:
//: ## Opcionales
//:
//: En Objective C y otros lenguajes cualquier variable que pueda contener un objeto es nulable. Esto causa null pointer exceptions en algunos lenguajes y en Objective C puede llevar a errores muy sutiles, hasta que crashea nuestra aplicación al invocar un método que no admite nil como parámetro aceptable. En otros lenguajes existe la posibilidad de marcar un variable como nulable, anotando explícitamente que puede contener el valor null.
//:
//: En Swift por defecto una variable no puede contener el valor null (o no estar asignada), en caso contrario ni siquiera compilará:

var nonOptional = "Hey there"

//! nonOptional = nil

//: Para modelar el concepto de nullable Apple ha optado por los opcionales, que no es más que un enumerado que modela dos estados: tener contenido y no tener contenido.

var firstOptional = Optional("Hey there")

firstOptional = Optional()

firstOptional = nil

firstOptional = "Hey there"

//: Para facilitar el trabajo con los opcionales, el lenguaje introduce el símbolo `?` para definir un opcional de manera más sucinta:

var secondOptional: String?

secondOptional = "Hey there"

//: Vemos que automáticamente (gracias a unos protocolos que nuestras clases/estructuras también pueden implementar) la asignación de valores es muy intuitiva. Quizás demasiado, ya que podemos perder de vista lo que realmente hay por debajo.
//:
//: Sin embargo, para acceder a su contenido tenemos explícitamente que tratar con los dos posibles casos, no podemos usarlos directamente:

//! secondOptional + " :("

if let secondOptional = secondOptional {
	secondOptional + " :)"
}

//: Podemos pensar que los opcionales son como envoltorios de caramelos: pueden contener o no un caramelo, pero para saber si lo tienen tenemos que abrirlo antes.
//:
//: Para evitar este baile de condicionales, en los casos en los que estemos 100% seguros podemos unwrappear directamente el valor con el operador `!`. Hay que tener mucho cuidado con ese operador porque si el valor interno es nil, crasheará la aplicación en tiempo de ejecución.

secondOptional! + " :|"

//! firstOptional = nil

firstOptional! + " :S"

//: Por último también tenemos otra opción que veremos lamentablemente muy a menudo pero que hay que evitar en la medida de lo posible: los **implicitly unwrapped optionals**. Estas son variables definidas con el símbolo ! en vez de ?, y se comportan exactamente igual que una variable normal, pero si contienen nil crashean al intentar usarlos.

var implicitlyUnwrappedHell: String! = "Let's roll the dice"

implicitlyUnwrappedHell + " Yeah!"
implicitlyUnwrappedHell = nil
//! implicitlyUnwrappedHell + " Noooooo!"

//: Si queremos acceder a un método de un valor que pueda ser nulo de manera simple, podemos utilizar _encadenamientos opcionales_:

var mayBeNil: String?

mayBeNil?.startIndex

//: Este concepto puede ser especialmente útil al llamar a métodos en delegados.
//:
//: Aunque a primera vista no parezca muy complicado, el concepto de opcional será probablemente uno de los que mayores dolores de cabeza nos cause, al estar impregnado por toda la API de Cocoa. Y aunque en estos momentos la API de Cocoa está cerca de ser 100% auditada, lamentablemente veremos los opcionales implícitamente desenvueltos en demasiados sitios, como por ejemplo en los outlets.
//:
//: Por la inevitabilidad de lidiar con todos estos problemas, es imprescindible saberse manejar bien con los opcionales.
//:
//: ### Guard
//:
//: Trabajar con opcionales en código real antes o temprano acaba en famosas _pirámides de la muerte_ al enlazar varios _if let_:

func letPyramid(name: String?, surname: String?, nickname: String?) {
	if let name = name {
		if let surname = surname {
			if let nickname = nickname {
				print("\(name) \(surname) \(nickname)")
			}
		}
	}
}

//: Podemos mejorar un poco el código y evitar niveles de indentación si encadenamos los _lets_ en la misma condición:

func letItBe(name: String?, surname: String?, nickname: String?) {
	if let name = name, let surname = surname, let nickname = nickname {
		print("\(name) \(surname) \(nickname)")
	}
}

//: Sin embargo muchas veces por cómo está configurado nuestro código no podemos acogernos esa solución, o simplemente queremos evitar todos los niveles de indentación.
//:
//: Para esos casos podemos utilizar `guard` para implementar un _early return_ y dejar el nivel de indentación principal para el _happy case_:

func guardOfTheGalaxy(name: String?, surname: String?, nickname: String?) {
	guard let name = name else { return }
	guard let surname = surname else { return }
	guard let nickname = nickname else { return }

	print("\(name) \(surname) \(nickname)")
}

//: Una vez conocida la sintaxis y sus implicaciones, en programas reales el código resultante es mucho más legible y fácil de seguir respecto a las pirámides:
//:
//: - En el bloque principal (entre guard y else) definimos una precondición.
//: - El bloque else debe salir del scope actual, conteniendo un return o un continue/break en el caso de bucles.
//: - Esa precondición, de ser falsa, ejecuta el bloque else, por tanto siempre sale del scope actual.
//: - Esa precondición, de ser verdadera, sigue con la ejecución del scope actual.
//:
//: La característica más útil de los guards es que permite desenvolver opcionales y continuar con la ejecución garantizando que esos valores deselvueltos no son nulos.
//:
//: ## Genéricos
//:
//: Este tema da para hablar mucho, simplemente vamos a repasar lo mínimo indispensable para entender este concepto en Swift.
//:
//: Los genéricos son una herramienta increíblemente potente que nos ayudará a reutilizar código sin perder la seguridad que nos da el tipado fuerte.
//:
//: Imaginemos que queremos construir una pila que guarde enteros:

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

//: Funciona como esperamos, pero esta estructura es poco reutilizable. ¿Y si ahora queremos guardar Strings o Cashiers? En principio todo el código que hemos escrito no tiene que ver específicamente con enteros, estamos simplemente añadiendo y quitando elementos. Que sean enteros o cualquier otro tipo es un simple detalle concreto.
//:
//: Los genéricos nos permiten abstraer esa concreción y ampliar la utilidad del código que escribimos. Una versión genérica sería similar a:

struct Stack<Element> {
	var items = [Element]()

	mutating func push(item: Element) {
		items.append(item)
	}

	mutating func pop() -> Element {
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

//: Funciona exactamente igual, simplemente hemos tenido que especificar que queríamos una pila de enteros al crear el objeto. Si quisieramos hacer una pila de Cashiers:

var cashierStack = Stack<Cashier>()

cashierStack.push(firstCashier)
//! cashierStack.push(2)
cashierStack.push(fastCashier)

cashierStack.pop()
cashierStack.pop()

//: Sin tener que escribir otra vez el algoritmo, hemos podido reutilizar el código sin perder ninguna ventaja del tipado fuerte.
//:
//: Este concepto es importante porque en Swift puro, varias de las clases más usadas están basadas en genéricos, como los arrays o los diccionarios, colecciones que por defecto solo admiten elementos del mismo tipo (al contrario que en Objective C):

var myStringArray: [String]
var myStringArray2: Array<String>
let myIntArray = [1, 2, 3]
//! let myWrongArray = [1, "wat", 3]

let myIntToDoubleDictionary = Dictionary<Int, Double>()
let myIntToDoubleDictionary2 = [Int: Double]()
let myIntToStringDictionary = [1: "one", 2: "two"]
//! let myWrongDictionary = [1: 5, 2: "two"]

//: Por debajo Swift directamente nos hará un puente a `NSArray` y `NSDictionary`, lo cual implica que esta seguridad de tipado solo se puede reforzar en tiempo de compilación. Mientras que en tiempo de ejecución si guardamos un valor incorrecto todo funcionará excepto en el sitio en que intentemos utilizar ese valor con el tipo incorrecto.
//:
//: ## Bloques (Closures)
//:
//: Las funciones son también ciudadanos de primera en Swift: se pueden asignar a variables, pasar como parámetro, etc.
//:
//: El método sort recibe una colección y una función que sepa distinguir el orden entre dos elementos de esa colección. Podemos pasarle directamente una función que creemos para tal efecto:

var unsortedList = [3, 1, 2]

func greaterThan(first: Int, second: Int) -> Bool {
	return first > second
}

unsortedList.sort(greaterThan)

//: Quizás no nos interese o nos resulte tedioso crear una función adicional. Swift nos ofrece la opción de definirla directamente de diferentes maneras:

unsortedList.sort({
	(first: Int, second: Int) -> Bool in
	return first > second
})

unsortedList.sort {
	(first: Int, second: Int) -> Bool in
	return first > second
}

unsortedList.sort {
	first, second in
	return first > second
}

unsortedList.sort {
	first, second in
	first > second
}

unsortedList.sort { $0 > $1 }

unsortedList.sort(>)

//: Los bloques de Objective C son automáticamente convertidos a estas funciones sin necesidad de que el programador especifique nada. Esto significa que las mismas implicaciones de gestión de memoria de los bloques aplican aquí también.
//:
//: ## Casting e interoperabilidad con Objective C
//:
//: Si queremos castear un objeto a otro tipo, podemos utilizar los operadores `as?` y `as!`:

var surprise: Any
surprise = "Not any object"
//! surprise.startIndex

let surprisedString = surprise as! String
surprisedString.startIndex
let surprisedStringOptional = surprise as? String
surprisedStringOptional?.startIndex

//: Swift automáticamente nos realizará un casting de tipos de Foundation a los tipos nativos:
//:
//: - `NSArray` <-> `Array`
//: - `NSDictionary` <-> `Dictionary`
//: - `NSString` <-> `String`
//: - `int` <-> `Int`
//: - `float` <-> `Float`
//: - `double` <-> `Double`
//:
//: Este casting automático solo sucede en ciertas ocasiones, por ejemplo al traducir funciones de Objective C. Si queremos utilizar explícitamente un tipo nativo, deberemos especificarlo al crear la variable.

let myString = "I'm native"

import Foundation

let myNSString: NSString = "I'm native"

//: En ciertas ocasiones tendremos que traducir a un tipo específico de Objective C y el casting en lugar de hacerlo con `as?` lo haremos con inicializadores.

import UIKit

let myDouble = 5.2

//! let myCGFloat = myDouble as CGFloat

let myCGFloat = CGFloat(myDouble)

//: Esta traducción de tipos también incluye enumerados, que quedan mucho más claros y potentes en Swift sin necesidad de que hagamos otra cosa que seguir las convenciones de Objective-C.
//:
//: Por último, si queremos acceder a los tipos básicos de C, también lo podremos hacer, normalmente poniendo una C delante.
//:
//: ## Tratamiento de errores
//:
//: En Swift 2.0 el tratamiento de errores está basado en una sintaxis similar a las excepciones, pero con varias diferencias.
//:
//: Así definimos una función que puede lanzar un error:

func canThrowAnError() throws {
	// this function may or may not throw an error
}

//: El error que puede lanzar no está definido, mejor dicho, el error puede ser de cualquier tipo siempre que conforme con el protocolo vacío `ErrorType`. Enumerados son probablemente la mejor opción:

struct MyError : ErrorType {
}

enum MyOtherError : ErrorType {
	case NotFound
	case ServerError(code: Int)
}

func willThrowAnError() throws {
	throw MyOtherError.NotFound
}

//: Para llamar a esa función debemos utilizar la palabra reservada `try`, y si no queremos relanzar ese error debemos capturarlo dentro de un bloque do catch.

do {
	try canThrowAnError()
	print("no error :)");
} catch {
	print("error :(");
}

//: Si queremos hacer algo con ese error debemos utilizar _pattern matching_:

do {
	try canThrowAnError()
} catch is MyError {
	print("hey")
} catch MyOtherError.NotFound {
	print("not found!")
} catch MyOtherError.ServerError(let code) {
	print("server error \(code)")
}

//: Lo más interesante y la razón por la que veremos más este patrón, es que cualquier método en Objective-C que siga las convenciones estándar será convertido automáticamente a este patrón:
//:
//: - `-(void)myMethod...error:(NSError **)error` a `myMethod: ... -> Void throws`
//: - `-(BOOL)myMethod...error:(NSError **)error` a `myMethod: ... -> Void throws`
//: - `-(id)myMethod...error:(NSError **)error` a `myMethod: ... -> Any throws`
//:
//: ## Recursos
//:
//: ### Imprescindibles
//:
//: - [The Swift Programming Language](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/): Libro básico oficial y documentación online.
//: - [Using Swift with Cocoa and Objective-C](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/): Trabajar con APIs de Cocoa y mezclar código Objective C y Swift.
//: - [Swift In Flux](https://github.com/ksm/SwiftInFlux): Documentación beta a beta.
//: - [Swift Blog](https://developer.apple.com/swift/blog/): Blog oficial de Apple.
//: - [NSHipster](http://nshipster.com/): Las mejores APIs de Swift y Objective C.
//: - [Objc.io sobre Swift](http://www.objc.io/issue-16/): Revista online con excelentes artículos sobre Swift.
//: - [Realm.io](https://realm.io/news/#apple): Artículos y vídeos sobre Swift (click en Apple).
//:
//: ### Blogs personales
//:
//: - [Airspeed Velocity](http://airspeedvelocity.net/)
//: - [Mike Ash](http://www.mikeash.com/pyblog/)
//: - [Russ Bishop](http://www.russbishop.net/)
//: - [Alejandro Salazar](http://nomothetis.svbtle.com/)
//: - [Giant Robots Smashing Into Other Giant Robots](http://robots.thoughtbot.com/)
//: - [David Owens](http://owensd.io/)
//: - [Rob Napier](http://robnapier.net/)
//: - [Nate Cook](http://natecook.com/blog/)
//: - [Artsy](http://artsy.github.io/)
//: - [Natasha The Robot](http://natashatherobot.com/)
//: - [That thing in Swift](https://thatthinginswift.com/)
//: - [Martin Krzyżanowski](http://blog.krzyzanowskim.com/)
//: - [Brent Simmons](http://inessential.com/)
//: - ...
//:
//: ### Listas de correo con enlaces semanales
//:
//: - [Natasha's This week in Swift](https://swiftnews.curated.co/)
//: - [Dave Werver's iOS Dev Weekly](https://iosdevweekly.com/)
//: - [Swift Sandbox](http://swiftsandbox.io/)
//: - [Indie iOS Focus](https://indieiosfocus.curated.co/)
//:
//: ## Repo
//:
//: [https://github.com/victorpimentel/PrimerosPasosConSwift](https://github.com/victorpimentel/PrimerosPasosConSwift)
//:
//: ## ¡Estamos contratando!
//:
//: Si quieres trabajar en pleno centro de Madrid en el fantástico equipo de Tuenti haciendo iOS, mándame un email a:
//:
//: [vpimentel@tuenti.com](mailto:vpimentel@tuenti.com)
