import Foundation

enum Preferences {

    private static let selectedIndexKey = "selectedIndexKey"

    static var selectedIndex: Int {
        get { UserDefaults.standard.integer(forKey: Preferences.selectedIndexKey) }
        set(newIndex) {
            UserDefaults.standard.set(newIndex, forKey: Preferences.selectedIndexKey)
        }
    }
}
