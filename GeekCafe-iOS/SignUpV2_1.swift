//
//  SignUpV2_1.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-22.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import Photos

class SignUpv2_1:UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    let backgroundView = BackgroundView()
    let imagePicker = UIImagePickerController()
    let buttonCamera = UIButton()
    
    var TB_Prenom = CustomTextField()
    var TB_Nom = CustomTextField()
    var TB_Birth = CustomTextField()
    var TB_Password = CustomTextField()
    var TB_ConfirmPassword = CustomTextField()
    var profileImage = UIImage()
    var isImageSet:Bool = false
    
    var isKeyboardActive:Bool = false
    
    var arrayTB = [CustomTextField]()
    let arrayPlaceholder = ["Prénom","Nom de famille","Date de naissance","Mot de passe","Confirmer le mot de passe"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillarrayTB()
        arrayTB[2].addTarget(self, action: #selector(DP(_:)), for: .editingDidBegin)
        imagePicker.delegate = self
        basicsSetUp()
        buildBackground()
        addButtonModifyImage()
        setUpTextFields()
        setUpButtonNext()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    @IBAction func DP(_ sender: UITextField) {
        
        let datePickerView = UIDatePicker()
        datePickerView.backgroundColor = .white
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        TB_Birth.text = dateFormatter.string(from: sender.date)
        
    }
    
    func fillarrayTB(){
        arrayTB = [TB_Prenom,TB_Nom,TB_Birth,TB_Password,TB_ConfirmPassword]
    }
    
    func basicsSetUp(){
        setTouchForEndEditing()
        self.view.backgroundColor = Utility().hexStringToUIColor(hex: "#6CA642")
    }
    func setTouchForEndEditing(){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func addButtonModifyImage(){
        
        buttonCamera.frame = CGRect(x: rw(212), y: rh(118), width: rw(34), height: rw(34))
        buttonCamera.backgroundColor = UIColor.white
        buttonCamera.makeShadow(x: 0, y: 1, blur: 3, cornerRadius: rw(34)/2, shadowColor: UIColor.black, shadowOpacity: 0.5, spread: 0)
        buttonCamera.setImage(UIImage(named:"cameraSignUp"), for: .normal)
        buttonCamera.imageEdgeInsets = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
        buttonCamera.addTarget(self, action: #selector(changeImage), for: .touchUpInside)
        view.addSubview(buttonCamera)
    }
    
    func setUpTextFields(){
        var newY = rh(308)
        var index:Int  = 0
        for x in arrayTB{
            
            x.setUpTB(placeholderText: arrayPlaceholder[index], containerView: self.view, xPos: rw(51), yPos: newY,superView:self.view, heightToGo: rh(216))
            if(index == 3 || index == 4){
                x.isSecureTextEntry = true
            }
            view.addSubview(x)
            index += 1
            newY += rh(57)
        }
    }
    
    func setUpButtonNext(){
        let buttonNext = UIButton()
        buttonNext.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        buttonNext.frame = CGRect(x: rw(69), y: rh(599), width: rw(237), height: rh(45))
        buttonNext.backgroundColor = UIColor.white
        buttonNext.setTitle("Suivant", for: .normal)
        buttonNext.setTitleColor(Utility().hexStringToUIColor(hex: "#AFAFAF"), for: .normal)
        buttonNext.titleLabel?.font = UIFont(name: "Lato-Regular", size: rw(16))
        buttonNext.makeShadow(x: 0, y: 2, blur: 6, cornerRadius: 8, shadowColor: UIColor.black, shadowOpacity: 0.12, spread: 0)
        self.view.addSubview(buttonNext)
    }
    
    @objc func nextPressed(){
        if(TB_Nom.text != "" && TB_Prenom.text != "" && TB_Birth.text != "" && TB_Password.text != "" && TB_ConfirmPassword.text != ""){
            if(TB_Password.text!.count >= 7){
                if(TB_ConfirmPassword.text == TB_Password.text){
                    performSegue(withIdentifier: "toSignUpV2_2", sender: nil)
                }
                else{
                    Utility().alert(message: "Les mots de passe ne correspond pas.", title: "Message", control: self)
                }
            }
            else{
                Utility().alert(message: "Votre mot de passe doit contenir au minimum 7 caratères.", title: "Message", control: self)
            }
        }
        else{
            Utility().alert(message: "Vous devez remplir tout les champs", title: "Message", control: self)
        }
    }
    
    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    
    func buildBackground(){
        backgroundView.frame = self.view.frame
        backgroundView.setUpElements(containerView: self.view, frameImageTop: CGRect(x: rw(135), y: rh(46), width: rw(111), height: rh(106)), frameFirstLabel: CGRect(x:rw(0),y:rh(166),width:view.frame.width,height:rh(27)), frameCard: CGRect(x: rw(21), y: rh(275), width: rw(334), height: rh(402)), text1: "Parlez-nous de vous",text2:"Complètez votre compte.")
        self.view.addSubview(backgroundView)
    }
    
    
    func setUpImageProfile(){
        if(!isImageSet){
            backgroundView.addProfilePicture(image: profileImage,containerView:self.view)
            buttonCamera.layer.zPosition = 1
            isImageSet = true
        }
        else{
            backgroundView.changeImageTop(image: profileImage)
        }
    }
    ///*****************
    //Camera Delegate
    //*****************
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage = pickedImage
            setUpImageProfile()
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
    
    @objc func changeImage(){
        Utility().alertWithChoice(message: "", title: "", control: self, actionTitle1: "Prendre une photo", actionTitle2: "Choisir une photo existante", action1: takePicture, action2: loadPicture, style: .actionSheet)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSignUpV2_2"){
            (segue.destination as! SignUpV2_2).name = TB_Prenom.text
            (segue.destination as! SignUpV2_2).lastname = TB_Nom.text
            (segue.destination as! SignUpV2_2).birthdate = TB_Birth.text
            (segue.destination as! SignUpV2_2).password = TB_Password.text
            (segue.destination as! SignUpV2_2).image = self.profileImage
            (segue.destination as! SignUpV2_2).isImageSet = self.isImageSet
        }
    }
}
