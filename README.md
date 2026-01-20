# HouseListApp

A simple SwiftUI iPhone app for two people to track household items they need.

## What this app includes
- Shared list of items with notes and timestamps.
- Quick add sheet with validation.
- Toggle items as purchased.
- Reorder and delete items.
- Local persistence using `UserDefaults`.

## How to run in Xcode
1. Open Xcode and create a new **iOS App** project named `HouseListApp`.
2. Replace the generated files with the contents of the `HouseListApp/` folder in this repo.
3. Run on an iPhone simulator.

## Next steps for sharing between you and your girlfriend
- Add iCloud sync using `CloudKit` so both phones stay in sync.
- Add reminders and push notifications for items that stay unpurchased.
- Add categories (cleaning, kitchen, bathroom) to organize the list.
