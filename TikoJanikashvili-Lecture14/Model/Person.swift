//
//  Person.swift
//  TikoJanikashvili-Lecture14
//
//  Created by Tiko Janikashvili on 23.11.22.
//

import Foundation

struct Person {
    
    enum Nationality: String {
        case georgian = "ქართველი"
        case spanish = "ესპანელი"
        case italian = "იტალიელი"
        case french = "ფრანგი"
    }
    
    let name: String
    let surname: String
    let age: Int
    let nationality: Nationality
}
