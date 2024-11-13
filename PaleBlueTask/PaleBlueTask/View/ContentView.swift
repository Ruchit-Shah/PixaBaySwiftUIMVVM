//
//  ContentView.swift
//  PaleBlueTask
//
//  Created by Shah Ruchit Bhadreshbhai on 04/10/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PhotoViewModel()

        let columns = [
            GridItem(.fixed(191)),
            GridItem(.fixed(191))
        ]

        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.photos) { photo in
                            HStack {
                                AsyncImage(url: URL(string: photo.previewURL)) { image in
                                    image
                                        .resizable()
                                        .clipShape(RoundedRectangle(cornerRadius: 5)) // Rounded corners
                                        .frame(width: 70,height: 70) // Fixed height for the image
                                } placeholder: {
                                    ProgressView()
                                }
                                VStack {
                                    Text("Author: \n\(photo.user)")
                                        .font(.system(size: 12, weight: .bold))
                                        .lineLimit(nil)
                                        .frame(maxWidth: .infinity)
                                    Spacer()
                                    Text("Photo ID: \n\(photo.id)")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundColor(.secondary)
                                        .lineLimit(nil)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                            .frame(height: 70)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3) //
                        }
                    }
                    .padding()
                    .onAppear {
                        if viewModel.photos.count < 16 {
                            viewModel.fetchPhotos()
                        }
                    }
                }
                .navigationTitle("Photos")
            }
        }
}

#Preview {
    ContentView()
}
