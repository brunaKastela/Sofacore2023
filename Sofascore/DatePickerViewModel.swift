import Foundation

class DatePickerViewModel {

    var dates: [DatePickerModel] = []

    init() {
        dates = makeDates(around: Date(), for: 1)
    }

    func makeDates(around referenceDate: Date, for weeks: Int) -> [DatePickerModel] {
        let calendar = Calendar.current

        var datePickerModels: [DatePickerModel] = []

        let dayRange = -weeks * 7 ... weeks * 7

        for dayOffset in dayRange {
            guard
                let currentDate = calendar.date(byAdding: .day, value: dayOffset, to: referenceDate)
            else { continue }

            datePickerModels.append(DatePickerModel(with: currentDate))

        }

        return datePickerModels
    }

}

private extension DatePickerModel {

    init(with date: Date) {
        let isToday = Calendar.current.isDate(date, inSameDayAs: Date())

        let dayOfWeekFormatter = DateFormatter()
        dayOfWeekFormatter.dateFormat = "EEE"

        let dayAndMonthFormatter = DateFormatter()
        dayAndMonthFormatter.dateFormat = "dd.MM."

        let dayOfWeek = isToday ? .localized(.today) : dayOfWeekFormatter.string(from: date)
        let dayAndMonth = dayAndMonthFormatter.string(from: date)

        self.init(date: date, dayOfWeek: dayOfWeek.uppercased(), dayAndMonth: dayAndMonth)
    }

}
