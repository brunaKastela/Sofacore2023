import Foundation

enum UserPreferences {

    private static let selectedIndexKey = "selectedIndexKey"

    static var selectedIndex: Int {
        get { UserDefaults.standard.integer(forKey: UserPreferences.selectedIndexKey) }
        set { UserDefaults.standard.set(newValue, forKey: UserPreferences.selectedIndexKey) }
    }

}
