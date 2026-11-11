# SwiftDataRecipes

A small SwiftUI sample app that demonstrates SwiftData with recipe models, inheritance, and tailored detail views.

## Requirements
- Xcode 16+
- iOS 26.0 / macOS 26.0 deployment target (required for SwiftData model inheritance)

## Build & Run
1. Open `SwiftDataRecipes.xcodeproj` in Xcode.
2. Select the `SwiftDataRecipes` scheme.
3. Build and run on an iOS 26+ simulator/device or macOS 26+ target.

## Project Overview
- **Models**: `Recipe` is the base model; `BakedGood` and `Beverage` inherit from it.
- **Data**: `SampleData` seeds an in-memory container for previews.
- **UI**: `RecipeDetailView` is the default detail; `BeverageDetailView` is a specialized experience for beverages.

## Documentation
See `docs/ARCHITECTURE.md` for a concise architecture and data flow overview.
