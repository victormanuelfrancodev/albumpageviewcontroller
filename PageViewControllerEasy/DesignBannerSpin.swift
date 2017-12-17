//
//  DesignBannerSpin.swift
//  YaGanaste
//
//  Created by Victor on 4/27/17.
//  Copyright ©
//

import UIKit

class DesignBannerSpin : UIViewController{
  
    var timer : Timer?
    var almacenadoTmp: Int = 0
    var timeIntervaloCursor : CGFloat = 4.0
    var stopAnimation : Bool  = false
    let tituloPaginas = ["Perrito Peluchin","Perrito Capulino","Perrito solovino","Perrito Misha"]
    var images = ["perrito1","perrito2","perrito3","perrito4"]
  
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)

        changeImage(number: 0)
        animation()
        
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                animationBack()
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                animationNext()
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
   
    func changeImage (number : Int) {
        
        self.backgroundImage?.image = UIImage(named: self.images[number])
        self.backgroundImage?.alpha = 0.1
        self.titleLabel?.text = self.tituloPaginas[number]
        self.pageControl.currentPage = number
        self.titleLabel?.alpha = 0.1
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            self.titleLabel?.alpha = 1.0
            self.backgroundImage?.alpha = 1.0
        })
    }
    
    func animation(){
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeIntervaloCursor), target: self, selector: #selector(self.updateAnimation), userInfo: nil, repeats: true)
    }
    func animationBack(){
        
        if almacenadoTmp <= 0{
            almacenadoTmp = tituloPaginas.count-1
        }else{
            almacenadoTmp -= 1
        }
        changeImage (number : almacenadoTmp)
    }
    
    func animationNext(){
        if almacenadoTmp >= tituloPaginas.count-1{
            almacenadoTmp = 0
        }else{
            almacenadoTmp += 1
        }
        changeImage (number : almacenadoTmp)
    }
    
    
    @objc func updateAnimation(){
        
        print("Splash timer: \(almacenadoTmp)")
        if almacenadoTmp >= tituloPaginas.count-1{
            almacenadoTmp = 0
        }else{
            almacenadoTmp += 1
        }
        changeImage (number : almacenadoTmp)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func finishAnimation(){
        timer?.invalidate()
        timer = nil
    }
    
}
