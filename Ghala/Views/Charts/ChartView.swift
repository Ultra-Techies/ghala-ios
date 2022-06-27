//
//  chart.swift
//  Ghala
//
//  Created by mroot on 01/06/2022.
//

import SwiftUI
import SwiftUICharts

struct ChartView: View {
    @StateObject var startsViewModel = StartsViewModel(startsService: StartsService())
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
            await startsViewModel.getStarts()
        }
        .alert(startsViewModel.errorMsg, isPresented: $startsViewModel.showAlert) {}
    }
    // MARK: - Bar Chart
    func StartsData() -> BarChartData {
        var startsData = [BarChartDataPoint]()
        //loop through months
        for month in startsViewModel.starts.orderValue {
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
        let invValue = Double(startsViewModel.starts.inventoryValue)
        let orderValue = Double(startsViewModel.totalSum())

           let data = PieDataSet(
               dataPoints: [
                PieChartDataPoint(value: orderValue, description: "Order", colour: .red),
                PieChartDataPoint(value: invValue, description: "Inventory", colour: .blue)
               ],
               legendTitle: "Data")

           return PieChartData(dataSets: data,
                               metadata: ChartMetadata(title: "Inventory vs Orders", subtitle: ""),
                               chartStyle: PieChartStyle(infoBoxPlacement: .header))
       }
}

struct chart_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
