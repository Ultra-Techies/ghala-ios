//
//  chart.swift
//  Ghala
//
//  Created by mroot on 01/06/2022.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    @ObservedObject var startsService = StartsService()
    var body: some View {
        VStack {
            Form {
                //Bar Chart
                Section(header: Text("All products including Taxes 2022")) {
                    let data: BarChartData = StartsData()
                    BarChart(chartData: data)
                                .xAxisGrid(chartData: data)
                                .yAxisGrid(chartData: data)
                                .xAxisLabels(chartData: data)
                                .yAxisLabels(chartData: data, colourIndicator: .custom(colour: ColourStyle(colour: .red), size: 12))
                                .headerBox(chartData: data)
                                .id(data.id)
                                .frame(minWidth: 150, maxWidth: 900, minHeight: 100, idealHeight: 250, maxHeight: 500, alignment: .center)
                                .accessibilityElement(children: .combine)
                }
                //Pie Chart
                Section(header: Text("Warehouse Statistics")) {
                    let data: PieChartData = makeData()
                    PieChart(chartData: data)
                                    .touchOverlay(chartData: data)
                                    .headerBox(chartData: data)
                                    .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                                    .frame(minWidth: 150, maxWidth: 900, minHeight: 50, idealHeight: 250, maxHeight: 400, alignment: .center)
                                    .id(data.id)
                                    .padding(.horizontal)
                }
            }
        }.task {
            await startsData()
        }
    }
    // MARK: - Get Starts
    func startsData() async {
        do {
            try await startsService.getStarts()
        } catch {
            print(error)
        }
    }
    // MARK: - Bar Chart
    func StartsData() -> BarChartData {
        var startsData = [BarChartDataPoint]()
        //loop through months
        for month in startsService.start.orderValue {
            startsData.append(BarChartDataPoint(value: Double(month.sum), xAxisLabel: month.monthName, colour: ColourStyle(colour: .red)))
        }
        let sets = BarDataSet(dataPoints: startsData)
        let data: BarDataSet = sets
        let metadata = ChartMetadata(title: "", subtitle: "")
        let gridStyle = GridStyle(numberOfLines: 7,
                                       lineColour: Color(.lightGray).opacity(0.2),
                                  lineWidth: 1.5)
        let chartStyle = BarChartStyle(infoBoxPlacement: .header,
                                           markerType: .bottomLeading(),
                                           xAxisGridStyle: gridStyle,
                                           xAxisLabelPosition: .bottom,
                                           xAxisLabelsFrom: .dataPoint(rotation: .degrees(0)),
                                           xAxisTitle: "Orders",
                                           yAxisGridStyle: gridStyle,
                                           yAxisLabelPosition: .leading,
                                           yAxisNumberOfLabels: 2,
                                           yAxisTitle: "Sales",
                                           baseline: .zero,
                                           topLine: .maximumValue)
        return BarChartData(dataSets: data,
                                metadata: metadata,
                                xAxisLabels: ["One"],
                               barStyle: BarStyle(barWidth: 0.3,
                                                   cornerRadius: CornerRadius(top: 50, bottom: 0),
                                                   colourFrom: .dataPoints,
                                                   colour: ColourStyle(colour: .blue)),
                                chartStyle: chartStyle)
        }
    // MARK: - Pie Chart
    func makeData() -> PieChartData {
        let invValue = Double(startsService.start.inventoryValue)
        let total = addOrder()
        print("Total: \(total)")
        
           let data = PieDataSet(
               dataPoints: [
                   PieChartDataPoint(value: 20, description: "Order",   colour: .red  , label: .icon(systemName: "", colour: .white, size: 20)),
                   PieChartDataPoint(value: invValue, description: "Inventory",   colour: .blue   , label: .icon(systemName: "", colour: .white, size: 80)),
               ],
               legendTitle: "Data")
           
           return PieChartData(dataSets: data,
                               metadata: ChartMetadata(title: "Inventory vs Orders", subtitle: ""),
                               chartStyle: PieChartStyle(infoBoxPlacement: .header))
       }
    
    // MARK: TO-DO (Add sum and return the value as Int) -> Int
    func addOrder() -> Int {
        var total: Int = 0
        for orderSum in startsService.ordervalue {
            print("Total sum: \(orderSum.sum)")
            total = orderSum.sum
        }
        return total
    }
}

struct chart_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
