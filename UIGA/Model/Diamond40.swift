//
//  Diamond40.swift
//  UIGA
//
//  Created by Nikita Sibirtsev on 17/03/2022.
//

import Foundation

protocol ErrorHandlerDelegate {
    func error (error: LimitationError) -> Void
}

struct Diamond40 {
    //constants
    private let arm_front_seats = 2.30
    private let arm_rear_seats = 3.25
    private let arm_tank = 2.63
    private let arm_baggage_main = 3.65
    private let max_fuel_litres = 155.2
    private let max_takeoff_weight = 1310.0
    private let min_takeoff_weight = 940.0
    private let max_zero_fuel = 1200.0
    private let max_baggage_weight = 30.0
    private let pax_weight = 80.0
    
    //we will input
    var empty_weight = 890.0 //slider
    var pax_front = 1.0     //switch
    var pax_rear = 0.0      //slider
    var fuel_total = 0.0    //slider?
    var baggage_total = 0.0 //slider?
    var fuel_dencity = 0.84
    
    var errorDelegate: ErrorHandlerDelegate?
    
    //weight of the pax
    
    private func pax_weight (_ pax: Double) -> Double {
        let pax_weight = pax * self.pax_weight
        return pax_weight
    }
    private func pax_total () -> Double {
        let pax_total = (self.pax_front + self.pax_rear) * self.pax_weight
        return pax_total
    }
    //aircraft weights
    
    private func zero_fuel_weight () -> Double {
        let zero_fuel_weight = self.empty_weight + self.pax_total() + self.baggage_total
        return zero_fuel_weight
    }
    func total_weight () -> Double {
        let total_weight = self.zero_fuel_weight() + self.fuel_total * self.fuel_dencity
        return total_weight
    }
    
    func isInputInRange() -> Bool {
        if self.total_weight() > self.max_takeoff_weight {
            errorDelegate?.error(error: LimitationError.maxTakeOf)
            return false
        } else if self.total_weight() < self.min_takeoff_weight {
            errorDelegate?.error(error: LimitationError.minTakeOff)
            return false
        } else if self.zero_fuel_weight() > self.max_zero_fuel {
            errorDelegate?.error(error: LimitationError.maxZeroFuel)
            return false
        }
        return true
    }
    //function calculates moment for full-weighted aircraft and with no fuel
    // moment.0 forward, moment.1 rear
    private func moment () -> (Double, Double) {
            let momentum_full = self.pax_weight(self.pax_front) * self.arm_front_seats +
            self.pax_weight(self.pax_rear) * self.arm_rear_seats +
            self.fuel_total * self.arm_tank +
        self.baggage_total * self.arm_baggage_main + self.empty_weight * 2.42
            let momentum_noFuel = momentum_full - self.fuel_total * self.arm_tank
            return (momentum_full, momentum_noFuel)
        
    }
    
    //Calculates CG for full-weighted aircraft and with no fuel
    func centerOfGravity () -> (Double, Double) {
        let cg_noFuel = moment().1 / self.zero_fuel_weight()
        let cg_full = self.moment().0 / self.total_weight()
        return (cg_full, cg_noFuel)
    }
    
    // Checks range of front and rear CG
    func isInRange () -> (Bool, Bool, Bool, Bool) {
        let total_weight = self.total_weight()
        let zero_fuel = self.zero_fuel_weight()
        var isInRange = (false, false, false, false)
        let cgFull = centerOfGravity().0
        let cgNoFuel = centerOfGravity().1
        func isInRangeCurrent(_ cg: Double, _ weight: Double) -> (Bool, Bool) {
            var rear_cg: Bool = false
            var front_cg: Bool = false
            if weight <= 1080.0 {
                if cg >= 2.40 {front_cg = true}
            }else if weight <= 1280 {
                if cg >= (((weight - 1080.0) * 0.0003) + 2.40) {front_cg = true}
            }else if weight <= 1310 {
                if cg >= 2.469 {front_cg = true}
            }
            if cg <= 2.53 {rear_cg = true}
            return (front_cg, rear_cg)
        }
        isInRange.0 = isInRangeCurrent(cgFull,total_weight).0
        isInRange.1 = isInRangeCurrent(cgFull, total_weight).1
        isInRange.2 = isInRangeCurrent(cgNoFuel, zero_fuel).0
        isInRange.3 = isInRangeCurrent(cgNoFuel, zero_fuel).1
        return isInRange
    }
    
   
}
