//
//  VideoManager.swift
//  VideoStation23
//
//  Created by BS00834 on 29/8/24.
//

import Foundation

enum Query : String , CaseIterable {
    
    case nature, animals, people, ocean, food
}


@MainActor
class VideoManager : ObservableObject {
    @Published private(set) var videos : [Video] = []
    @Published var selectedQuery : Query = Query.nature {
        didSet{
            Task.init {
                await findVideos(topic: selectedQuery)
            }
        }
    }
    
    init(){
        Task.init {
            await findVideos(topic: selectedQuery)
        }
    }
    
    
    func findVideos(topic : Query) async {
        
        do {
            guard let url = URL(string: "https://api.pexels.com/videos/search?query=\(topic)&per_page=10&orientation=portrait") else {
                fatalError("Missing URL")
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("OIid0J4QkInGuHmDAiT2kNafY6TeovWHSWnKAOTPky0JpB0CYwkAnkmI", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                fatalError("Error in Response")
            }
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode(ResponseBody.self, from: data)
            
            self.videos = []
            self.videos = decodedData.videos
            
        }
        catch {
            print("Error Fetching Data From Pexels : \(error)")
        }
        
    }
    
}



struct ResponseBody: Codable {
    let page, perPage, totalResults: Int
    let url: String
    let videos: [Video]
}

// MARK: - Video
struct Video: Codable, Identifiable {
    let id: Int
    //let url: String
    let image: String
    let duration: Int
    let user: User
    let videoFiles: [VideoFile]
   // let videoPictures: [VideoPicture]
    
    
    
    // MARK: - User
    struct User: Codable, Identifiable {
        let id: Int
        let name: String
        let url: String
    }
    
    
    // MARK: - VideoFile
    struct VideoFile: Codable, Identifiable {
        let id: Int
        let quality, fileType: String
        let link: String
    }
    
    
    
    

}





// MARK: - VideoPicture
struct VideoPicture: Codable {
    let id: Int
    let picture: String
    let nr: Int
}
