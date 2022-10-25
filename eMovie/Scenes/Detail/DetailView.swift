//
//  DetailView.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.movie?.title ?? "")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            HStack {
                Text(viewModel.movie?.releaseDate.prefix(4) ?? "")
                    .foregroundColor(.black)
                    .padding(.all, 5)
                    .background {
                        Color.white
                    }
                    .cornerRadius(5)
                Text(viewModel.movie?.lang.uppercased() ?? "")
                    .foregroundColor(.black)
                    .padding(.all, 5)
                    .background {
                        Color.white
                    }
                    .cornerRadius(5)
                Text(String(format: "%.1f", viewModel.movie?.voteAverage ?? 0))
                    .foregroundColor(.black)
                    .padding(.all, 5)
                    .background {
                        Color.yellow
                    }
                    .cornerRadius(5)
            }
            HStack {
                ForEach(viewModel.movie?.genres ?? [], id: \.name) { element in
                    Text(element.name.lowercased())
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.vertical)
                }
            }
            Button {
                Task {
                    await viewModel.showTrailer()
                }
            } label: {
                Text("Ver Trailer")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 2))
            }
            .padding(.vertical)
            
            Text(viewModel.movie?.overview ?? "")
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .padding(.all)
        .background {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(viewModel.movie?.backdropPath ?? String())")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            } placeholder: {
                Color.purple.opacity(0.1)
            }
            .blur(radius: 5)
            .opacity(0.85)
            .background(Color.black)
        }
        .onAppear {
            Task {
                await viewModel.fetch()
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: .init(id: 717728))
        .environment(\.managedObjectContext,
             PersistenceController.preview.container.viewContext)
    }
}
