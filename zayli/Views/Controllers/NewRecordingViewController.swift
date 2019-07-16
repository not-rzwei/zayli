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

class NewRecordingViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet weak var recordButton: UIButton!
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func doneAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var recordSession: AVAudioSession!
    var practiceRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordSession = AVAudioSession.sharedInstance()
        
        do {
            try recordSession.setCategory(.playAndRecord, mode: .default)
            try recordSession.setActive(true)
            recordSession.requestRecordPermission(){[unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed{
                        self.loadRecordingUI()
                    }else{
                        self.loadFailUI()
                    }
                }
                
            }
        } catch {
                self.loadFailUI()
                print("failed")
        }
    }
    
    func loadRecordingUI(){

        
    }
    
    func loadFailUI(){
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = "Recording Failed: please ensure the app has access to your microphone"
        failLabel.numberOfLines = 0
    }
    
    @IBAction func recordBtn() {
        let audioURL = self.getURL()
        print(audioURL.absoluteString)
        
        let setting = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            practiceRecorder = try AVAudioRecorder(url: audioURL, settings: setting)
            practiceRecorder.delegate = self
            practiceRecorder.record()
        } catch {
                finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool){
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        practiceRecorder.stop()
        practiceRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to record", for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        }else{
            recordButton.setTitle("Tap to record", for: .normal)
            
            let ac = UIAlertController(title: "Record Failed", message: "There was a problem recording your practice; please try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("practice.m4a")
    }
    
    @objc func nextTapped(){
        
    }
    
    @objc func recordTapped(){
        if practiceRecorder == nil {
            recordBtn()
        }else{
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    
}
