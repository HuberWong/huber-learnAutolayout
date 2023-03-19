//
//  ViewController.swift
//  learnAutolayout
//
//  Created by huber wang on 2023/3/17.
//

import UIKit

class ViewController: UIViewController {
    
    static var count: Int = 0
    var btn = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Start up!")
        
        
        btn.setTitle("Just a Button", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8.0
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(self.pr), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(btn)
        

        NotificationCenter.default.addObserver(self, selector: #selector(self.orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    @objc func pr() {
        print("Coutnt: \(ViewController.count)")
        ViewController.count += 1
    }
    
    @objc func orientationDidChange() {
        let currentOrientation = UIDevice.current.orientation
        switch currentOrientation {
        case .landscapeLeft, .landscapeRight:
            self.btn.setTitle("Landscape", for: .normal)
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: btn.leadingAnchor),
                btn.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                view.topAnchor.constraint(equalTo: btn.topAnchor),
                btn.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        case .portrait, .portraitUpsideDown:
            self.btn.setTitle("portratit", for: .normal)
            NSLayoutConstraint.activate([
                view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: btn.leadingAnchor),
                btn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: btn.topAnchor),
                btn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        default:
            break
        }
    }
    


}

