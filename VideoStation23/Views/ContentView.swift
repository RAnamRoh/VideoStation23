//
//  ContentView.swift
//  VideoStation23
//
//  Created by BS00834 on 29/8/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var videoManager = VideoManager()
    var coloumn = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    ForEach(Query.allCases, id: \.self){ query in
                        QueryTag(query: query, isSelected: videoManager.selectedQuery == query).onTapGesture {
                            videoManager.selectedQuery = query
                        }
                    }
                }
                
                ScrollView {
                    
                    if videoManager.videos.isEmpty{
                        ProgressView()
                    }
                    else {
                        LazyVGrid(columns: coloumn, spacing: 20) {
                            ForEach(videoManager.videos, id: \.id){ video in
                                
                                NavigationLink {
                                    VideoView(video: video)
                                } label: {
                                    VideoCard(video: video)
                                }
                                
                            }
                        }
                        .padding()
                    }
                    
                   
                    
                    
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color("AccentColor"))
        }
    }
}

#Preview {
    ContentView()
}
