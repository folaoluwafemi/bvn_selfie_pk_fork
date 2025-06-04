// //
// //  BvnView.swift
// //  bvn_selfie_pk
// //
// //  Created by Confidence Wangoho on 20/06/2023.
// //

// import Foundation
// import Flutter
// import AVFoundation

// class BvnView:NSObject,FlutterPlatformView,AVCaptureVideoDataOutputSampleBufferDelegate
// {
//     let channel: FlutterMethodChannel
//     private var messenger:FlutterBinaryMessenger;
//     private var frame:CGRect;
//     private var viewId:Int64;
//     private var arguments:Any?;
//     private let captureSession = AVCaptureSession()
//     private let videoDataOutput = AVCaptureVideoDataOutput()
    
//     init(messenger: FlutterBinaryMessenger, frame: CGRect, viewId: Int64, arguments: Any? = nil) {
//         self.messenger = messenger
//         self.frame = frame
//         self.viewId = viewId
//         self.arguments = arguments
//         self.channel = FlutterMethodChannel(name: "bvn_selfie_pk", binaryMessenger: messenger)
//         super.init()
//         self.methodCallHandler();
//         self.startCameraProcess()
//         DispatchQueue.global(qos: .userInitiated).async {
//             self.captureSession.startRunning()
//         }
        
     
 
        
//     }
    
    
    
//     func view() -> UIView {
//        // let screenSize = UIScreen.main.bounds
//         let view = getPreviewView(frame: self.frame);
//         return view;
//     }
    
    
//     //start camera session
//     private func startCameraProcess(){
//         self.addCameraInput()
//         self.getCameraFrames();
//     }
    
//     //add camera input and select camera possition
//     private func addCameraInput() {
//         if #available(iOS 11.1, *) {
//             guard let device = AVCaptureDevice.DiscoverySession(
//                 deviceTypes: [.builtInDualCamera, .builtInTrueDepthCamera,.builtInWideAngleCamera],
//                 mediaType: .video,
//                 position: .front).devices.first else {
//                 invokeErrorHandler(error: "No back camera device found, please make sure to run SimpleLaneDetection in an iOS device and not a simulator");
//                 return;
                
//             }
//             let cameraInput = try! AVCaptureDeviceInput(device: device)
//             self.captureSession.addInput(cameraInput)
//         } else {
//             invokeErrorHandler(error: "Device Not Supported....")
//             return;
//         }
          
//        }
    
//     //function adding camera view to the UI
//     func getPreviewView(frame:CGRect)->UIView{
//         let view =  UIView(frame: frame)
//         let previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
//         previewLayer.videoGravity = .resizeAspectFill
//         previewLayer.videoGravity = .resizeAspectFill
//         view.layer.addSublayer(previewLayer)
//         previewLayer.frame = view.frame
        
//             return view;
//     }
    
//     //get the camera output frame and sending them to capture deletegate for processing
//     private func getCameraFrames(){
//             self.videoDataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString) : NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
//             self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
//             self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera_frame_processing_queue"))
//             self.captureSession.addOutput(self.videoDataOutput)
//         }
        
//    //capture delegete sends the output video buffers to MLKIT for processing
//     func captureOutput(
//            _ output: AVCaptureOutput,
//            didOutput sampleBuffer: CMSampleBuffer,
//            from connection: AVCaptureConnection) {
//            guard let frame = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//                debugPrint("unable to get image from sample buffer")
//                return
//            }
//                print(frame);
//            //self.detectFace(in: frame, sampleBuffer: sampleBuffer)
//        }
    
     
    
    
    
//     //handlers
    
//     func invokeErrorHandler(error:String){
//         channel.invokeMethod("onError", arguments: ["error",error])
//     }
//     func methodCallHandler(){
//         self.channel.setMethodCallHandler ({(call : FlutterMethodCall, result : @escaping FlutterResult)-> Void in
//             result(true)
            
//             })
//     }
// }
