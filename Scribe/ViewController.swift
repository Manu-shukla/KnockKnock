

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var recordButton: UIButton!
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var active: UIActivityIndicatorView!
    @IBOutlet weak var transc: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activite.isHidden = true
    }
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activite.stopAnimating()
        activite.isHidden = true
    }

    @IBAction func playBtnIsPressed(_ sender: AnyObject) {
        activite.isHidden = false
        activite.startAnimating()
        requestSpeechAuth()
    }
   
    
    func requestSpeechAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a") {
                    do {
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                    } catch {
                        print("Error!")
                    }
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) { (result, error) in
                        if let error = error {
                            print("There was an error: \(error)")
                        } else {
                             var formattedString
                      
                            self.transc.text = result?.bestTranscription.s
                    }
                }
            }
        }
    }
}
