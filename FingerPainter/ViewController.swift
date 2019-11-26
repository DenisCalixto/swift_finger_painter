//
//  ViewController.swift
//  FingerPainter
//
//  Created by Denis Calixto on 11/25/19.
//  Copyright © 2019 Langara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvas: UIImageView!
    
    var start: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            start = touch.location(in: view)
        }
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let point = touch.location(in: view)
//            print(point)
//        }
//    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let end = touch.location(in: view)
            if let start = self.start {
                draw(from: start, to: end)
            }
            start = end
        }
    }
    
    func draw(from point: CGPoint, to end: CGPoint) {
        UIGraphicsBeginImageContext(canvas.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            canvas.image?.draw(in: CGRect(x:0,
                                          y: 0,
                                          width: canvas.frame.size.width,
                                          height: canvas.frame.size.height))
            context.setLineWidth(5)
            context.setStrokeColor(UIColor.magenta.cgColor)
            context.beginPath()
            context.move(to: CGPoint(x: point.x, y: point.y))
            context.addLine(to: CGPoint(x: end.x, y: end.y))
            context.strokePath()
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            canvas.image = newImage
        }
    }

    @IBAction func clearButtonTapped(_ sender: UIBarButtonItem) {
        canvas.image = nil
    }
}

