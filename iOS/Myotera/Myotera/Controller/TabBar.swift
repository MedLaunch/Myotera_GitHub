//
//  TabBar.swift
//  Myotera
//
//  Created by Sahil Gupta on 2/17/21.
//

import UIKit





class TabBar: UITabBar {
    @IBOutlet var recordButton: UIButton!
    
    private var middleButton = UIButton()

        override func awakeFromNib() {
            super.awakeFromNib()
            setupRecordButton()
        }

        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            if self.isHidden {
                return super.hitTest(point, with: event)
            }
            
            let from = point
            let to = recordButton.center

            return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 39 ? middleButton : super.hitTest(point, with: event)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            recordButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        }

    func setupRecordButton() {
//        recordButton.frame.size = CGSize(width: 70, height: 70)
//        recordButton.backgroundColor = .blue
//        recordButton.layer.cornerRadius = 35
        recordButton.layer.masksToBounds = true
//        recordButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
        recordButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        addSubview(recordButton)
    }
//        func setupRecordButton() {
//            middleButton.frame.size = CGSize(width: 70, height: 70)
//            middleButton.backgroundColor = .blue
//            middleButton.layer.cornerRadius = 35
//            middleButton.layer.masksToBounds = true
//            middleButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 0)
//            middleButton.addTarget(self, action: #selector(test), for: .touchUpInside)
//            addSubview(middleButton)
//        }
    
    
    @IBAction func test() {
        print("my name is jeff")
    }

    
    
    
    
    
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
