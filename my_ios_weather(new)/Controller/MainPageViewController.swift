//
//  MainPageViewController.swift
//  my_ios_weather(new)
//
//  Created by 危末狂龍 on 2023/2/23.
//

import Foundation

import UIKit

class MainPageViewController: UIPageViewController {
    
    var initialPage:Int?
    var pages = [UIViewController]()
    var CityWeatherViewControllerArr: [UIViewController] = []
    
    //MARK: - UI
    lazy var pageControl:UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = true
        pageControl.numberOfPages = WeatherStore.shared.weathers.count
//        pageControl.addTarget(self, action: #selector(pageControlTopHeadler(sender:)), for: .touchUpInside)
        pageControl.addTarget(self, action: #selector(pageControlTopHeadler(sender:)), for: .touchUpInside)
        pageControl.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0)
        return pageControl
    }()
    
    //transtion style改為scroll
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setupPages()
        setupToolBar()
        pageControl.currentPage = initialPage!
    }
    
    func setupPages(){
    
            for index in 0..<WeatherStore.shared.weathers.count{
                let vc = AddCityWeatherViewController()
                let city = WeatherStore.shared.weathers[index].name
                vc.cityName = city
                self.pages.append(vc)
            }    
            setViewControllers([pages[initialPage!]], direction: .forward, animated: false, completion: nil)
    }
    
    func setupToolBar(){
        self.navigationController?.toolbar.backgroundColor = .black
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(image: UIImage(systemName: "map"), style: .done, target: self, action: #selector(openMap)))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        items.append(UIBarButtonItem(customView: pageControl))
        items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        items.append(UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(backToRoot)))
        self.toolbarItems = items
    }
    
    @objc func openMap(){
        
    }
    
    @objc func backToRoot(){
        dismiss(animated: true)
    }

    @objc func pageControlTopHeadler(sender:UIPageControl){
        self.setViewControllers([self.pages[pageControl.currentPage]], direction: .forward, animated: true, completion: nil)
        print("TOUCH")
        print(pageControl.currentPage)
    }
    
//    func setPageViewController(page:Int){
//        guard let VC = setup
//
//    }
//
}

extension MainPageViewController:UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        guard previousIndex >= 0 else { return pages.last }
        
        guard pages.count > previousIndex else { return nil }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil }
        
        return pages[nextIndex]
    }
}

extension MainPageViewController: UIPageViewControllerDelegate {

//    override func setViewControllers(_ viewControllers: [UIViewController]?, direction: UIPageViewController.NavigationDirection, animated: Bool, completion: ((Bool) -> Void)? = nil) {
//        <#code#>
//    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
        print(self.pageControl.currentPage)
    }
    
}

    
    
    
