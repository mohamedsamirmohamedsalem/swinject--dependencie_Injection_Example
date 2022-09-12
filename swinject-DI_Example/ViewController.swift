//
//  ViewController.swift
//  swinject-DI_Example
//
//  Created by Mohamed Samir on 12/09/2022.
//

import UIKit
import Swinject
import SwinjectStoryboard

protocol ABProtocol {
    func doSomeThing()
}
class AClass:ABProtocol{
    func doSomeThing() { print("instance From AClass") }
}
class BClass:ABProtocol{
    func doSomeThing() {print("instance From BClass")}
}
protocol CProtocol{
    var logEvent: Int {get set}
    func doSomeThing()
}
class CClass: CProtocol {
    var logEvent: Int
    init(logEvent: Int) {
        self.logEvent = logEvent
    }
    func doSomeThing() {print("instance From CClass")}
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instanceFromAClass = Assembler.sharedAssembler.resolver.resolve(ABProtocol.self,name: "AClass")!
        let instanceFromBClass = Assembler.sharedAssembler.resolver.resolve(ABProtocol.self,name: "BClass")!
        let instanceFromCClass = Assembler.sharedAssembler.resolver.resolve(CProtocol.self, argument: 3)!


        print(instanceFromAClass.doSomeThing())
        print(instanceFromBClass.doSomeThing())
        print(instanceFromCClass.doSomeThing())
        print(instanceFromCClass.logEvent)


        //////////////    //////////////    //////////////    //////////////    //////////////    //////////////    //////////////    //////////////    //////////////    /////////////
        //SwinjectStoryboard
        
        
    }
}

class AAssembly: Assembly {
    func assemble(container: Container){
        container.register(ABProtocol.self,name: "AClass") { resolver in
            AClass()
        }
        container.register(ABProtocol.self, name: "BClass") { resolver in
            BClass()
        }
    }
}


class CAssembly: Assembly {
    func assemble(container: Container){
         container.register(CProtocol.self) { (resolver,logEvent: Int) in
             CClass(logEvent: logEvent)
         }
    }
}

extension Assembler{
    static let sharedAssembler: Assembler = {
        let container = Container()
        let assembler = Assembler(
            [
                AAssembly(),
                CAssembly()
            ]
            ,container:container
        )
        return assembler
    }()
}
