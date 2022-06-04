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
                Text("All products including Taxes 2022")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 10)
            let data: BarChartData = StartsData()
            BarChart(chartData: data)
                        .xAxisGrid(chartData: data)
                        .yAxisGrid(chartData: data)
                        .xAxisLabels(chartData: data)
                        .yAxisLabels(chartData: data, colourIndicator: .custom(colour: ColourStyle(colour: .red), size: 12))
                        .headerBox(chartData: data)
                        .id(data.id)
                        .frame(minWidth: 150, maxWidth: 900, minHeight: 50, idealHeight: 250, maxHeight: 400, alignment: .center)
                        .accessibilityElement(children: .combine)
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
        for month in startsService.ordervalue {
            startsData.append(BarChartDataPoint(value: Double(month.sum), xAxisLabel: month.monthName, colour: ColourStyle(colour: .red)))
        }
        let sets = BarDataSet(dataPoints: startsData)
        let data: BarDataSet = sets
        let metadata = ChartMetadata(title: "", subtitle: "")
        let gridStyle = GridStyle(numberOfLines: 7,
                                       lineColour: Color(.lightGray).opacity(0.5),
                                       lineWidth: 2)
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
}

struct chart_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
