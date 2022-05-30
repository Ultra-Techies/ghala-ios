//
//  MainView.swift
//  Ghala
//
//  Created by mroot on 15/05/2022.
//

import SwiftUI
import SwiftUICharts

struct MainView: View {
    @ObservedObject var user: User
    @ObservedObject var userService =  UserService()
    @ObservedObject var startsService = StartsService()
   // @Binding var showDrawerMenu: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
//                Button {
//                    self.showDrawerMenu = true
//                } label: {
//                    Image(systemName: "rectangle.grid.1x2")
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .foregroundColor(.black)
//                }
                Spacer()
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
            }.padding(.horizontal, 20)
            HStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Hello,")
                        .fontWeight(.light)

                    Text("\(userService.us.firstName) \(userService.us.lastName)")
                        .bold()
                }
            } .padding(.horizontal, 20)
                .onAppear {
                    let p = user.phoneNumber
                    print(p)
                    Task {
                        try await userService.findByPhone(user:user)
                    }
                }
            Spacer()
            //Bar Grapgh
            VStack {
                ForEach(startsService.ordervalue, id: \.self) { month in
//                    BarChartView(data: ChartData(values: [
//                        ("jan", 15)
//                            ]), title: "Bar Graph")
                    BarChartView(data: ChartData(values: [
                        ("Jan",0),
                        ("Feb",0),
                        ("Mar",0),
                        ("Apr",0),
                        (month.monthName, month.month),
                        ("June",0),
                        ("jUl",0),
                        ("Aug",0),
                        ("Sep",0),
                        ("Oct",0),
                        ("Nov",0),
                        ("Dec",0),
                    ]), title: month.yearName)
                }
            }
            Spacer()
        }.task {
            await startsData()
        }
    }
    func startsData() async {
        do {
            try await startsService.getStarts()
        } catch {
            print(error)
        }
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(user: User(), showDrawerMenu: true)
//    }
//}
