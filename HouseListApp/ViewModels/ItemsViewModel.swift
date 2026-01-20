import Foundation

@MainActor
final class ItemsViewModel: ObservableObject {
    @Published private(set) var items: [Item] = []

    private let storageKey = "house_list_items"

    init() {
        load()
    }

    func addItem(title: String, notes: String) {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else { return }

        let newItem = Item(title: trimmedTitle, notes: notes)
        items.insert(newItem, at: 0)
        save()
    }

    func togglePurchased(for item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        items[index].isPurchased.toggle()
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
        save()
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to save items: \(error)")
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }

        do {
            items = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print("Failed to load items: \(error)")
            items = []
        }
    }
}
