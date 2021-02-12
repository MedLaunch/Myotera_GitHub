//
//  ProgressViewController.swift
//  Myotera
//
//  Created by Sahil Gupta on 12/3/20.
//

import UIKit
import ScrollableGraphView

class ProgressViewController: UIViewController, ScrollableGraphViewDataSource {
    
    var linePlotData: [Double] = [0, 1, 2, 3, 4, 5, 3, 5, 3, 5]
    var graphView = ScrollableGraphView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot.
    var referenceLines = ReferenceLines()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        graphView.dataSource = self
        self.view.addSubview(graphView)

        
    }
    
    // Compose the graph view by creating a graph, then adding any plots
    // and reference lines before adding the graph to the view hierarchy.
//    graphView.addPlot(plot: linePlot)
//    graphView.addReferenceLines(referenceLines: referenceLines)
    
    
    
    //MARK: - ScrollableGraphViewDelegate
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
            case "line":
                return linePlotData[pointIndex]
            default:
                return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "FEB \(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return linePlotData.count
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


