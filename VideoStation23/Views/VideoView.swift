//
//  VideoView.swift
//  VideoStation23
//
//  Created by BS00834 on 29/8/24.
//

import SwiftUI
import AVKit

struct VideoView: View {
    
    var video : Video
    @State private var player = AVPlayer()
    
    var body: some View {
        VideoPlayer(player: player)
            .ignoresSafeArea()
            .onAppear {
                
                if let link = video.videoFiles.first?.link {
                    player = AVPlayer(url: URL(string: link)!)
                    player.play()
                }
                
            }
    }
}

#Preview {
    VideoView(video: previewVideo)
}
