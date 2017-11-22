//
//  SignUpV2_2.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-11-22.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit
import Photos

class SignUpV2_2: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    var name:String!
    var lastname:String!
    var birthdate:String!
    var password:String!
    var image:UIImage!
    
    let pickerView = UIPickerView()
    let TB_Email = CustomTextField()
    let TB_Phone = CustomTextField()
    let TB_Sexe = CustomTextField()
    
    var arrayTB = [CustomTextField]()
    let arrayPlaceholder = ["Courriel","Téléphone","Genre"]
    let arraySexe = ["Homme","Femme","Autre"]
    
    let backgroundView = BackgroundView()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillarrayTB()
        setUpPickerViewAndDatePicker()
        imagePicker.delegate = self
        basicsSetUp()
        buildBackground()
        addButtonModifyImage()
        setUpTextFields()
        setUpButtonNext()
    }
    
    func setUpPickerViewAndDatePicker(){
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.white
        arrayTB[2].inputView = pickerView
    }
    
    func fillarrayTB(){
        arrayTB = [TB_Email,TB_Phone,TB_Sexe]
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
        let buttonCamera = UIButton()
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
    
    func buildBackground(){
        backgroundView.frame = self.view.frame
        backgroundView.setUpElements(containerView: self.view, frameImageTop: CGRect(x: rw(135), y: rh(46), width: rw(111), height: rh(106)), frameFirstLabel: CGRect(x:rw(0),y:rh(166),width:view.frame.width,height:rh(27)), frameCard: CGRect(x: rw(21), y: rh(275), width: rw(334), height: rh(402)), text1: "Parlez-nous de vous",text2:"Complètez votre compte.")
        self.view.addSubview(backgroundView)
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
        if(TB_Sexe.text != "" && TB_Phone.text != "" && TB_Email.text != ""){
            //VERIFIER PHONE ET EMAIL
            if(APIRequestLogin().verifyEmail(email: TB_Email.text!)){
                performSegue(withIdentifier: "toSignUpV2_3", sender: nil)
            }
            else{
                Utility().alert(message: "Le email entrer est déjà utiliser.", title: "Message", control: self)
            }
        }
        else{
            Utility().alert(message: "Vous devez remplir tout les champs.", title: "Message", control: self)
        }
        
    }

    @objc func endEditing(){
        self.view.endEditing(true)
    }
    
    ///*****************
    //Camera Delegate
    //*****************
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = pickedImage
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
    
    //
    //
    //
    //PICKER VIEW FOR SEXE DELEGATE
    //
    //
    //
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arraySexe[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arraySexe.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        arrayTB[2].text = arraySexe[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSignUpV2_3"){
            (segue.destination as! ChooseCardLoginV2).name = self.name
            (segue.destination as! ChooseCardLoginV2).lastname = self.lastname
            (segue.destination as! ChooseCardLoginV2).birthdate = self.birthdate
            (segue.destination as! ChooseCardLoginV2).password = self.password
            (segue.destination as! ChooseCardLoginV2).image = self.image
            (segue.destination as! ChooseCardLoginV2).email = TB_Email.text
            (segue.destination as! ChooseCardLoginV2).phone = TB_Phone.text
            (segue.destination as! ChooseCardLoginV2).sexe = TB_Sexe.text
        }
    }
    
}
