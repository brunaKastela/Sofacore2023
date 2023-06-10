import Foundation
import Alamofire

class AlamofireAPIClient: APICient {

    func getEvents(for slug: String, for date: String, completion: @escaping ([Event?], Error?) -> Void) {

        guard isValidDateFormat(date) && isValidSlug(slug) else { return }

        AF
//            .request("https://academy.dev.sofascore.com/sport/football/events/2023-04-29")
            .request("https://academy.dev.sofascore.com/sport/\(slug)/events/\(date)")
            .responseDecodable(of: [Event].self) { result in
                completion(result.value ?? [], result.error)
            }
    }

}

extension AlamofireAPIClient {

    private enum Constants: String, CaseIterable {
        case football = "football"
        case basketball = "basketball"
        case amFootball = "american-football"
    }

    func isValidDateFormat(_ date: String) -> Bool {
        do {
            let pattern = #"^\d{4}-\d{2}-\d{2}$"#
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: date.utf16.count)
            let matches = regex.matches(in: date, options: [], range: range)

            return matches.count == 1
        } catch {
            return false
        }
    }

    func isValidSlug(_ slug: String) -> Bool {
        Constants.allCases.map { $0.rawValue }.contains(slug)
    }
}
