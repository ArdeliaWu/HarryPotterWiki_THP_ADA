//
//  RecommendationLoading.swift
//  HarryPotterWiki
//
//  Created by Ardelia on 03/12/25.
//

import SwiftUI
struct RecommendationLoading: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Today's Recommendations")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.horizontal)
            
            HStack(spacing: 16) {
                ForEach(0..<3, id: \.self) { _ in
                    VStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 180, height: 270)
                            .cornerRadius(16)
                        
                        VStack(spacing: 4) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 16)
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 12)
                        }
                        .frame(width: 180)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
