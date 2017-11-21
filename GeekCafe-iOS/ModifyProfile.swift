//
//  ModifyProfile.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-15.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import Photos

class ModifyProfile:UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var profileImage = UIImageView()
    let imagePicker = UIImagePickerController()
    let saveButton = UIButton()
    let bottomView = UIView()
    var activeViewBot = UIView()
    let choices = ["Modify Email","Modify Password","Modify Other informations"]
    
    //Email
    let TB_Email = CustomTextField()
    let TB_ConfirmEmail = CustomTextField()
    let TB_ChangeEmaiPass = CustomTextField()
    
    //Password
    let TB_OldPassword = CustomTextField()
    let TB_Password = CustomTextField()
    let TB_ConfirmPass = CustomTextField()
    
    //Other Information
    let TB_Nom = CustomTextField()
    let TB_NomFamille = CustomTextField()
    let TB_Phone = CustomTextField()
    
    var subPageIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        setNavigationTitle()
        setUpMenuChoices()
        setUpTopPart()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    //Title and title color
    func setNavigationTitle(){
        self.title = "Modify Profile"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name:"Lato-Regular",size:rw(17))!, NSAttributedStringKey.foregroundColor:Utility().hexStringToUIColor(hex: "#AFAFAF")]
    }
    
    func setUpTopPart(){
        let containerTop = UIView()
        containerTop.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: rh(244))
        containerTop.backgroundColor = UIColor.white
        containerTop.makeShadow(x: 0, y: 2, blur: 3, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        view.addSubview(containerTop)
        
        
        profileImage.frame = CGRect(x: rw(133), y: rh(93), width: rw(111), height: rw(111))
        profileImage.layer.cornerRadius = rw(111)/2
        profileImage.getOptimizeImageAsync(url: Global.global.userInfo.image_url)
        profileImage.layer.masksToBounds = true
        view.addSubview(profileImage)
        
        let buttonChangeImage = UIButton()
        buttonChangeImage.frame = CGRect(x: rw(209), y: rh(165), width: rw(34), height: rw(34))
        buttonChangeImage.setImage(UIImage(named:"changeImage"), for: .normal)
        buttonChangeImage.backgroundColor = UIColor.white
        buttonChangeImage.imageEdgeInsets = UIEdgeInsets(top: 9, left: 7, bottom: 9, right: 7)
        buttonChangeImage.makeShadow(x: 0, y: 1, blur: 3, cornerRadius: rw(34)/2, shadowColor: UIColor.black, shadowOpacity: 0.5, spread: 0)
        buttonChangeImage.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
        view.addSubview(buttonChangeImage)
    }
    
    func setUpMenuChoices(){
        var newY:CGFloat = 0
        var index:Int = 1
        
        bottomView.frame = CGRect(x: 0, y: rh(244), width: view.frame.width, height: view.frame.height - rh(244))
        bottomView.backgroundColor = UIColor.white
        view.addSubview(bottomView)
        
        for x in choices{
            
            let buttonContainer = UIButton()
            buttonContainer.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: rh(82))
            buttonContainer.backgroundColor = UIColor.white
            buttonContainer.tag = index
            buttonContainer.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
            bottomView.addSubview(buttonContainer)
            
            let title = UILabel()
            title.createLabel(frame: CGRect(x:rw(14),y:rh(32),width:rw(250),height:rh(18)), textColor: Utility().hexStringToUIColor(hex: "#303841"), fontName: "Lato-Regular", fontSize: rw(16), textAignment: .left, text: x)
            buttonContainer.addSubview(title)
            
            let fleche = UIImageView()
            fleche.frame = CGRect(x: rw(328), y: rh(30), width: rw(20), height: rw(20))
            fleche.image = #imageLiteral(resourceName: "rightArrow")
            fleche.contentMode = .scaleAspectFit
            buttonContainer.addSubview(fleche)
            
            Utility().createHR(x: 0, y: buttonContainer.bounds.maxY - 1, width: view.frame.width, view: buttonContainer, color: Utility().hexStringToUIColor(hex: "#E7E8E9"))
            
            index += 1
            newY += rh(82)
        }
    }
    
    func buildButtonSave(){
        saveButton.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: rh(67))
        saveButton.backgroundColor = UIColor.white
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        saveButton.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(16))
        saveButton.addTarget(self, action: #selector(savedPressed), for: .touchUpInside)
        saveButton.makeShadow(x: 4, y: 2, blur: 6, cornerRadius: 0.1, shadowColor: UIColor.black, shadowOpacity: 0.35, spread: 0)
        view.addSubview(saveButton)
    }

    
    func animateIn(function:@escaping ()->(UIView)){
        
        setBarItemsAnimateIn()
        buildButtonSave()
        
        let viewToAnimateIn:UIView = function()
        activeViewBot = viewToAnimateIn
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            self.bottomView.center.x -= self.view.frame.width
            self.saveButton.center.y -= self.rh(67)
            viewToAnimateIn.center.x -= self.view.frame.width
        }, completion: { _ in
            self.bottomView.isHidden = true
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func animateButOut(){
        setBarItemsAnimateOut()
        self.view.isUserInteractionEnabled = false
        self.bottomView.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear, animations: {
            self.bottomView.center.x += self.view.frame.width
            self.saveButton.center.y += self.rh(67)
            self.activeViewBot.center.x += self.view.frame.width
        }, completion: { _ in
            for x in self.activeViewBot.subviews{
                if let tb = x as? UITextField{
                    tb.text = ""
                }
            }
            self.activeViewBot.removeFromSuperview()
            self.saveButton.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        })
    }
   
    func setBarItemsAnimateIn(){
        let add = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tappedCancel))
        self.navigationItem.rightBarButtonItem = add
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func setBarItemsAnimateOut(){
        self.navigationItem.setRightBarButton(nil, animated: false)
        self.navigationItem.setHidesBackButton(false, animated: false)
    }
    
    
    
    func buildEmailView()->UIView{
        let containerView = UIView()
        containerView.frame = CGRect(x: view.frame.width, y: rh(244), width: view.frame.width, height: view.frame.height - rh(244) - rh(67))
        containerView.layer.zPosition = -1
        containerView.backgroundColor = UIColor.white
        
        TB_Email.setUpTB(placeholderText: "Current Email", containerView: containerView, xPos: rw(52), yPos: rh(40), superView: self.view,text:Global.global.userInfo.email)
        
        TB_ConfirmEmail.setUpTB(placeholderText: "New Email", containerView: containerView, xPos: rw(52), yPos: rh(110), superView: self.view)
        
        TB_ChangeEmaiPass.setUpTB(placeholderText: "Password", containerView: containerView, xPos: rw(52), yPos: rh(180), superView: self.view)
        TB_ChangeEmaiPass.isSecureTextEntry = true
        
        view.addSubview(containerView)
        return containerView
    }
    
    func buildModifyPassword()->UIView{
        let containerView = UIView()
        containerView.frame = CGRect(x: view.frame.width, y: rh(244), width: view.frame.width, height: view.frame.height - rh(244) - rh(67))
        containerView.layer.zPosition = -1
        containerView.backgroundColor = UIColor.white
        
        TB_OldPassword.setUpTB(placeholderText: "Old Password", containerView: containerView, xPos: rw(52), yPos: rh(40), superView: self.view)
        TB_OldPassword.isSecureTextEntry = true
        
        TB_Password.setUpTB(placeholderText: "New Password", containerView: containerView, xPos: rw(52), yPos: rh(110), superView: self.view)
        TB_Password.isSecureTextEntry = true
        
        TB_ConfirmPass.setUpTB(placeholderText: "Confirm New Password", containerView: containerView, xPos: rw(52), yPos: rh(180), superView: self.view)
        TB_ConfirmPass.isSecureTextEntry = true
        
        view.addSubview(containerView)
        return containerView
    }
    
    func buildModifyOthers()->UIView{
        let containerView = UIView()
        containerView.frame = CGRect(x: view.frame.width, y: rh(244), width: view.frame.width, height: view.frame.height - rh(244) - rh(67))
        containerView.layer.zPosition = -1
        containerView.backgroundColor = UIColor.white
        
        
        TB_Nom.setUpTB(placeholderText: "Firstname", containerView: containerView, xPos: rw(52), yPos: rh(40), superView: self.view,text:Global.global.userInfo.firstname)
        
        TB_NomFamille.setUpTB(placeholderText: "Lastname", containerView: containerView, xPos: rw(52), yPos: rh(110), superView: self.view,text: Global.global.userInfo.lastname)
        
        TB_Phone.setUpTB(placeholderText: "Phone number", containerView: containerView, xPos: rw(52), yPos: rh(180), superView: self.view,text: Global.global.userInfo.phone)
        
        view.addSubview(containerView)
        return containerView
    }
    
    
    ///*****************
    //Camera Delegate
    //*****************
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if(APIRequestProfile().uploadProfileImage(base64: APIRequestProfile().imageToBase64(image: pickedImage))){
                profileImage.image = Utility().getOptimizeImage(url: Global.global.userInfo.image_url)
                (Utility().previousView(control: self) as! MainPageProfile).menu.updateImageProfile()
                (Utility().previousView(control: self) as! MainPageProfile).profileImage.image = Utility().getOptimizeImage(url: Global.global.userInfo.image_url)
                
            }
        }
        dismiss(animated: true) {
            //DISMISS
        }
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func takePicture() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .camera
                self.imagePicker.cameraDevice = .front
                self.imagePicker.allowsEditing = false
                self.imagePicker.cameraCaptureMode = .photo
                self.imagePicker.showsCameraControls = true
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {}
        }
        
    }
    
    func loadPicture() {
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.allowsEditing = true
                    self.present(self.imagePicker, animated: true, completion: nil)
                } else {}
            })
        }
        else if(photos == .authorized){
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        else if(photos == .denied){
            Utility().alert(message: "Can not access photo library. You need to activate it in your settings", title: "Message", control: self)
        }
    }
    
    @objc func buttonPressed(sender:UIButton){
        if(sender.tag == 1){
            subPageIndex = 1
            animateIn(function: buildEmailView)
        }
        if(sender.tag == 2){
            subPageIndex = 2
            animateIn(function: buildModifyPassword)
        }
        if(sender.tag == 3){
            subPageIndex = 3
            //MODIFIER OTHERS
            animateIn(function: buildModifyOthers)
        }
    }
    
    @objc func savedPressed(){
        //MODIFY EMAIL
        if(subPageIndex == 1){
            if(TB_Email.text != "" && TB_ConfirmEmail.text != "" && TB_ChangeEmaiPass.text != ""){
               
                if(APIRequestProfile().modifyEmail(newemail: TB_ConfirmEmail.text!, password: TB_ChangeEmaiPass.text!)){
                    animateButOut()
                    Utility().alert(message: "Email changed successfully", title: "Message", control: self)
                }
                else{
                    Utility().alert(message: "Error while changing your email", title: "Error", control: self)
                }
                
            }
            else{
                Utility().alert(message: "You need to fill all fields", title: "Message", control: self)
            }
        }
        //MODIFY PASSWORD
        else if(subPageIndex == 2){
            if(TB_Password.text != "" && TB_ConfirmPass.text != "" && TB_OldPassword.text != ""){
                if(TB_Password.text! == TB_ConfirmPass.text!){
                    if(APIRequestProfile().modifyPassword(oldpassword: TB_OldPassword.text!, newpassword: TB_Password.text!)){
                        animateButOut()
                        Utility().alert(message: "Password changed successfully", title: "Message", control: self)
                    }
                    else{
                        Utility().alert(message: "Error while changing your password", title: "Error", control: self)
                    }
                }
                else{
                    Utility().alert(message: "Password and confirmation does not match", title: "Message", control: self)
                }
                
            }
            else{
                Utility().alert(message: "You need to fill all fields", title: "Message", control: self)
            }
        }
         
        //MODIFY OTHER INFORMATIONS
        else if(subPageIndex == 3){
            if(TB_NomFamille.text != "" && TB_Nom.text != "" && TB_Phone.text != ""){
                if(APIRequestProfile().modifyUser(first_name: TB_Nom.text!, last_name: TB_NomFamille.text!,phone: TB_Phone.text!)){
                    animateButOut()
                    Utility().alert(message: "Informations changed successfully", title: "Message", control: self)
                }
                else{
                    Utility().alert(message: "Error while changing your informations", title: "Error", control: self)
                }
            }
            else{
                Utility().alert(message: "You need to fill all fields", title: "Message", control: self)
            }
        }
    }
    
    @objc func changeImage(){
        Utility().alertWithChoice(message: "", title: "", control: self, actionTitle1: "Prendre une photo", actionTitle2: "Choisir une photo existante", action1: takePicture, action2: loadPicture, style: .actionSheet)
    }
    
    @objc func tappedCancel(){
        animateButOut()
    }
}
