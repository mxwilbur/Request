//
//  ViewController.swift
//  Request
//
//  Created by Mike Wilbur on 2/26/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let headers = [
            "X-ListenAPI-key": "102ee4d956eb4545960c478a6ed7fc7a"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://listen-api.listennotes.com/api/v2/best_podcasts?genre_id=107&page=1&region=fr&safe_mode=0")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("http \n", httpResponse)
            }
            print("ran for fun")
            print(response, data)
            
/*       })
        dataTask.resume()

        

        
        
        
        
        
        
        let baseURL = "https://listen-api.listennotes.com/api/v2"
        let header = "/best_podcasts"
        let params = "?genre_id=107&page=1&region=us&safe_mode=0 "
        let apiKey = "102ee4d956eb4545960c478a6ed7fc7a"

        let constructedURL = baseURL + header + params + "{X-ListenAPI-Key: " + "" + apiKey + "}"
        let requestURL = URL(string: constructedURL)
        
        guard let url = requestURL else {
            return
        }
        
//        let url =
//        "https://listen-api.listennotes.com/api/v2/best_podcasts?genre_id=107&page=1&region=us&safe_mode=0 X-ListenAPI-Key: 102ee4d956eb4545960c478a6ed7fc7a"
        getData(from: url)
       
    }

    func getData(from url: String) {
        URLSession.shared.dataTask(with: url(string: url)!, completionHandler: { data, response, error in
        
            guard let data = data, error != nil else {
                print("something went wrong")
                return
            }
*/
            // have data
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data!)
            }
            catch {
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.name)
            print(json.results.title)
            print(json.results.publisher)
            print(json.results.description)
        })
        
        dataTask.resume()
    }

}
struct Response: Codable {
    var results: Podcast
    var name: String

    struct Podcast: Codable {
        var podId: String
        var title: String
        var publisher: String?
        var thumbnail: String?
        var listennotes_url: String?
        var total_episodes: Int
        var explicit: Bool
        var description: String
        var type: String
        var genre_ids: Array<String>
    }

    enum keys: String, CodingKey {
        case podId = "id"
        case title
        case publisher
        case thumbnail
        case listennotes_url
        case total_episodes
        case explicit = "explicit_content"
        case description
        case type
        case genre_ids
        }
}
/*
struct Response: Codable {
    let results: MyResult
    let status: String
    struct MyResult: Codable {
        let sunrise: String
        let sunset: String
        let solar_noon: String
        let day_length: Int
        let civil_twilight_begin: String
        let civil_twilight_end: String
        let nautical_twilight_begin: String
        let nautical_twilight_end: String
        let astronomical_twilight_begin: String
        let astronomical_twilight_end: String
    }
}
*/
/*
struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}

struct Other: Codable {
    let status: String
}
*/
/*
 {

     "results": {
         "sunrise": "6:51:11 AM",
         "sunset": "6:09:38 PM",
         "solar_noon": "12:30:25 PM",
         "day_length": "11:18:27",
         "civil_twilight_begin": "6:25:15 AM",
         "civil_twilight_end": "6:35:34 PM",
         "nautical_twilight_begin": "5:55:14 AM",
         "nautical_twilight_end": "7:05:35 PM",
         "astronomical_twilight_begin": "5:25:17 AM",
         "astronomical_twilight_end": "7:35:32 PM"
     },
     "status": "OK"

 }
 */
