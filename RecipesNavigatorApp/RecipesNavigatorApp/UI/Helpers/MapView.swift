//
//  MapView.swift
//  RecipesNavigatorApp
//
//  Created by sdykae on 10/27/23.
//

import MapKit
import Recipes
import SwiftUI

struct MapView: View {
  var location: RecipeDetails.Location
  struct MapAnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
  }

  var mapAnnotation: MapAnnotationItem {
    MapAnnotationItem(coordinate: CLLocationCoordinate2D(
      latitude: location.latitude,
      longitude: location.longitude))
  }

  @State private var region: MKCoordinateRegion

  init(location: RecipeDetails.Location) {
    self.location = location
    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)

    _region = State(initialValue: MKCoordinateRegion(
      center: coordinate,
      span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
  }

  var body: some View {
    Map(coordinateRegion: $region, annotationItems: [mapAnnotation]) { item in
      MapPin(coordinate: item.coordinate, tint: .blue)
    }
    .edgesIgnoringSafeArea(.all)
  }
}
