import Foundation

struct DateFormatters {
    static let `default` = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
        return dateFormatter
    }()
}
