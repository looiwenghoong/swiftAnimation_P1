//
//  nextViewController.swift
//  CADisplayLink
//
//  Created by looiwenghoong on 19/09/2018.
//  Copyright © 2018 looiwenghoong. All rights reserved.
//
//  Tutorial for CAAnimation and CAShapeLayer

import UIKit

class nextViewController: UIViewController, URLSessionDownloadDelegate {
    
    //  Create the calayer shapeobject
    var shapelayer: CAShapeLayer!
    
    var pulsingLayer: CAShapeLayer!
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Start"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        return label
    }()
    
    private func setupNotificationObserver()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(handleEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func handleEnterForeground()
    {
        animatePulsatingLayer()
    }
    
    private func createCircle(strokeColor: UIColor, fillColor: UIColor) -> (CAShapeLayer)
    {
        let layer = CAShapeLayer()
        
        //  the path and the specifications of drawing out the shape
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 10
        layer.fillColor = fillColor.cgColor
        layer.position = view.center
        
        return layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNotificationObserver()
        
        pulsingLayer = createCircle(strokeColor: .clear, fillColor: .blue)
        view.layer.addSublayer(pulsingLayer)
        
        animatePulsatingLayer()
        
        // Customization for the hidden layer of the arc
        let hiddenLayer = createCircle(strokeColor: .lightGray, fillColor: .clear) // Hidden layer of the shape
        view.layer.addSublayer(hiddenLayer)
    
        // Customization for the outer layer of the arc
        shapelayer = createCircle(strokeColor: .red, fillColor: .clear)
        shapelayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        view.layer.addSublayer(shapelayer)
        
        // add gesture recogizer to the view so that upon tapping the screen, some kind of action can be added into the view
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        view.addSubview(percentageLabel)
        percentageLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        percentageLabel.center = view.center
    }
    
    // function to create animation and bind the animation to the shape
    private func animatePulsatingLayer()
    {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.3
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsingLayer.add(animation, forKey: "pulsating")
    }
    
    //  1. Define the url string to obtain the download file
    let urlString = "https://firebasestorage.googleapis.com/v0/b/firestorechat-e64ac.appspot.com/o/intermediate_training_rec.mp4?alt=media&token=e20261d0-7219-49d2-b32d-367e1606500c"
    
    private func downloadTask()
    {
        print("Attempting to download file")
        
        shapelayer.strokeEnd = 0
        
        let configuration = URLSessionConfiguration.default
        let delagateQueue = OperationQueue()
        // 2. Establish a urlsession and configure to the download protocol
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: delagateQueue)
        
        guard let url = URL(string: urlString) else { return }
        //3. Create a download task with the session
        let downloadTask = session.downloadTask(with: url)
        
        //4. resume the download task
        downloadTask.resume()
    }
    
    // This function is a compulsory function that needs to be called to conform to the delagate protocol.
    // This function will be called when the file is finish downloaded
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finish downloading file")
    }
    
    //  This is another function in download delegte protocol that allows us to know the downloaded bytes and the bytes need to be downloaded(the total size of the file)
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        print(totalBytesWritten, totalBytesExpectedToWrite, "\(percentage)")
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapelayer.strokeEnd = percentage
        }
    }
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapelayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc func handleTap()
    {
        downloadTask()
    }
}
