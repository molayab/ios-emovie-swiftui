//
//  HomeView.swift
//  eMovie
//
//  Created by Mateo Olaya on 24/10/22.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel: HomeViewModel
    @State private var selection: String? = nil
    @State private var isShowingDateFilter: Bool = false
    @State private var isShowingLangFilter: Bool = false
    @State private var selectedYear: String = "2022"
    @State private var selectedLang: String = "ES"
    
    private func getExternalUrlImage(path: String?) -> String {
        return "https://image.tmdb.org/t/p/w500\(path ?? "")"
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Próximos estrenos")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                HCarouselView(
                    list: viewModel.upcomingList.map {
                    HCarouselView.Context(
                        id: $0.id,
                        posterUrl: getExternalUrlImage(
                            path: $0.posterPath),
                        title: $0.title)
                })
                
                Text("Tendencia")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                HCarouselView(
                    list: viewModel.trendingList.map {
                    HCarouselView.Context(
                        id: $0.id,
                        posterUrl: getExternalUrlImage(
                            path: $0.posterPath),
                        title: $0.title)
                })
                
                Text("Recomendado")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                HStack {
                    Group {
                        Button {
                            isShowingLangFilter.toggle()
                        } label: {
                            Text(selectedLang)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 16))
                                .padding(.all, 5)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2))
                        }
                        
                        Button {
                            isShowingDateFilter.toggle()
                        } label: {
                            Text(selectedYear)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .font(.system(size: 16))
                                .padding(.all, 5)
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 2))
                        }
                    }
                }
                LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 2)) {
                    ForEach(viewModel.recommendedList, id: \.title) { element in
                        NavigationLink(destination: {
                            DetailsView(viewModel: .init(id: element.id))
                        }, label: {
                            AsyncImage(url: URL(
                                string: getExternalUrlImage(
                                    path: element.posterPath))) { image in
                                image
                                .resizable()
                                .scaledToFill()
                            } placeholder: {
                                Color.purple.opacity(0.1)
                            }
                            .cornerRadius(20)
                            .frame(minHeight: 200)
                        })
                    }
                }
            }
            
            
        }
        .onChange(of: selectedLang, perform: { _ in
            execFetchDiscover()
        })
        .onChange(of: selectedYear, perform: { _ in
            execFetchDiscover()
        })
        .onAppear {
            execFetchDiscover()
            Task {
                await viewModel.fetchUpcoming()
            }
            Task {
                await viewModel.fetchTrending()
            }
        }
        .padding(.all)
        .background {
            Color.black.edgesIgnoringSafeArea(.all)
        }
        .alert("Select Year", isPresented: $isShowingDateFilter, actions: {
            // Any view other than Button would be ignored
            TextField("TextField", text: $selectedYear)
        })
        .alert("Select Language", isPresented: $isShowingLangFilter, actions: {
            // Any view other than Button would be ignored
            TextField("TextField", text: $selectedLang)
        })
        
    }
    
    private func execFetchDiscover() {
        Task {
            await viewModel.fetchDiscover(forLang: selectedLang, year: selectedYear)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            viewModel: HomeViewModel())
        .environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext)
    }
}
