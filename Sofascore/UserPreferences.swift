import Foundation

enum UserPreferences {

    private static let selectedIndexKey = "selectedIndexKey"
    private static let selectedDateIndexKey = "selectedDateIndexKey"

    static var selectedIndex: Int {
        get { UserDefaults.standard.integer(forKey: UserPreferences.selectedIndexKey) }
        set { UserDefaults.standard.set(newValue, forKey: UserPreferences.selectedIndexKey) }
    }

    static var selectedDateIndex: Any? {
        get { UserDefaults.standard.value(forKey: UserPreferences.selectedDateIndexKey) }
        set { UserDefaults.standard.set(newValue, forKey: UserPreferences.selectedDateIndexKey) }
    }

}
