import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: ItemsViewModel
    @State private var title = ""
    @State private var notes = ""
    @State private var showingAddSheet = false

    var body: some View {
        NavigationStack {
            List {
                if viewModel.items.isEmpty {
                    ContentUnavailableView(
                        "No items yet",
                        systemImage: "cart",
                        description: Text("Add household items you need to buy or replace.")
                    )
                } else {
                    ForEach(viewModel.items) { item in
                        ItemRow(item: item) {
                            viewModel.togglePurchased(for: item)
                        }
                    }
                    .onDelete(perform: viewModel.delete)
                    .onMove(perform: viewModel.move)
                }
            }
            .navigationTitle("House List")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Label("Add item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddItemView(title: $title, notes: $notes) {
                    viewModel.addItem(title: title, notes: notes)
                    title = ""
                    notes = ""
                    showingAddSheet = false
                } onCancel: {
                    title = ""
                    notes = ""
                    showingAddSheet = false
                }
            }
        }
    }
}

private struct ItemRow: View {
    let item: Item
    let onToggle: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: item.isPurchased ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(item.isPurchased ? Color.green : Color.secondary)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.headline)
                    .strikethrough(item.isPurchased, color: .green)

                if !item.notes.isEmpty {
                    Text(item.notes)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Text(item.createdAt, style: .date)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
    }
}

private struct AddItemView: View {
    @Binding var title: String
    @Binding var notes: String
    let onSave: () -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section("Item") {
                    TextField("Paper towels", text: $title)
                        .textInputAutocapitalization(.sentences)
                }

                Section("Notes") {
                    TextField("Brand, size, or store", text: $notes)
                }
            }
            .navigationTitle("Add Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: onSave)
                        .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ItemsViewModel())
}
