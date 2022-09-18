//
//  SecondViewController.swift
//  swinject-DI_Example
//
//  Created by Mohamed Samir on 13/09/2022.
//

import UIKit


protocol ColorProvidedProtocol {
    var color : UIColor { get}
}

class ColorProviding: ColorProvidedProtocol {
    var color: UIColor = {
        let colors: [UIColor] = [.green,.systemRed,.red]
        return colors.randomElement()!
    }()
    
    
}
class SecondViewController: UIViewController {
    
    var provider: ColorProvidedProtocol?
    
    init(colorProvidedProtocol: ColorProvidedProtocol?) {
        self.provider = colorProvidedProtocol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = provider?.color ?? .black
 

    }

}
