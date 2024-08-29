//
//  QueryTag.swift
//  VideoStation23
//
//  Created by BS00834 on 29/8/24.
//

import SwiftUI

struct QueryTag: View {
    
    var query : Query
    var isSelected : Bool
    
    var body: some View {
        Text(query.rawValue)
            .font(.caption)
            .bold()
            .foregroundStyle(isSelected ? .black : .gray)
            .padding(10)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    QueryTag(query: Query.food, isSelected: true)
}
