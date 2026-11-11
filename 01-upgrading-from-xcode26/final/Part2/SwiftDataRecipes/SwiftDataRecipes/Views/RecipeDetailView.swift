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

/// Default recipe detail view used for non-beverage recipes.
struct RecipeDetailView: View {
  var recipe: Recipe?

  var body: some View {
    ScrollView {
      if let recipe = recipe {
        VStack(alignment: .leading, spacing: 16) {
          header

          if !recipe.summary.isEmpty {
            summaryCard
          }

          if !recipe.ingredients.isEmpty {
            GroupBox("Ingredients") {
              VStack(alignment: .leading, spacing: 8) {
                ForEach(recipe.ingredients) { ingredient in
                  HStack {
                    Image(systemName: "list.bullet.clipboard")
                      .foregroundStyle(.secondary)
                    Text(ingredient.name)
                    Spacer()
                    Text(ingredient.amount)
                      .foregroundStyle(.secondary)
                  }
                }
              }
            }
          }

          if !recipe.instructions.isEmpty {
            GroupBox("Method") {
              Text(recipe.instructions)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
          }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
      } else {
        ContentUnavailableView("Choose a recipe", systemImage: "book")
      }
    }
  }

  /// Top banner showing the beverage name and quick tags.
  private var header: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(recipe?.name ?? "No recipe selected.")
        .font(.title.bold())
      HStack(spacing: 8) {
        Text(LocalizedStringResource(stringLiteral: "\(type(of: recipe!))")) // force unwrapping for ease here
          .font(.caption.weight(.semibold))
          .padding(.horizontal, 10)
          .padding(.vertical, 4)
          .background(Color.accentColor.opacity(0.15), in: Capsule())
      }
    }
  }

  /// Highlighted summary callout for quick context.
  private var summaryCard: some View {
    Text(recipe?.summary ?? "No Summary available.")
      .font(.body)
      .padding(12)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
  }
}

#Preview {
  NavigationStack {
    RecipeDetailView(recipe: Recipe.sampleData[0])
  }
}
