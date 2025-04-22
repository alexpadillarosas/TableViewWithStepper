//
//  SaleType.swift
//  TableViewWithStepper
//
//  Created by alex on 22/4/2025.
//

import Foundation


enum SaleType {
    case byUnit(count: Int)
    case byWeight(weight: Measurement<UnitMass>)
}
