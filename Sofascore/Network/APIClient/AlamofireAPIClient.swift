import Foundation
import Alamofire

class AlamofireAPIClient: APICient {

    func getEvents(for slug: String, for date: String, completion: @escaping ([Event?], Error?) -> Void) {

        // later check format for slug and date

        AF
//            .request("https://academy.dev.sofascore.com/sport/football/events/2023-04-29")
            .request("https://academy.dev.sofascore.com/sport/\(slug)/events/\(date)")
            .responseDecodable(of: [Event].self) { result in
                completion(result.value ?? [], result.error)
            }
    }

}

// Izdvojiti sve urlove negdi?
