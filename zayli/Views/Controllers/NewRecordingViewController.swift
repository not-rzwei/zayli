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

class NewRecordingViewController: UIViewController, AVAudioRecorderDelegate {
    private let recordId: String = UUID().uuidString
    private var audioPath: URL!
    
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
        
        //TODO: Make sure you must have added privacy permission in plist "Privacy - Microphone Usage Description"
        requestRecordPermission()
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
                meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
                
            } catch {
                finishRecording(success: false)
            }
        }
        else
        {
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
    
    @IBAction func stopRecording(_ sender: Any) {
        finishRecording(success: true)
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
