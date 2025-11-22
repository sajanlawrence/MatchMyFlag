//
//  Country.swift
//  MatchMyFlag
//
//  Created by Sajan Lawrence on 13/11/25.
//

import Foundation

struct Country: Hashable, Identifiable, Equatable{
    let id = UUID()
    let name: String
    
    static func == (lhs: Country, rhs: Country) -> Bool{
        return lhs.name == rhs.name
    }
    
    static let `default` = Country(name: "Germany")
}
