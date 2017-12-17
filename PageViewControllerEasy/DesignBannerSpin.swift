//
//  DesignBannerSpin.swift
//  YaGanaste
//
//  Created by Victor on 4/27/17.
//  Copyright © 2017 Paga Todo. All rights reserved.
//

import UIKit

class DesignBannerSpin : UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var timer : Timer?
    var almacenadoTmp: Int = 0
    var timeIntervaloCursor : CGFloat = 4.0
    var stopAnimation : Bool  = false
    let tituloPaginas = ["Cobra Con Tarjeta al Mejor Precio","Recibe Pagos Con Tarjeta","Usa Tu Dinero Como Quieras",""]
    var images = ["IntroA","IntroB","IntroC","introD"]
    
    
    
    var pageViewController: UIPageViewController!
    
    @IBAction func swipeLeft(sender: AnyObject) {
        print("SWipe left")
    }
    
    func animation(){
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeIntervaloCursor), target: self, selector: #selector(self.updateAnimation), userInfo: nil, repeats: true)
    }
    func updateAnimation(){
        print("almacenado tmp: \(almacenadoTmp)")
            if almacenadoTmp >= 3{
                almacenadoTmp = 0
            }else{
                almacenadoTmp += 1
            }
    
        let pageContentViewController = self.viewControllerAtIndex(index: almacenadoTmp)
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
    }

    //Stop animation cursor
    func stopAnimationCursor () {
        stopAnimation = true
    
    }
    
    //Start animation cursor
    func startAnimationCursor() {
        stopAnimation = false
        
    }

    @IBAction func swiped(sender: AnyObject) {
        
        self.pageViewController.view .removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
        reset()
    }
    
    func reset() {
        /* Getting the page View controller */
        pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
       self.pageViewController.dataSource = self
        let pageContentViewController = self.viewControllerAtIndex(index: 0)
        
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)

        /* We are substracting 30 because we have a start again button whose height is 30*/
        self.pageViewController.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        var number = index
        if((self.tituloPaginas.count == 0) || (index >= self.tituloPaginas.count)) {
            return nil
        }
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "InicioSesionBanner") as! InicioSesionBannerSpinUIViewController
        if number <= -1 {
            number = 0
        }
            pageContentViewController.imageName = images[number]
            pageContentViewController.titleText = tituloPaginas[number]
            pageContentViewController.pageIndex = number
        
       
        return pageContentViewController
    }

    @IBAction func start(sender: AnyObject) {
        let pageContentViewController = self.viewControllerAtIndex(index: 0)
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
        animation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
       
        var index = (viewController as! InicioSesionBannerSpinUIViewController).pageIndex!
        
        index -= 1
        almacenadoTmp = index
        
        if index == 0 {
            return nil
        }
        
        return self.viewControllerAtIndex(index: almacenadoTmp)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! InicioSesionBannerSpinUIViewController).pageIndex!
        index += 1
        almacenadoTmp = index
        if index == self.images.count{
            return nil
        }
        return self.viewControllerAtIndex(index: almacenadoTmp)
    }
  
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return tituloPaginas.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return 0
    }
    
}
