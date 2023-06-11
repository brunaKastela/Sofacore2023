import Foundation

protocol APICient {

    func getEvents(for slug: String, for date: String, completion: @escaping ([Event?], Error?) -> Void)

    func getIncidents(for id: Int, completion: @escaping ([BaseIncidentModel]?, Error?) -> Void)
}
