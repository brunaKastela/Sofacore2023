import Foundation

extension String {

//    static func localized(key: String) -> String {
//        NSLocalizedString(key, comment: "")
//    }

    static func localized(_ key: LocalizableKey) -> String {
        NSLocalizedString(key.rawValue, comment: "")
    }

    static func eventState(_ key: EventStates) -> String {
        NSLocalizedString(key.rawValue, comment: "")
    }

}
