//
//  ProgressViewController.swift
//  Myotera
//
//  Created by Sahil Gupta on 12/3/20.
//

import UIKit
import ScrollableGraphView

class ProgressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Compose the graph view by creating a graph, then adding any plots
    // and reference lines before adding the graph to the view hierarchy.
    let graphView = ScrollableGraphView(frame: self(), dataSource: self)

    let linePlot = LinePlot(identifier: "line") // Identifier should be unique for each plot.
    let referenceLines = ReferenceLines()

    graphView.addPlot(plot: linePlot)
    graphView.addReferenceLines(referenceLines: referenceLines)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK: - ScrollableGraphViewDelegate
extension ProgressViewController: ScrollableGraphViewDataSource {
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        <#code#>
    }
    
    func label(atIndex pointIndex: Int) -> String {
        <#code#>
    }
    
    func numberOfPoints() -> Int {
        <#code#>
    }
    
    
}
