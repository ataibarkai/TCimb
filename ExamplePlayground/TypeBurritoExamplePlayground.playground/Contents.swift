/*:
# The `TypeBurrito` Protocol

---------

## Purpose

`TypeBurrito` is a protocol that enables the quick, *boilerplate-free* creation of types that wrap other types.
This allows for treating types as *restrictions* rather than as *"data holders"* -- thereby increasing **code safety** and **code clarity**.


---------

## Inspiration

* https://realm.io/news/altconf-justin-spahr-summers-type-safety/
* http://www.johndcook.com/blog/2015/12/01/dimensional-analysis-and-types/
* http://www.joelonsoftware.com/articles/Wrong.html

---------

## Value

A type which adopts `TypeBurrito` *automatically* gets sane behavior and compliance for:
* `hashValue` (`Hashable` -> can be used as a dictionary key)
* `<`, `==` (`Comparable`, ***but only across the same subtype***)
* it is `CustomStringConvertible`, meaning we can print it and use it inside `String`s
* it is `CustomDebugStringConvertible`

If the underlying type wrapped by a `TypeBurrito` is a number, then we also *automatically* get:
* `+` (***but only across the same subtype***)
* `-` (***but only across the same subtype***)
* `+=` (***but only across the same subtype***)
* `-=` (***but only across the same subtype***)

---------

## Usage:
*/
import TypeBurritoFramework

//: TypeBurrito declerations
enum _SQLQuery: TypeBurritoSpec { typealias TheTypeInsideTheBurrito = String }
typealias SQLQuery = TypeBurrito<_SQLQuery>

enum _Meters: TypeBurritoSpec { typealias TheTypeInsideTheBurrito = Double }
typealias Meters = TypeBurrito<_Meters>

enum _Inches: TypeBurritoSpec { typealias TheTypeInsideTheBurrito = Double }
typealias Inches = TypeBurrito<_Inches>

//: TypeBurritos in practice
let query = SQLQuery("SELECT * FROM SwiftFrameworks")
let metersClimbedToday = Meters(40) + Meters(2)
let truth = ( Meters(1000) > Meters(34) )

var distanceLeft = Meters(987.25)
distanceLeft -= Meters(10)

let lengthOfScreenDiagonal = Inches(13)

func performSQLQuery(sqlQuery: SQLQuery){
	// can only be called with a SQLQuery, not with just any String
}

//: The following would be a compile time error were it not commented-out
//let _ = Meters(845.235) + Inches(332)

/*:
### Advanced Usage: The `gatewayMap` Function
We may also define Specs with a `static` function:

`gatewayMap(preMap: TheTypeInsideTheBurrito) -> TheTypeInsideTheBurrito`

The gateway map allows us to construct types which have an *inherent*
restriction on the range of allowed values.
For example, we may construct a `Username` type which is inherently case-insensitive:
*/
enum _Username: TypeBurritoSpec {
	typealias TheTypeInsideTheBurrito = String
	
	static func gatewayMap(preMap: TheTypeInsideTheBurrito) -> TheTypeInsideTheBurrito{
		return preMap.lowercaseString
	}
}
typealias Username = TypeBurrito<_Username>

let lowercaseSteve = Username("steve@gmail.com")
let uppercaseSteve = Username("STEVE@GMAIL.COM")

// evaluates to true:
let usernameTypeIsCaseInsensitive = (lowercaseSteve == uppercaseSteve)

/*:
The `gatewayMap` can come in handy whenever we have a restriction on our values
which is not inherent in the underlying type.

Examples include:
* a `URL` type which is always url-escaped
* a `SQLCommand` type which is always escaped (and not prone to SQL-injection attacks)
* a `LevelInSomeBuilding` type which does not allow values below -1 nor above 72 (the lowest and highest levels in SomeBuilding).
* etc.
*/




/*:
## Installation:

### Carthage
Add the following to your cartfile:

`github "ataibarkai/TypeBurritoFramework"`

*/
