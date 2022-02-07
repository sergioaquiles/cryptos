//
//  HomeView.swift
//  HomeView
//
//  Created by Sergio Cardoso on 21/08/21.
//

import SwiftUI

struct HomeView: View {
    
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortifolio = false //animate right
    @State private var showPortfolioView: Bool = false // new sheet
    @State private var showSettingsView: Bool = false // new sheet
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetailView: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            VStack {
                homeHeader
                
                HomeStatsView(showProtifolio: $showPortifolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                if !showPortifolio {
                    allcoinsList
                    .transition(.move(edge: .leading))
                }
                if showPortifolio {
                    ZStack(alignment: .top) {
                        if vm.portfolioCoins.isEmpty && vm.searchText.isEmpty {
                            Text("You haven't added any coins to your portfolio yet. Click the + button to get started! 🧐")
                                .font(.callout)
                                .foregroundColor(Color.theme.accent)
                                .multilineTextAlignment(.center)
                                .padding(50)
                        } else {
                            portfolioCoinsList
                        }
                    }
                    .transition(.move(edge: .trailing))
                }
                Spacer(minLength: 0)
            }
            .sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
        }
        .background(
            NavigationLink(isActive: $showDetailView, destination: {
                DetailLoadingView(coin: $selectedCoin)
            }, label: {
                EmptyView()
            })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
        .environmentObject(HomeViewModel())
    }
}

extension HomeView {
    
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortifolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortifolio {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortifolio)
                )
            Spacer()
            Text(showPortifolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.semibold)
                .animation(.none)
                .foregroundColor(Color.theme.accent)
                
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortifolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortifolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allcoinsList: some View {
        List{
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            .listRowBackground(Color.theme.background)
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
            .listRowBackground(Color.theme.background)
            
        }
        .listStyle(PlainListStyle())
        
    }
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var columnTitles: some View {
        HStack{
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            
            if showPortifolio{
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .PriceReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .price ? .PriceReversed : .price
                }
            }
            
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    vm.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
    
}

