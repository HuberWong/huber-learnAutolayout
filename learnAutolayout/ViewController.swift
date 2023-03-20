//
//  ViewController.swift
//  learnAutolayout
//
//  Created by huber wang on 2023/3/17.
//


/// !TODO 将每个按钮设置为正方形, 将各个函数中的高都去掉
/// 竖屏根据宽度设置, 横平根据高度设置
///
/// TODO 设置方向约束!!!!!!!!!!!!!!!!
import UIKit

struct btnConfig {
    var title: String = "??"
    var color: UIColor = .green
}

var inputVector = Array<String>()

class ViewController: UIViewController {
    
    static var count: Int = 0
    
    
    var displayValueLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let color_1 = UIColor(red: 0xb0 / 255, green: 0xb0 / 255, blue: 0xb0 / 255, alpha: 1.0)
        let color_2 = UIColor(red: 0xff / 255, green: 0xa7 / 255, blue: 00 / 255, alpha: 1.0)
        let color_3 = UIColor(red: 0x42 / 255, green: 0x42 / 255, blue: 0x42 / 255, alpha: 1.0)
        let btnConfigs = [btnConfig(title: "C", color: color_1),
                          btnConfig(title: "±", color: color_1),
                          btnConfig(title: "%", color: color_1),
                          btnConfig(title: "÷", color: color_2),
                          
                          btnConfig(title: "7", color: color_3),
                          btnConfig(title: "8", color: color_3),
                          btnConfig(title: "9", color: color_3),
                          btnConfig(title: "×", color: color_2),
                          
                          btnConfig(title: "4", color: color_3),
                          btnConfig(title: "5", color: color_3),
                          btnConfig(title: "6", color: color_3),
                          btnConfig(title: "－", color: color_2),
                          
                          btnConfig(title: "1", color: color_3),
                          btnConfig(title: "2", color: color_3),
                          btnConfig(title: "3", color: color_3),
                          btnConfig(title: "＋", color: color_2),
                          
//                          btnConfig(title: "0", color: color_3),  // TODO last 行, 布局后修改
                          btnConfig(title: "0", color: color_3),
                          btnConfig(title: ".", color: color_3),
                          btnConfig(title: "＝", color: color_2),
        ]

        view.backgroundColor = .gray
        print("Start up!")
        
        let vStackView = genVStackView(btnConfigs: btnConfigs)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(vStackView)
        NSLayoutConstraint.activate([
            vStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            vStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            vStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
//         display label 处理
        self.view.addSubview(displayValueLabel)
        displayValueLabel.translatesAutoresizingMaskIntoConstraints = false
        displayValueLabel.text = "请输入计算式"
        displayValueLabel.font = UIFont.systemFont(ofSize: CGFloat(40))
        displayValueLabel.textAlignment = .right
        displayValueLabel.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            displayValueLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            displayValueLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            displayValueLabel.heightAnchor.constraint(equalToConstant: CGFloat(100)),
            displayValueLabel.bottomAnchor.constraint(equalTo: vStackView.topAnchor),


        ])
        
        print("Start up!!!")
    }
    
    func genVStackView(btnConfigs: [btnConfig]) -> UIStackView{
        let numberOfBtnInHStackView = 4
        let numberOfStandardHStackView = 4
        let numberOfUnstandardHStackView = 1
        
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        
        // 单另出来第 1 行 hStackView 做布局
        let hStackView = genHStackView(btnConfigs: Array(btnConfigs[0..<(1 * numberOfBtnInHStackView)]))
        vStackView.addArrangedSubview(hStackView)
        NSLayoutConstraint.activate([
            vStackView.widthAnchor.constraint(equalTo: hStackView.widthAnchor),
            vStackView.heightAnchor.constraint(equalTo: hStackView.heightAnchor, multiplier: CGFloat(numberOfStandardHStackView+numberOfUnstandardHStackView)),
        ])
        for i in 1..<numberOfStandardHStackView {
            let hStackView = genHStackView(btnConfigs: Array(btnConfigs[i*numberOfBtnInHStackView..<(i+1)*numberOfBtnInHStackView]))
            vStackView.addArrangedSubview(hStackView)
        }
        
        // 处理最后一行占据两个位置的 0 按钮
        let lastHStackView = genLastHStackView(btnConfigs: Array(btnConfigs[(numberOfBtnInHStackView*numberOfStandardHStackView)...]))
        vStackView.addArrangedSubview(lastHStackView)
        
        
        
        return vStackView
    }
    
    func genLastHStackView(btnConfigs: [btnConfig]) ->UIStackView {
        let btn0 = genButton(title: btnConfigs[0].title, color: btnConfigs[0].color)
        let btn1 = genButton(title: btnConfigs[1].title, color: btnConfigs[1].color)
        let btn2 = genButton(title: btnConfigs[2].title, color: btnConfigs[2].color)
        

        
        let lastHstackView = UIStackView(arrangedSubviews: [btn0, btn1, btn2])
        lastHstackView.axis = .horizontal
        lastHstackView.alignment = .fill
        lastHstackView.distribution = .fillProportionally
        
        btn0.widthAnchor.constraint(equalTo: btn0.widthAnchor).isActive = false
        NSLayoutConstraint.activate([
            lastHstackView.widthAnchor.constraint(equalTo: btn1.widthAnchor, multiplier: CGFloat(1 + 3)),
            lastHstackView.heightAnchor.constraint(equalTo: btn0.heightAnchor),
            btn0.widthAnchor.constraint(equalTo: btn1.widthAnchor, multiplier: CGFloat(2)),
        ])
        
        return lastHstackView
    }
    
    
    
    func genHStackView<T>(btnConfigs: T) -> UIStackView where T:RandomAccessCollection, T.Element == btnConfig {
        let hStackView = UIStackView()
        hStackView.axis = .horizontal
        hStackView.alignment = .fill
        hStackView.distribution = .fillEqually
        
        // 单另出来第一个按钮做一下布局
        let btn = genButton(title: btnConfigs[0 as! T.Index].title, color: btnConfigs[0 as! T.Index].color)
        hStackView.addArrangedSubview(btn)
        NSLayoutConstraint.activate([
            hStackView.widthAnchor.constraint(equalTo: btn.widthAnchor, multiplier: CGFloat(btnConfigs.count)),
            hStackView.heightAnchor.constraint(equalTo: btn.heightAnchor)
        ])
        
        // 处理剩下需要添加到同一恒行的按钮
        for i in 1..<btnConfigs.count {
            let btn = genButton(title: btnConfigs[i as! T.Index].title, color: btnConfigs[i as! T.Index].color)
            hStackView.addArrangedSubview(btn)
        }
        return hStackView
    }

    
    func genButton(title: String, color: UIColor) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.backgroundColor = color
        btn.layer.borderWidth = 1.0
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.titleLabel!.font = UIFont.systemFont(ofSize: btn.systemLayoutSizeFitting(CGSize.zero).width)
        let squareConstraint =  btn.widthAnchor.constraint(equalTo: btn.heightAnchor)
        squareConstraint.isActive = true
        
        btn.addTarget(self, action: #selector(self.pr(btn:)), for: .touchUpInside)
        
        
        return btn
    }
    @objc func pr(btn: UIButton) {
        print(btn.titleLabel?.text)
        inputVector.append(btn.titleLabel!.text!)
        print(inputVector)
        displayValueLabel.text = btn.titleLabel?.text
    }
}

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        let alpha = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
