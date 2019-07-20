//
//  NewRecordingViewController.swift
//  zayli
//
//  Created by rshier on 16/07/19.
//  Copyright © 2019 rshier. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import RealmSwift
import FloatingPanel

class NewRecordingViewController: UIViewController, AVAudioRecorderDelegate {
    private let recordId: String = UUID().uuidString
    private var audioPath: URL!
    private var fpc: FloatingPanelController!
    private var recordingState: audioState = .stopped {
        didSet {
            updateRecordingState()
        }
    }
    
    enum audioState {
        case recording
        case stopped
    }
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var recordingButton: MyPrettyDesignableButton!
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func doneAction(_ sender: Any) {
        
        let record = Record()
        record.id = recordId
        record.resource = audioPath.absoluteString
        
        let practice = Realm.shared.object(
            ofType: Practice.self,
            forPrimaryKey: getTempId())
        
        try! Realm.shared.write {
            practice?.records.append(record)
        }

        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var recordingTimeLbl: UILabel!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var meterTimer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFpc()
        setupUI()
        requestRecordPermission()
    }
    
    func setupUI(){
        doneButton.isEnabled = false
    }
    
    //MARK: Inital Audio Recording setup methods
    func requestRecordPermission()
    {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        // Record perssion allowed go ahead
                    } else {
                        // perssion denied
                        print("failed to record!")
                    }
                }
            }
        } catch {
            // failed to record!
            print("failed to record!")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //MARK: Recording Action methods
    @IBAction func startRecording(_ sender: Any) {
        if audioRecorder == nil
        {
            let audioFilename = recordId + ".m4a"
            audioPath = getDocumentsDirectory().appendingPathComponent(audioFilename)
            print("Recording saved at :"+audioPath.absoluteString)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            do {
                audioRecorder = try AVAudioRecorder(url: audioPath, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.record()
                
                recordingState = .recording
                
                meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
                
            } catch {
                finishRecording(success: false)
            }
        }
        else
        {
            recordingState = .stopped
            finishRecording(success: true)
        }
    }
    
    @objc func updateAudioMeter(timer: Timer)
    {
        if audioRecorder.isRecording
        {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            recordingTimeLbl.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
 
    func updateRecordingState(){
        switch recordingState {
        case .recording:
            animateRecordButton(radius: 12, scale: 0.6)
        case .stopped:
            animateRecordButton(radius: 36, scale: 1)
            doneButton.isEnabled = true
        default:
            return
        }
    }
    
    func animateRecordButton(radius: CGFloat, scale: CGFloat){
        UIView.animate(withDuration: 0.2, animations: {
            self.recordingButton.layer.cornerRadius = radius
            self.recordingButton.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    //MARK: AVAudio Recorder Delegate method
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        meterTimer.invalidate()
        audioRecorder = nil
        
        if success {
            print("Recording successfully completed")
        } else {
            print("Recording failed")
        }
    }

}

extension NewRecordingViewController: FloatingPanelControllerDelegate {
    func setupFpc() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        let contentVC = PracticeDetailViewController()
        fpc.set(contentViewController: contentVC)
        fpc.track(scrollView: contentVC.tableView)
        
        fpc.surfaceView.cornerRadius = 16
        fpc.surfaceView.shadowHidden = true
        fpc.surfaceView.borderWidth = 1.0 / traitCollection.displayScale
        fpc.surfaceView.borderColor = UIColor.black.withAlphaComponent(0.2)
        
        fpc.addPanel(toParent: self)
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return FloatingPanelDetailLayout()
    }
    
    func floatingPanel(_ vc: FloatingPanelController, behaviorFor newCollection: UITraitCollection) -> FloatingPanelBehavior? {
        return FloatingPanelDetailBehaviour()
    }
}

class FloatingPanelDetailLayout: FloatingPanelLayout {
    var initialPosition: FloatingPanelPosition {
        return .tip
    }
    
    var topInteractionBuffer: CGFloat { return 0.0 }
    var bottomInteractionBuffer: CGFloat { return 0.0 }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 56.0
        case .half: return 262.0
        case .tip: return 85.0 + 44.0 // Visible + ToolView
        default: return nil
        }
    }
    
    func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.0
    }
}

class FloatingPanelDetailBehaviour: FloatingPanelBehavior {
    var velocityThreshold: CGFloat {
        return 15.0
    }
    
    func interactionAnimator(_ fpc: FloatingPanelController, to targetPosition: FloatingPanelPosition, with velocity: CGVector) -> UIViewPropertyAnimator {
        let timing = timeingCurve(to: targetPosition, with: velocity)
        return UIViewPropertyAnimator(duration: 0, timingParameters: timing)
    }
    
    private func timeingCurve(to: FloatingPanelPosition, with velocity: CGVector) -> UITimingCurveProvider {
        let damping = self.damping(with: velocity)
        return UISpringTimingParameters(dampingRatio: damping,
                                        frequencyResponse: 0.4,
                                        initialVelocity: velocity)
    }
    
    private func damping(with velocity: CGVector) -> CGFloat {
        switch velocity.dy {
        case ...(-velocityThreshold):
            return 0.7
        case velocityThreshold...:
            return 0.7
        default:
            return 1.0
        }
    }
}
