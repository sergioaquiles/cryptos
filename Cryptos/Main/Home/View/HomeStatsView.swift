//
//  HomeStatsView.swift
//  HomeStatsView
//
//  Created by Sergio Cardoso on 25/08/21.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showProtifolio: Bool
    
  
    
    var body: some View {
        HStack{
            ForEach(vm.statistics) {stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showProtifolio ? .trailing : .leading)
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showProtifolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
