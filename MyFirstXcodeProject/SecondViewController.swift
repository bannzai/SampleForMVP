//
//  SecondViewController.swift
//  MyFirstXcodeProject
//
//  Created by kingkong999yhirose on 2017/07/17.
//  Copyright © 2017年 kingkong999yhirose. All rights reserved.
//

import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    var device: AVCaptureDevice!
    var session: AVCaptureSession!
    var output: AVCaptureVideoDataOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // セッションを生成
        session = AVCaptureSession()
        // バックカメラを選択
        for d in AVCaptureDevice.devices() {
            if (d as AnyObject).position == AVCaptureDevicePosition.back {
                device = d as? AVCaptureDevice
                print("\(device!.localizedName) found.")
            }
        }
        // バックカメラからキャプチャ入力生成
        let input: AVCaptureDeviceInput?
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch {
            print("Caught exception!")
            return
        }
        session.addInput(input)
        output = AVCaptureVideoDataOutput()
        session.addOutput(output)
        session.sessionPreset = AVCaptureSessionPresetPhoto
        // プレビューレイヤを生成
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer?.frame = view.bounds
        
        view.layer.addSublayer(previewLayer!)
        // セッションを開始
        session.startRunning()
        // 撮影ボタンを生成
        let button = UIButton()
        button.setTitle("撮影", for: .normal)
        button.contentMode = .center
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        button.backgroundColor = UIColor.blue
        //button.tintColor = UIColor.grayColor()
        //button.setTitleColor(UIColor.blue, for: UIControlState())
        button.layer.position = CGPoint(x: view.frame.width / 2, y: self.view.bounds.size.height - 80)
        button.addTarget(self, action: #selector(SecondViewController.shot(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shot(_ sender: AnyObject) {
        let connection = output.connection(withMediaType: AVMediaTypeVideo)
        let dispatch = DispatchQueue.main
        output.setSampleBufferDelegate(self, queue: dispatch)
    }
    
}

extension SecondViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        DispatchQueue.main.async {
            let image = self.imageFromSampleBuffer(sampleBuffer)  // サンプルバッファをUIImageに変換して
            print("image: \(image)")
        }
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didDrop sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        
    }
    
    func imageFromSampleBuffer(_ sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        CVPixelBufferLockBaseAddress(pixelBuffer, .readOnly)
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let bytesPerRow = CVPixelBufferGetBytesPerRow(pixelBuffer)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        guard let context = CGContext(data: baseAddress, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        guard let cgImage = context.makeImage() else {
            return nil
        }
        let image = UIImage(cgImage: cgImage, scale: 1, orientation:.right)
        CVPixelBufferUnlockBaseAddress(pixelBuffer, .readOnly)
        return image
    }
    
}

//class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    @IBOutlet weak var tableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .green
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        let nib = UINib(nibName: "SecondTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "Cell")
//        
//        tableView.reloadData()
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return 44
//        return UITableViewAutomaticDimension
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let second = cell as! SecondTableViewCell
//        second.titleLabel.text = "好きな文字列"
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(indexPath.section) : \(indexPath.row)")
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
