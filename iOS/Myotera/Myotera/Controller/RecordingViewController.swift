//
//  RecordingViewController.swift
//  Myotera
//
//  Created by Sahil Gupta on 2/20/21.
//

import UIKit
import MovesenseApi


class RecordingViewController: UIViewController {
    
    @IBOutlet weak var recordingOrError: UILabel!
    
    var sensorsGood = true;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (sensorsGood) {
            recordingOrError.text = "Recording..."
        }
        else {
            recordingOrError.text = "Not enough sensors connected!"
        }
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
