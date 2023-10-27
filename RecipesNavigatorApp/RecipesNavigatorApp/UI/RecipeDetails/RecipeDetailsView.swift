//
//  RecipeDetailsView.swift
//  RecipesNavigatorApp
//
//  Created by sdykae on 10/26/23.
//

import MapKit
import Recipes
import SwiftUI

struct RecipeDetailsView: View {
  @ObservedObject var viewModel: RecipeDetailsViewModel
  @State private var isNavigationActive = false
  private let imageWidth: CGFloat = 320
  private let imageHeight: CGFloat = 240
  var body: some View {
    ScrollView {
      if let recipe = viewModel.recipeDetails {
        VStack(alignment: .leading, spacing: 20) {
          AsyncImageView(
            placeholder: Image(systemName: "photo"),
            urlString: recipe.imageURL)
            .scaledToFit()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(10)
            .shadow(radius: 10)

          Text(recipe.name)
            .font(.largeTitle)
            .fontWeight(.bold)

          // Ingredients Section
          Group {
            Text("Ingredients")
              .font(.headline)
              .fontWeight(.medium)

            ForEach(recipe.ingredients, id: \.self) { ingredient in
              Text("• \(ingredient.quantity) \(ingredient.name)")
                .font(.subheadline)
            }
          }

          Group {
            Text("Steps")
              .font(.headline)
              .fontWeight(.medium)

            ForEach(recipe.steps.indices, id: \.self) { index in
              Text("\(index + 1). \(recipe.steps[index])")
                .font(.subheadline)
            }
          }

          NavigationLink(
            destination: MapView(location: recipe.location),
            isActive: $isNavigationActive,
            label: {
              EmptyView()
            })

          // Action Button
          Button(action: {
            isNavigationActive = true
          }) {
            Text("Show on Map")
              .fontWeight(.semibold)
              .font(.headline)
              .frame(minWidth: 0, maxWidth: .infinity)
              .padding()
              .foregroundColor(.white)
              .background(Color.blue)
              .cornerRadius(10)
          }

          Spacer()
        }
        .padding()
      } else if viewModel.isLoading {
        ProgressView("Loading...")
      } else {
        // Error state handling
        VStack {
          Image(systemName: "xmark.octagon.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 64, height: 64)
            .foregroundColor(.red)

          Text("An error occurred")
            .font(.headline)

          Button(action: {
            viewModel.fetchRecipeDetails()
          }) {
            Text("Retry")
          }
          .padding(.top, 10)
        }
      }
    }
    .onAppear(perform: viewModel.fetchRecipeDetails)
  }

  private func openMapForLocation(recipe: RecipeDetails) {
    let regionDistance: CLLocationDistance = 10000
    let coordinates = CLLocationCoordinate2DMake(recipe.location.latitude, recipe.location.longitude)
    let regionSpan = MKCoordinateRegion(
      center: coordinates,
      latitudinalMeters: regionDistance,
      longitudinalMeters: regionDistance)
    let options = [
      MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
      MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
    ]
    let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = recipe.name
    mapItem.openInMaps(launchOptions: options)
  }
}
