//
//  LimitationError.swift
//  UIGA
//
//  Created by Nikita Sibirtsev on 20/03/2022.
//

import Foundation


enum LimitationError {
    case maxFuelLiters, maxBaggage, maxTakeOf, minTakeOff, maxZeroFuel
    func returnError() -> String {
        switch self {
        case .maxFuelLiters:
            return "Too much fuel!"
        case .maxBaggage:
            return "Too much baggage!"
        case .maxTakeOf:
            return "Exceeds max takeoff weight!"
        case .minTakeOff:
            return "Not exceeds min takeof weight!"
        case .maxZeroFuel:
            return "Exceeds max ZeroFuel weight!"
        }
    }
    
}
