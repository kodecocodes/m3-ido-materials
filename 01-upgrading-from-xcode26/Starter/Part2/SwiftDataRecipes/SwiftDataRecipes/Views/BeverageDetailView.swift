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

/// A specialized detail experience for beverages with a profile-centric layout.
struct BeverageDetailView: View {
  var recipe: Beverage

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        header

        if !recipe.summary.isEmpty {
          summaryCard
        }

        if hasBeverageProfile {
          GroupBox("Brew Profile") {
            Grid(alignment: .leading, verticalSpacing: 8) {
              if let beverageStyle = recipe.beverageStyle {
                GridRow {
                  Text("Style")
                    .foregroundStyle(.secondary)
                  Text(beverageStyle)
                }
              }
              if let servingTemperature = recipe.servingTemperature {
                GridRow {
                  Text("Temperature")
                    .foregroundStyle(.secondary)
                  Text(temperatureTitle(for: servingTemperature))
                }
              }
              if let servingSizeOz = recipe.servingSizeOz {
                GridRow {
                  Text("Serving Size")
                    .foregroundStyle(.secondary)
                  Text("\(servingSizeOz, specifier: "%.0f") oz")
                }
              }
              if let caffeineMg = recipe.caffeineMg {
                GridRow {
                  Text("Caffeine")
                    .foregroundStyle(.secondary)
                  Text("\(caffeineMg) mg")
                }
              }
            }
          }
        }

        if !recipe.ingredients.isEmpty {
          GroupBox("Ingredients") {
            VStack(alignment: .leading, spacing: 8) {
              ForEach(recipe.ingredients) { ingredient in
                HStack {
                  Image(systemName: "drop.fill")
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
    }
  }

  /// Top banner showing the beverage name and quick tags.
  private var header: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(recipe.name)
        .font(.title.bold())
      HStack(spacing: 8) {
        Text("Beverage")
          .font(.caption.weight(.semibold))
          .padding(.horizontal, 10)
          .padding(.vertical, 4)
          .background(Color.accentColor.opacity(0.15), in: Capsule())
        if let servingTemperature = recipe.servingTemperature {
          Text(temperatureTitle(for: servingTemperature))
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color.orange.opacity(0.18), in: Capsule())
        }
      }
    }
  }

  /// Highlighted summary callout for quick context.
  private var summaryCard: some View {
    Text(recipe.summary)
      .font(.body)
      .padding(12)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
  }

  /// Controls whether the brew profile section should be shown.
  private var hasBeverageProfile: Bool {
    recipe.beverageStyle != nil
      || recipe.servingTemperature != nil
      || recipe.caffeineMg != nil
      || recipe.servingSizeOz != nil
  }

  /// Maps stored temperature values to human-friendly labels.
  private func temperatureTitle(for temperature: BeverageTemperature) -> String {
    switch temperature {
    case .hot:
      return "Hot"
    case .iced:
      return "Iced"
    case .blended:
      return "Blended"
    case .chilled:
      return "Chilled"
    case .room:
      return "Room"
    }
  }
}

#Preview {
  NavigationStack {
    BeverageDetailView(recipe: (Recipe.sampleData.first {
      $0 is Beverage
    } as? Beverage) ?? Beverage(name: "Sample Beverage"))
  }
}
