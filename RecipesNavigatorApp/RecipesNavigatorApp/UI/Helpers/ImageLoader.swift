//
//  ImageLoader.swift
//  RecipesNavigatorApp
//
//  Created by sdykae on 10/27/23.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
  @Published var image: UIImage?
  private var cancellable: AnyCancellable?

  func load(fromURLString urlString: String) {
    guard let url = URL(string: urlString) else { return }
    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] in self?.image = $0 }
  }

  func cancel() {
    cancellable?.cancel()
  }
}

struct AsyncImageView: View {
  @StateObject private var loader = ImageLoader()
  let placeholder: Image
  let urlString: String

  var body: some View {
    Group {
      if let image = loader.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFit()
      } else {
        placeholder
      }
    }
    .onAppear { loader.load(fromURLString: urlString) }
    .onDisappear { loader.cancel() }
  }
}
