import Foundation

struct Item: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var notes: String
    var isPurchased: Bool
    var createdAt: Date

    init(id: UUID = UUID(), title: String, notes: String = "", isPurchased: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.notes = notes
        self.isPurchased = isPurchased
        self.createdAt = createdAt
    }
}
