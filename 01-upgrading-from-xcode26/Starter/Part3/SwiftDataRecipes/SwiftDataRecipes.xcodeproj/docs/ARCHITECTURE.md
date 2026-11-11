# Architecture

## Goals
- Demonstrate SwiftData with model inheritance.
- Keep UI simple while showing specialized detail experiences.

## Data Model
- `Recipe` is the base SwiftData model and stores common fields (name, summary, instructions, ingredients).
- `BakedGood` extends `Recipe` with baking metadata (time, temperature).
- `Beverage` extends `Recipe` with serving metadata (style, temperature, caffeine, size).
- `Ingredient` is a child model owned by a recipe with a cascade delete rule.

## Data Flow
- `SampleData` creates an in-memory `ModelContainer` and inserts static fixtures.
- `ContentView` queries recipes via `@Query` and displays them in a list.
- `RecipeListView` routes to the correct detail view based on the runtime type.

## UI Composition
- `RecipeDetailView` presents a form-based layout for general recipes and baked goods.
- `BeverageDetailView` uses a scroll + card layout to emphasize beverage profiles.

## Notes
- SwiftData model inheritance requires iOS 26/macOS 26; update deployment targets accordingly.
