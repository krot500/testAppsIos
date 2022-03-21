//
//  LimitationError.swift
//  UIGA
//
//  Created by Nikita Sibirtsev on 20/03/2022.
//

import Foundation


enum ListOfErrors: Error {
    case  maxTakeOff, minTakeOff, maxZeroFuel, incorrectValue, emptyEnter
    func returnError() -> String {
        switch self {
        case .maxTakeOff:
            return "Exceeds max takeoff weight!"
        case .minTakeOff:
            return "Not exceeds min takeof weight!"
        case .maxZeroFuel:
            return "Exceeds max ZeroFuel weight!"
        case .incorrectValue:
            return "Use only numbers"
        case . emptyEnter:
            return "Enter dencity"
        }
    }
    
}
