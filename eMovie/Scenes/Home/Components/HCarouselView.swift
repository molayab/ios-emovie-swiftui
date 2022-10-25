//
//  ContentView.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import SwiftUI

struct HCarouselView: View {
    struct Context {
        var id: Int
        var posterUrl: String
        var title: String
    }
    
    var list: [Context]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(list, id: \.title) { element in
                    NavigationLink(destination: {
                        DetailsView(viewModel: .init(id: element.id))
                    }, label: {
                        VStack {
                            AsyncImage(url: URL(string: element.posterUrl)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .frame(width: 250, height: 350)
                            .cornerRadius(20)
                        }
                    })
                }
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
