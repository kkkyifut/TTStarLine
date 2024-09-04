//
//  ViewController.swift
//  TestTaskStarLine
//
//  Created by Юрий Яковлев on 03.09.2024.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var cornerRadiusSlider: UISlider!
    @IBOutlet weak var toothHeightSlider: UISlider!
    @IBOutlet weak var toothCountSlider: UISlider!
    @IBOutlet weak var gearView: GearView!
    @IBOutlet weak var toothRadiusLabel: UILabel!
    @IBOutlet weak var cornerRadiusLabel: UILabel!
    @IBOutlet weak var toothHeightLabel: UILabel!
    @IBOutlet weak var toothCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gearView.backgroundColor = .clear        
        updateLabels()
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        updateLabels()
    }
    
    private func updateLabels() {
        let radius = CGFloat(radiusSlider.value)
        toothRadiusLabel.text = String(format: "Радиус окружности: %.2f", radius)
        gearView.radius = radius
        
        let cornerRadius = CGFloat(cornerRadiusSlider.value)
        cornerRadiusLabel.text = String(format: "Радиус скругления зубцов: %.1f", cornerRadius)
        gearView.cornerRadius = cornerRadius

        let toothHeight = CGFloat(toothHeightSlider.value)
        toothHeightLabel.text = String(format: "Высота зубцов: %.2f", toothHeight)
        gearView.toothHeight = toothHeight
        
        let toothCount = Int(toothCountSlider.value)
        toothCountLabel.text = String(format: "Количество зубцов: %d", Int(toothCount))
        gearView.toothCount = toothCount
    }
}

