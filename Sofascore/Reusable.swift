import Foundation

protocol Reusable {

    static var identifier: String { get }
}

extension Reusable {

    static var identifier: String { String(describing: self) }
}
