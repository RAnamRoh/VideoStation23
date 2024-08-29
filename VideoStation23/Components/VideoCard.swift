//
//  VideoCard.swift
//  VideoStation23
//
//  Created by BS00834 on 29/8/24.
//

import SwiftUI

struct VideoCard: View {
    
    var video : Video
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomLeading ){
                
                AsyncImage(url: URL(string: video.image)) { image in
                
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                    
                } placeholder: {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundStyle(.gray.opacity(0.5))
                        .frame(width: 160, height: 250)
                }
                
                VStack(alignment: .leading){
                    Text("\(video.duration) sec")
                        .font(.caption)
                        .bold()
                    Text("By \(video.user.name)")
                        .font(.caption)
                        .bold()
                        .multilineTextAlignment(.leading)
                }
                .foregroundStyle(.white)
                .shadow(radius: 20)
                .padding()
            }
            
            Image(systemName: "play.fill")
                .foregroundStyle(.white)
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}

#Preview {
    VideoCard(video: previewVideo)
}
