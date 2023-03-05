//
//  ConformanceToComparableForCustomTypes.swift
//  BucketList
//
//  Created by Enrico Sousa Gollner on 21/02/23.
//

import SwiftUI

struct User: Identifiable, Comparable{
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool{
        lhs.lastName < rhs.lastName
    }
}

struct AddingConformanceToComparableForCustomTypes: View {
    let user = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var body: some View {
        List(user){ user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ConformanceToComparableForCustomTypes_Previews: PreviewProvider {
    static var previews: some View {
        AddingConformanceToComparableForCustomTypes()
    }
}
