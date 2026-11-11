///// Copyright (c) 2026 Kodeco Inc.
/////
///// Permission is hereby granted, free of charge, to any person obtaining a copy
///// of this software and associated documentation files (the "Software"), to deal
///// in the Software without restriction, including without limitation the rights
///// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
///// copies of the Software, and to permit persons to whom the Software is
///// furnished to do so, subject to the following conditions:
/////
///// The above copyright notice and this permission notice shall be included in
///// all copies or substantial portions of the Software.
/////
///// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
///// distribute, sublicense, create a derivative work, and/or sell copies of the
///// Software in any work that is designed, intended, or marketed for pedagogical or
///// instructional purposes related to programming, coding, application development,
///// or information technology.  Permission for such use, copying, modification,
///// merger, publication, distribution, sublicensing, creation of derivative works,
///// or sale is expressly withheld.
/////
///// This project and source code may use libraries or frameworks that are
///// released under various Open-Source licenses. Use of those libraries and
///// frameworks are governed by their own individual licenses.
/////
///// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
///// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
///// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
///// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
///// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
///// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
///// THE SOFTWARE.

import SwiftUI
import SwiftData

/// Root view hosting the recipe list.
struct ContentView: View {
  @Environment(\.modelContext)
  private var modelContext

  var body: some View {
    NavigationSplitView(sidebar: { RecipeListView() }, detail: { RecipeDetailView(recipe: nil) })
      .task {
        for recipe in Recipe.sampleData {
          modelContext.insert(recipe)
        }
      }
  }
}

/// List of recipes sourced from SwiftData.
struct RecipeListView: View {
  @Environment(\.modelContext)
  private var modelContext

  @Query(sort: \Recipe.name, order: .forward)
  var recipes: [Recipe]

  var body: some View {
    List {
      ForEach(recipes) { recipe in
        NavigationLink(destination: detailView(for: recipe)) {
          Text(recipe.name)
        }
      }
      .onDelete(perform: deleteRecipes)
    }
    .navigationTitle("Swift Recipes")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        EditButton()
      }
      ToolbarItem {
        Button(action: addRecipe) {
          Label("Add Recipe", systemImage: "plus")
        }
      }
    }
  }

  /// Creates a new, blank recipe entry.
  private func addRecipe() {
    withAnimation {
      let newRecipe = Recipe(name: "New Recipe")
      modelContext.insert(newRecipe)
    }
  }

  /// Deletes recipes from the list and model context.
  private func deleteRecipes(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(recipes[index])
      }
    }
  }

  /// Routes to the appropriate detail view based on recipe type.
  @ViewBuilder
  private func detailView(for recipe: Recipe) -> some View {
    if let beverage = recipe as? Beverage {
      BeverageDetailView(recipe: beverage)
    } else {
      RecipeDetailView(recipe: recipe)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .modelContainer(SampleData.shared.modelContainer)
  }
}
