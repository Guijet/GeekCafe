

 //
 //  Utility.swift
 //  NIGHTPLANNER_V2
 //
 //  Created by Enterface Team on 2017-06-19.
 //  Copyright © 2017 Enterface . All rights reserved.
 //
 import Foundation
 import UIKit
 import ObjectiveC
 class Utility {
    
    var mois = [String]()
    var weekDay = [String]()
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func shuffle(array : [Any]) ->[Any] {
        var array = array
        for x in 0 ... array.count - 1 {
            let randomI = Int(arc4random_uniform(UInt32(array.count)))
            if(randomI != x) {
                swap(&array[x],&array[randomI])
            }
            
        }
        return array
    }
    
    func versionDifferenceFrom6(rootView: UIView) -> CGFloat {
        if(rootView.frame.width < 375 ) {
            return -1.0
        }
        else if(rootView.frame.width > 375) {
            return 1.0
        }
        return 0.0
    }
    
    func clearBorder(btn: UIButton) {
        for x in btn.layer.sublayers! {
            if x.frame == CGRect(x:0, y:btn.frame.height - 2, width: btn.frame.width, height: 2){
                x.removeFromSuperlayer()
            }
        }
    }
    
    func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = URL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    func recursifTextColor(rootView: UIView) {
        rootView.tintColor = .white
        rootView.layer.borderColor = UIColor.white.cgColor
        for x in rootView.subviews {
            
            recursifTextColor(rootView: x)
        }
    }
    
    func recursifBackgroundColor(rootView: UIView) {
        
        for x in rootView.subviews {
            x.backgroundColor = hexStringToUIColor(hex: "#ECECEC")
            recursifBackgroundColor(rootView: x)
        }
        
    }
    
    func alertYesNo(message: String,title: String,control: UIViewController,yesAction:(()->())?,noAction:(()->())?,titleYes: String,titleNo: String,style: UIAlertControllerStyle) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSFontAttributeName : UIFont(name: "Lato-Regular", size: 22)!,
            NSForegroundColorAttributeName : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSFontAttributeName : UIFont(name: "Lato-Regular", size: 16)!,
            NSForegroundColorAttributeName : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: style)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        
        refreshAlert.addAction(UIAlertAction(title: titleYes, style: .default, handler: { (action: UIAlertAction!) in
            yesAction?()
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: titleNo, style: .default, handler: { (action: UIAlertAction!) in
            noAction?()
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        control.present(refreshAlert, animated: true, completion: nil)
    }
    func alertWithChoice(message: String,title: String,control: UIViewController,actionTitle1: String,actionTitle2: String,action1:(()->())?,action2:(()->())?,style: UIAlertControllerStyle) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSFontAttributeName : UIFont(name: "Lato-Regular", size: 22)!,
            NSForegroundColorAttributeName : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSFontAttributeName : UIFont(name: "Lato-Regular", size: 16)!,
            NSForegroundColorAttributeName : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: style)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        if actionTitle1 != "Table"{
            refreshAlert.addAction(UIAlertAction(title: actionTitle1, style: .default, handler: { (action: UIAlertAction!) in
                action1?()
                refreshAlert.dismiss(animated: true, completion: nil)
            }))
        }
        refreshAlert.addAction(UIAlertAction(title: actionTitle2, style: .default, handler: { (action: UIAlertAction!) in
            action2?()
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        })
        
        refreshAlert.addAction(cancel)
        control.present(refreshAlert, animated: true, completion: nil)
    }
    
    
    
    func alert(message: String,title: String,control:UIViewController) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSFontAttributeName : UIFont(name: "Lato-Regular", size: 22)!,
            NSForegroundColorAttributeName : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSFontAttributeName : UIFont(name: "Lato-Regular", size: 16)!,
            NSForegroundColorAttributeName : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        control.present(refreshAlert, animated: true, completion: nil)
    }
    
    func alert(message: String,title: String,control:UIViewController,f: (()->())?) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSFontAttributeName : UIFont(name: "Lato-Regular", size: 22)!,
            NSForegroundColorAttributeName : UIColor.black])
        
        let attributedMessage = NSAttributedString(string: message, attributes: [
            NSFontAttributeName : UIFont(name: "Lato-Regular", size: 16)!,
            NSForegroundColorAttributeName : UIColor.black])
        
        let refreshAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        refreshAlert.setValue(attributedString, forKey: "attributedTitle")
        refreshAlert.setValue(attributedMessage, forKey: "attributedMessage")
        
        //        recursifBackgroundColor(rootView: refreshAlert.view.subviews.first!.subviews.first!)
        //        recursifTextColor(rootView: refreshAlert.view)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            f?()
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        control.present(refreshAlert, animated: true, completion: nil)
    }
    
    func createOverTapListener(x: CGFloat,y: CGFloat, width: CGFloat,height: CGFloat,view: UIView,selector: Selector) {
        let btn = UIButton()
        btn.frame = CGRect(x: x, y: y, width: width, height: height)
        btn.setTitle("", for: .normal)
        btn.addTarget(self, action: selector, for: .touchUpInside)
        view.addSubview(btn)
    }
    
    func createHR(x: CGFloat,y: CGFloat, width: CGFloat,view: UIView,color: UIColor) {
        let hr = UITextView()
        hr.isSelectable = false
        hr.isEditable = false
        hr.frame = CGRect(x: x, y: y, width: width, height: 1)
        hr.backgroundColor = color
        hr.isUserInteractionEnabled = false
        view.addSubview(hr)
    }
    
    func createVerticalHR(x: CGFloat,y: CGFloat, height: CGFloat,view: UIView,color: UIColor){
        let hr = UITextView()
        hr.isSelectable = false
        hr.isEditable = false
        hr.frame = CGRect(x: x, y: y, width: 1, height: height)
        hr.backgroundColor = color
        hr.isUserInteractionEnabled = false
        view.addSubview(hr)
    }
    
    func setAllTextFieldType(rootView: UIView,type: UIKeyboardType) {
        if rootView is UITextField {
            (rootView as! UITextField).keyboardType = type
        }
        for x in rootView.subviews {
            setAllTextFieldType(rootView: x, type: type)
        }
    }
    
    func previousView(control: UIViewController) -> UIViewController? {
        if let navbar = control.navigationController as? UINavigationController{
            let i = navbar.viewControllers.index(of: control)
            return navbar.viewControllers[i!-1]
        }
        return nil
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func formatDate(date: String) -> String{
        mois.append("January")
        mois.append("Febuary")
        mois.append("March")
        mois.append("April")
        mois.append("May")
        mois.append("June")
        mois.append("July")
        mois.append("August")
        mois.append("September")
        mois.append("October")
        mois.append("November")
        mois.append("December")
        
        weekDay.append("Sunday")
        weekDay.append("Monday")
        weekDay.append("Tuesday")
        weekDay.append("Wednesday")
        weekDay.append("Thursday")
        weekDay.append("Friday")
        weekDay.append("Saturday")
        var date = date
        let monthIndex = substring(from: 5, to: 7, sentence: date)
        let month = mois[Int(monthIndex)! - 1]
        var day = substring(from: 8, to: 10, sentence: date)
        day = String(describing: Int(day)!)
        date = substring(from: 0, to: 10, sentence: date)
        return "\(getDayOfWeek(date: date)), \(day) \(month)"
    }
    
    func getCleanDate(date:String)->String{
        //2017-10-25 00:50:33.000000
        return date.substring(to: date.index(date.startIndex, offsetBy: 10))
    }
    
    func getDayOfWeek(date: String) -> String{
        var weekDay = [String]()
        weekDay.append("Sunday")
        weekDay.append("Monday")
        weekDay.append("Tuesday")
        weekDay.append("Wednesday")
        weekDay.append("Thursday")
        weekDay.append("Friday")
        weekDay.append("Saturday")
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: date)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDayIndex = myComponents.weekday! - 1
        return self.weekDay[weekDayIndex]
    }
    
    func adjustCGRect(frame: inout CGRect,rootView: UIView) {
        let vHeight = rootView.frame.height
        let vWidth = rootView.frame.width
        let adjustWidth = (vWidth / 375.0)
        let adjustHeight = (vHeight / 667.0)
        frame = CGRect(x: frame.minX * adjustWidth, y: frame.minY * adjustHeight, width: frame.width * adjustWidth, height: frame.height * adjustHeight)
    }
    
    func proportion(val: CGFloat,rootView: UIView) -> CGFloat {
        let vHeight = rootView.frame.height
        let vWidth = rootView.frame.width
        let adjustWidth = (vWidth / 375.0)
        let adjustHeight = (vHeight / 667.0)
        return val * adjustHeight * adjustWidth
    }
    
    func adjustToScreenSizeSubview(subview: UIView, rootView: UIView) {
        for x in subview.subviews {
            adjusRecursif(view: x, rootView: rootView)
        }
    }
    
    func adjustToScreenSize(rootView: UIView) {
        for x in rootView.subviews {
            adjusRecursif(view: x, rootView: rootView)
        }
    }
    
    private func adjusRecursif(view: UIView,rootView: UIView) {
        let vHeight = rootView.frame.height
        let vWidth = rootView.frame.width
        let adjustWidth = (vWidth / 375.0)
        let adjustHeight = (vHeight / 667.0)
        
        view.frame = CGRect(x: view.frame.minX * adjustWidth, y: view.frame.minY * adjustHeight, width: view.frame.width * adjustWidth, height: view.frame.height * adjustHeight)
        if view is UILabel {
            (view as! UILabel).adjustsFontSizeToFitWidth = true
        }
        
        for x in view.subviews {
            adjusRecursif(view: x, rootView: rootView)
        }
        //        adjustLayer(layer: view.layer, rootView: rootView)
    }
    
    //    func adjustLayer(layer : CALayer,rootView: UIView) {
    //        let vHeight = rootView.frame.height
    //        let vWidth = rootView.frame.width
    //        let adjustWidth = (vWidth / 375.0)
    //        let adjustHeight = (vHeight / 667.0)
    //
    //        layer.frame = CGRect(x: layer.frame.minX * adjustWidth, y: layer.frame.minY * adjustHeight, width: layer.frame.width * adjustWidth, height: layer.frame.height * adjustHeight)
    //        if let s = layer.sublayers?[0] {
    //            for x in layer.sublayers! {
    //                adjustLayer(layer: x, rootView: rootView)
    //            }
    //        }
    //
    //    }
    
    func getWeekIndexOfDay(date: String) -> Int{
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: date)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday! - 1
        return weekDay
    }
    
    func substring(from: Int,to: Int,sentence: String) -> String {
        let sArr = Array(sentence.utf8)
        var result: String = ""
        for x in from...to - 1 {
            result += String(Character(UnicodeScalar(sArr[x])))
        }
        return result
    }
    
    func separate(separationNumber: Int,sentence: String) -> String {
        let sArr = Array(sentence.utf8)
        var result: String = ""
        var indexToSeparate = 0
        var charIndex = sentence.characters.count - 1
        while( charIndex >= 0) {
            indexToSeparate += 1
            result = "\(String(Character(UnicodeScalar(sArr[charIndex]))))\(result)"
            if(indexToSeparate  ==  separationNumber) {
                result = " \(result)"
                indexToSeparate = 0
            }
            charIndex -= 1
            
        }
        return result
    }
    
    func getOptimizeImage(url: String) -> UIImage {
        if(!Utility().verifyUrl(urlString: url)) {
            return UIImage()
        }
        for x in MemoryImage.data.arrayImage {
            if(x.url == url) {
                return x.image
            }
        }
        do{
            var img = UIImage()
            let urll = URL(string: url)
            let dataimg = try Data(contentsOf: urll!)
            img = UIImage(data: dataimg)!
            DispatchQueue(label: "addinArray").sync {
                MemoryImage.data.arrayImage.append(OptimizeImage(url: url, image: img))
            }
            return img
        }
        catch let error as NSError
        {
            print(error)
        }
        return UIImage()
    }
    
    func createOverTapListener(x: CGFloat,y: CGFloat, width: CGFloat,height: CGFloat,view: UIView,selector: Selector,withTag tag: Int) {
        let btn = UIButton()
        btn.frame = CGRect(x: x, y: y, width: width, height: height)
        btn.setTitle("", for: .normal)
        btn.addTarget(self, action: selector, for: .touchUpInside)
        btn.tag = tag
        view.addSubview(btn)
    }
    
    func getJson(url:String,method:String,body:String = "",needToken:Bool = false)->[String:Any]{
        
        var finish = false
        var result: [String: Any]!
        
        DispatchQueue.global(qos:.background).async {
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = method
            
            if(method == "POST") {
                let postString = body
                request.httpBody = postString.data(using: .utf8)
            }
            else if(method == "PUT"){
                let putString = body
                request.httpBody = putString.data(using: .utf8)
            }
            else if(method == "DELETE"){
                let deleteString = body
                request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                request.httpBody = deleteString.data(using: .utf8)
            }
            
            if(needToken){
                request.addValue("Bearer \(Global.global.userInfo.token)", forHTTPHeaderField: "Authorization")
            }
            
            let config = URLSessionConfiguration.default
            config.httpMaximumConnectionsPerHost = 100
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request) { data, response, error in
                
                let responseText: String = String(data: data!, encoding: String.Encoding.utf8)!
                print(responseText)
                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("error=\(String(describing: error))")
                    finish = true
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, buxt is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                    result = ["nil":"nil"]
                }
                do
                {
                    
                    if let parsedData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]{
                        result = parsedData
                    } else {
                        result = ["nil":"nil"]
                    }
                    
                    finish = true
                }
                catch let error as NSError
                {
                    print(error)
                    result = ["nil":"nil"]
                    finish = true
                }
            }
            task.resume()
            session.finishTasksAndInvalidate()
            
        }
        while(!finish) { usleep(300) }
        return result
    }
    
 }
 
 struct OptimizeImage {
    init(url: String,image: UIImage) {
        self.url = url
        self.image = image
    }
    var url: String
    var image : UIImage
 }
 
 final class MemoryImage {
    static let data = MemoryImage()
    var arrayImage = [OptimizeImage]()
    
 }
 
 class UIProgessBar : UIView {
    var colorComplete: UIColor!
    var colorUncomplete: UIColor!
    var maxValue: CGFloat!
    var value: CGFloat!
    var viewComplete: UIView!
    private var valueAccordingToAnimation: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewComplete = UIView(frame: frame)
        self.addSubview(viewComplete)
        colorUncomplete = Utility().hexStringToUIColor(hex: "#F0F0F0")
        colorComplete = Utility().hexStringToUIColor(hex: "#000000")
        self.backgroundColor = colorUncomplete
        viewComplete.backgroundColor = colorComplete
        maxValue = 100
        value = 50
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        viewComplete = UIView(frame: self.frame)
        self.addSubview(viewComplete)
        colorUncomplete = Utility().hexStringToUIColor(hex: "#F0F0F0")
        colorComplete = Utility().hexStringToUIColor(hex: "#000000")
        viewComplete.backgroundColor = colorComplete
        self.backgroundColor = colorUncomplete
        maxValue = 100
        value = 50
    }
    
    func setMaxValue(maxvalue: CGFloat) {
        self.maxValue = maxvalue
    }
    
    func setValue(value: CGFloat) {
        self.value = value
        
    }
    
    func show(animated: Bool,tick: CGFloat,f: @escaping (()->())) {
        viewComplete.backgroundColor = colorComplete
        self.viewComplete.layer.cornerRadius = self.layer.cornerRadius
        self.backgroundColor = colorUncomplete
        if(!animated) {
            viewComplete.frame = CGRect(x: 0, y: 0, width: self.frame.width * (value / maxValue), height: self.frame.height)
        } else {
            let delay = tick
            
            DispatchQueue.global(qos: .background).async {
                usleep(1000 * 100)
                var totalTick : CGFloat = 0
                while(totalTick <= 1.0) {
                    totalTick += (0.01 * delay)
                    self.valueAccordingToAnimation = (self.value * totalTick)
                    DispatchQueue.main.async {
                        self.viewComplete.frame = CGRect(x: 0, y: 0, width: self.frame.width * (self.value / self.maxValue) * totalTick, height: self.frame.height)
                        f()
                        
                    }
                    usleep(100)
                }
                self.viewComplete.frame = CGRect(x: 0, y: 0, width: self.frame.width * (self.value / self.maxValue), height: self.frame.height)
                
                
            }
        }
        
    }
    
    func getValueAccordingToAnimation() -> CGFloat {
        return valueAccordingToAnimation
    }
    
    func setCompleteColor(color: UIColor) {
        self.colorComplete = color
    }
    
    func setUncompleteColor(color: UIColor) {
        self.colorUncomplete = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }
 
 extension UIViewController {
    func rw(_ val: CGFloat) -> CGFloat {
        return val * (self.view.frame.width / 375)
    }
    func rh(_ val: CGFloat) -> CGFloat {
        return val * (self.view.frame.height / 667)
    }
 }
 
 extension UITableViewCell {
    override func rw(_ val: CGFloat) -> CGFloat {
        return val * (self.contentView.frame.width / 375)
    }
    override func rh(_ val: CGFloat) -> CGFloat {
        return val * (self.contentView.frame.height / 667)
    }
 }
 
 
 
 var AssociatedObjectHandle: UInt8 = 0
 var AssociatedObjectHandle1: UInt8 = 1
 var AssociatedObjectHandle2: UInt8 = 2
 private (set) var arrayImage = [UIImageView]()
 extension UIImageView{
    
    var initialx:CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as! CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var initialy:CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle1) as! CGFloat
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle1, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var indexInArray:Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle2) as! Int
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle2, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func resetParameter(){
        arrayImage.removeAll()
    }
    
    func addBigImageAction(){
        self.initialx = self.frame.origin.x
        self.initialy = self.frame.origin.y
        self.indexInArray = arrayImage.count + 1
        arrayImage.append(self)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showBigImage)))
    }
    
    @objc fileprivate func showBigImage(){
        let scrollview = self.superview! as! UIScrollView
        let view = scrollview.superview!
        print(self.indexInArray)
        let scale = view.frame.width / self.frame.width
        let midx = view.frame.midX - (view.frame.width / 2)
        let midy = (view.frame.midY - ((self.frame.height * scale) / 2) - 64) + scrollview.contentOffset.y
        
        self.layer.zPosition = 1
        if scale == 1{
            UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.frame.origin.x = self.initialx
                self.frame.origin.y = self.initialy
                self.layer.cornerRadius = 6
                //self.unhideEveryThing(view: view, scrollview: scrollview)
                self.changeBackground(view: view)
            }, completion: { _ in
                scrollview.isScrollEnabled = true
                let swipedown =  UISwipeGestureRecognizer(target: self, action: #selector(self.showBigImage))
                swipedown.direction = .down
                self.removeGestureRecognizer(swipedown)
                let swipeleft =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftArray))
                swipeleft.direction = .left
                self.removeGestureRecognizer(swipeleft)
                let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightArray))
                swipeRight.direction = .right
                self.removeGestureRecognizer(swipeRight)
            })
        }else{
            UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
                self.transform = CGAffineTransform(scaleX: scale, y: scale)
                self.frame.origin.x = midx
                self.frame.origin.y = midy
                self.layer.cornerRadius = 0
                //self.hideEveryThing(view: view, scrollview: scrollview)
                self.changeBackground(view: view)
            }, completion: { _ in
                scrollview.isScrollEnabled = false
                let swipedown =  UISwipeGestureRecognizer(target: self, action: #selector(self.showBigImage))
                swipedown.direction = .down
                self.addGestureRecognizer(swipedown)
                let swipeleft =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftArray))
                swipeleft.direction = .left
                self.addGestureRecognizer(swipeleft)
                let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightArray))
                swipeRight.direction = .right
                self.addGestureRecognizer(swipeRight)
            })
        }
    }
    
    @objc fileprivate func ReturnToOrigin(){
        let scrollview = self.superview! as! UIScrollView
        let view = scrollview.superview!
        let scale = view.frame.width / self.frame.width
        self.alpha = 0
        UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.frame.origin.x = self.initialx
            self.frame.origin.y = self.initialy
            self.layer.cornerRadius = 6
        }, completion: { _ in
            let swipedown =  UISwipeGestureRecognizer(target: self, action: #selector(self.showBigImage))
            swipedown.direction = .down
            self.removeGestureRecognizer(swipedown)
            let swipeleft =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftArray))
            swipeleft.direction = .left
            self.removeGestureRecognizer(swipeleft)
            let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightArray))
            swipeRight.direction = .right
            self.removeGestureRecognizer(swipeRight)
        })
    }
    
    @objc fileprivate func showBigImageSwipe(){
        let scrollview = self.superview! as! UIScrollView
        let view = scrollview.superview!
        let scale = view.frame.width / self.frame.width
        let midx = view.frame.midX - (view.frame.width / 2)
        let midy = (view.frame.midY - ((self.frame.height * scale) / 2) - 64) + scrollview.contentOffset.y
        self.alpha = 1
        self.layer.zPosition = 1
        
        UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.frame.origin.x = midx
            self.frame.origin.y = midy
            self.layer.cornerRadius = 0
        }, completion: { _ in
            scrollview.isScrollEnabled = false
            let swipedown =  UISwipeGestureRecognizer(target: self, action: #selector(self.showBigImage))
            swipedown.direction = .down
            self.addGestureRecognizer(swipedown)
            let swipeleft =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeftArray))
            swipeleft.direction = .left
            self.addGestureRecognizer(swipeleft)
            let swipeRight =  UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRightArray))
            swipeRight.direction = .right
            self.addGestureRecognizer(swipeRight)
        })
    }
    
    @objc func swipeLeftArray(){
        var index = 0
        print(arrayImage.count)
        for x in arrayImage{
            if x == self{
                if index + 1 < arrayImage.count{
                    arrayImage[index + 1].frame.origin.x = self.frame.maxX + self.frame.width
                    arrayImage[index + 1].frame.origin.y = self.frame.maxY
                    UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
                        self.frame.origin.x = self.superview!.frame.minX - self.frame.width
                        print(arrayImage[index + 1].indexInArray)
                        arrayImage[index + 1].showBigImageSwipe()
                    }, completion: {_ in
                        self.ReturnToOrigin()
                    })
                }
            }
            index += 1
        }
    }
    
    @objc func swipeRightArray(){
        var index = 0
        print(arrayImage.count)
        for x in arrayImage{
            if x == self{
                if index - 1 >= 0{
                    arrayImage[index - 1].frame.origin.x = self.frame.minX - self.frame.width
                    arrayImage[index - 1].frame.origin.y = self.frame.minY
                    UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
                        self.frame.origin.x = self.superview!.frame.maxX + self.frame.width
                        print(arrayImage[index - 1].indexInArray)
                        arrayImage[index - 1].showBigImageSwipe()
                    }, completion: {_ in
                        self.ReturnToOrigin()
                    })
                }
            }
            index += 1
        }
    }
    
    //    func hideEveryThing(view: UIView, scrollview: UIScrollView){
    //        let viewcontroller = UIApplication.shared.keyWindow?.rootViewController
    //        if let navigation = viewcontroller as? UINavigationController{
    //            navigation.hidebar()
    //        }
    //        for x in view.subviews{
    //            print(x.classForCoder)
    //            if x != scrollview{
    //                UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
    //                    x.alpha = 0
    //                }, completion: nil)
    //            }
    //        }
    //        for x in scrollview.subviews{
    //            if x != self{
    //                UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
    //                    x.alpha = 0
    //                }, completion: nil)
    //            }
    //        }
    //    }
    //
    //    func unhideEveryThing(view: UIView, scrollview: UIScrollView){
    //        let viewcontroller = UIApplication.shared.keyWindow?.rootViewController
    //        if let navigation = viewcontroller as? UINavigationController{
    //            navigation.showbar()
    //        }
    //        for x in view.subviews{
    //            if x != scrollview{
    //                UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
    //                    x.alpha = 1
    //
    //                }, completion: nil)
    //            }
    //        }
    //        for x in scrollview.subviews{
    //            if x != self{
    //                UIView.animate(withDuration: 0.40, delay: 0, options: .curveEaseIn, animations: {
    //                    x.alpha = 1
    //                }, completion: nil)
    //            }
    //        }
    //    }
    
    func changeBackground(view: UIView){
        if view.backgroundColor != .black{
            view.backgroundColor = .black
        }else{
            view.backgroundColor = .white
        }
    }
    
    func getOptimizeImageAsync(url: String){
        let refrsh = UIActivityIndicatorView()
        refrsh.frame = CGRect(x: self.bounds.midX - (self.frame.height / 2), y: self.bounds.minY, width: self.frame.height, height: self.frame.height)
        refrsh.color = Utility().hexStringToUIColor(hex: "#6CA743")
        self.addSubview(refrsh)
        refrsh.startAnimating()
        DispatchQueue.global(qos: .background).async {
            let image = Utility().getOptimizeImage(url: url)
            DispatchQueue.main.async {
                self.image = image
                refrsh.stopAnimating()
                refrsh.removeFromSuperview()
            }
        }
    }
 }
 
 extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
 }
 
 extension UIView {
    
    /// Flip view horizontally.
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
    
 }
 
 extension UIScrollView {
    func clear() {
        for x in subviews {
            x.removeFromSuperview()
        }
    }
    
    func setContentSizeHeight(translucant: Bool) {
        var bigger: CGFloat = 0
        for x in self.subviews {
            if(x.frame.maxY > bigger) {
                bigger = x.frame.maxY
                print(x.classForCoder)
            }
        }
        let offset : CGFloat = translucant ? 0 : 64
        self.contentSize = CGSize(width: 0, height: bigger + 10 + offset)
    }
    
    func setContentSizeWidth() {
        var bigger: CGFloat = 0
        for x in self.subviews {
            if(x.frame.maxX > bigger) {
                bigger = x.frame.maxX
                print(x.classForCoder)
            }
        }
        self.contentSize = CGSize(width: bigger + 10, height: 1)
    }
 }
 
 
 
 class UISwitchButton : UIView {
    var buttonViews = [UIView]()
    var colorSelected = UIColor.black
    var colorNotSelected = UIColor.white
    var fontName = "Ubuntu-Regular"
    var fontSize : CGFloat = 13
    private var canSelect = true
    
    var actionAfterChange : (()->())!
    override init(frame: CGRect) {
        super.init(frame : frame)
    }
    
    func selectElement(sender: UITapGestureRecognizer) {
        if(canSelect) {
            canSelect = false
            let lastSelectedView = buttonViews[selectedIndex()]
            
            
            DispatchQueue.global(qos: .background).async {
                var viewAnim = UIView()
                DispatchQueue.main.async {
                    viewAnim.backgroundColor = self.colorSelected
                    viewAnim.layer.zPosition = 1
                    viewAnim.layer.cornerRadius = lastSelectedView.layer.cornerRadius
                    viewAnim.frame = (lastSelectedView.frame)
                    self.addSubview(viewAnim)
                    for x in self.buttonViews {
                        x.backgroundColor = self.colorNotSelected
                        x.layer.zPosition = 0
                    }
                }
                usleep(1000 * 100)
                let diffMinX = (sender.view?.frame.minX)! -  viewAnim.frame.minX
                var totalTick : CGFloat = 0
                let oldX = viewAnim.frame.minX
                while(totalTick <= 1.0) {
                    totalTick += (0.01 * 1.5)
                    
                    DispatchQueue.main.async {
                        viewAnim.frame = CGRect(x: oldX + (diffMinX * totalTick) , y: viewAnim.frame.minY, width: viewAnim.frame.width, height: viewAnim.frame.height)
                    }
                    usleep(100)
                }
                DispatchQueue.main.async {
                    viewAnim.removeFromSuperview()
                    sender.view?.backgroundColor = self.colorSelected
                    sender.view?.layer.zPosition = 1
                    self.actionAfterChange?()
                    self.canSelect = true
                }
                
                
                
            }
            
        }
        
        
    }
    
    func selectedIndex() -> Int {
        if(buttonViews.count == 0) {return 0}
        for x in 0...buttonViews.count - 1 {
            if(buttonViews[x].backgroundColor == colorSelected) {
                return x
            }
        }
        return 0
    }
    
    
    
    func initAllButton(array: [String]) {
        var xAt: CGFloat = 0
        
        for x in array {
            let v = UIView()
            v.frame = CGRect(x: xAt, y: 0, width: frame.width * (1 / CGFloat(array.count)) + CGFloat(15), height: frame.height)
            if(xAt != 0) {
                v.backgroundColor = colorNotSelected
                v.layer.zPosition = 0
            } else {
                v.backgroundColor = colorSelected
                v.layer.zPosition = 1
            }
            v.layer.cornerRadius = layer.cornerRadius
            v.clipsToBounds = clipsToBounds
            v.isUserInteractionEnabled = true
            v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectElement(sender:))))
            
            //            let l = DesignLabel()
            //            l.awakeFromNib()
            //            l.textColor = Utility().hexStringToUIColor(hex: "#ACAFB3")
            //            l.text = x
            //            l.layer.zPosition = 2
            //            l.isUserInteractionEnabled = false
            //            l.font = UIFont(name: fontName, size: fontSize)
            //            l.frame = CGRect(x: 0, y: 0, width: v.frame.width, height: v.frame.height)
            //            l.textAlignment = .center
            //            v.addSubview(l)
            //            xAt +=  (frame.width * (1 / CGFloat(array.count)) - 15)
            //            buttonViews.append(v)
            //            addSubview(v)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 }
 
 
 extension UIView{
    func makeShadow(x:CGFloat,y:CGFloat,blur:CGFloat,cornerRadius:CGFloat,shadowColor:UIColor,shadowOpacity:Float,spread:CGFloat){
        
        let radius: CGFloat = self.frame.width / spread
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: (spread) * radius, height: self.frame.height))
        
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: x, height: y)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = blur
        self.layer.masksToBounds =  false
        self.layer.shadowPath = shadowPath.cgPath
    }
 }
 
 extension UITextField{
    
    func setUpPlaceholder(color:UIColor,fontName:String,fontSize:CGFloat){
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : color,NSFontAttributeName : UIFont(name: fontName, size: fontSize)!])
    }
 }
 
 extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
        self.attributedText = attributedString
    }
    
    func createLabel(frame:CGRect,textColor:UIColor,fontName:String,fontSize:CGFloat,textAignment:NSTextAlignment,text:String){
        self.frame = frame
        self.textColor = textColor
        self.font = UIFont(name:fontName, size: fontSize)
        self.textAlignment = textAignment
        self.text = text
    }
 }
 
 
 extension UIView{
    func setGradientBackground(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [color1, color2]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func addDashedBorder(color:UIColor,lineWidth:CGFloat,linePattern:[NSNumber]) {
        let color = color
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = linePattern
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: shapeRect.width/2).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
 }
 

 


