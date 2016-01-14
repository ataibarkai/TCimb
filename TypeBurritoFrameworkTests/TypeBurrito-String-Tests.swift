//
//  TypeBurrito-String-Tests.swift
//  TypeBurritoFramework
//
//  Created by Atai Barkai on 1/12/16.
//  Copyright © 2016 Atai Barkai. All rights reserved.
//

import XCTest
@testable import TypeBurritoFramework


struct Name: TypeBurrito {
	var value: String = ""
}


struct Hometown: TypeBurrito {
	var value: String = "Unspecified"
}

struct SQLQuery: TypeBurrito {
	var value: String = ""
}

struct Person {
	var name: Name
	var hometown: Hometown
}


struct FavoriteShow: TypeBurrito{
	var value = "Unspecified"
}

struct Username: TypeBurrito{
	var value = ""
}



class TypeBurrito_String_Tests: XCTestCase {
	
	
	func testTypeBurritoStringCreation() {
		
		let joe = Username("joe")
		let eric = Username("eric")
		let emptyUser = Username()
		
		let drWhoString = "Doctor Who"
		let drWho = FavoriteShow(drWhoString)
		let breakingBad = FavoriteShow("Breaking Bad")
		let emptyShow = FavoriteShow()
		
		
		XCTAssertEqual(joe.value, "joe")
		XCTAssertEqual(eric.value, "eric")
		XCTAssertEqual(emptyUser.value, "")
		
		XCTAssertEqual(drWho.value, drWhoString)
		XCTAssertEqual(breakingBad.value, "Breaking Bad")
		XCTAssertEqual(emptyShow.value, "Unspecified")
	}
	
	func testTypeBurritoStringComparison(){
		let joeString = "joe"
		let joe1 = Username(joeString)
		let joe2 = Username(joeString)
		let eric = Username("eric")
		let emptyUser1 = Username()
		let emptyUser2 = Username()
		
		let drWhoString = "Doctor Who"
		let drWho1 = FavoriteShow(drWhoString)
		let drWho2 = FavoriteShow(drWhoString)
		let breakingBad = FavoriteShow("Breaking Bad")
		let emptyShow1 = FavoriteShow()
		let emptyShow2 = FavoriteShow()
		
		
		XCTAssertEqual(joe1, joe2)
		XCTAssertNotEqual(joe1, eric)
		XCTAssertNotEqual(joe1, emptyUser1)
		XCTAssertEqual(emptyUser1, emptyUser2)
		
		XCTAssertEqual(drWho1, drWho2)
		XCTAssertNotEqual(drWho1, breakingBad)
		XCTAssertNotEqual(drWho1, emptyShow1)
		XCTAssertEqual(emptyShow1, emptyShow2)
		
		// The below should give a compile time error
		//		XCTAssertNotEqual(joe1, drWho1)
	}
		
	
	func testTypeBurritoStringCompilation() {
		
		func bookCharactersSqlQuery(forHometown hometown: Hometown) -> SQLQuery{
			return SQLQuery("SELECT * FROM BookCharacters WHERE Name = \(hometown);")
		}
		
		func findPersonsByPerformingSQLQuery(sqlQuery: SQLQuery) -> [Person]{
			// perform sql query...
			return [Person(name: Name("Lazas Long"), hometown: Hometown("Basoom"))]
		}
		
		let results = findPersonsByPerformingSQLQuery(bookCharactersSqlQuery(forHometown: Hometown("Basoom")))
		XCTAssert(results.count == 1)
	}


}