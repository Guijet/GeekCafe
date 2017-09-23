//
//  SignUp1.swift
//  GeekCafe-iOS
//
//  Created by Guillaume Jette on 2017-08-30.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class SignUp1: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{

    var arrayTextField = [UITextField]()
    var arrayPlaceholders = ["Prénom","Nom de famille","Genre","Date de naissance"]
    let backgroundImage = UIImageView()
    let imageLogo = UIImageView()
    
    let TB_Prenom = UITextField()
    let TB_Nom = UITextField()
    let TB_Sexe = UITextField()
    let TB_Birth = UITextField()
    
    
    let nextButton = UIButton()
    var isKeyboardActive:Bool = false
    
    //PICKERVIEW
    let pickerViewSexe = UIPickerView()
    let arraySexe:[String] = ["Homme","Femme","Autre"]
    
    //Elements to pass
    var firstName:String!
    var lastName:String!
    var sexe:String!
    var birthdate:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildBackground()
        setUpTop()
        setUpTextFields()
        setUpButton()
        setUpPickerViewAndDatePicker()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    //Background image
    func buildBackground(){
        let tapCancelEditing = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapCancelEditing)
        backgroundImage.setUpBackgroundImage(containerView: self.view)
    }
    
    //Image Geek Cafe Top
    func setUpTop(){
        imageLogo.setUpImageLogoLogin(frame:CGRect(x: rw(135), y: rw(39), width: rw(105), height: rw(131)),containerView:self.view)
    }
    
    func setUpPickerViewAndDatePicker(){
        pickerViewSexe.dataSource = self
        pickerViewSexe.delegate = self
        pickerViewSexe.backgroundColor = UIColor.white
        arrayTextField[2].inputView = pickerViewSexe
        
        arrayTextField[3].addTarget(self, action: #selector(DP(_:)), for: .editingDidBegin)
    }
    
    //TextFields
    func setUpTextFields(){
        arrayTextField = [TB_Prenom,TB_Nom,TB_Sexe,TB_Birth]
        var index = 0
        var yTo:CGFloat = rh(239)
        for x in arrayTextField{
            x.delegate = self
            x.autocorrectionType = .no
            x.frame = CGRect(x: rw(57.5), y: yTo, width: rw(272), height: 34)
            x.placeholder = arrayPlaceholders[index]
            x.setUpPlaceholder(color: Utility().hexStringToUIColor(hex: "#DCDCDC"), fontName: "Lato-Regular", fontSize: rw(20.0))
            x.textAlignment = .center
            view.addSubview(x)
            
            let separator = UIView()
            separator.backgroundColor = Utility().hexStringToUIColor(hex: "#DCDCDC")
            separator.frame = CGRect(x: rw(57.5), y: x.frame.maxY + rh(7), width: rw(272), height: 1)
            view.addSubview(separator)
            
            yTo += rh(60)
            index += 1
        }
    }
    
    
    //Bottom Button
    func setUpButton(){
        
        nextButton.createCreateButton(title: "Suivant", frame: CGRect(x: rw(87), y: rh(561), width: rw(202), height: rh(50)),fontSize:rw(20),containerView:self.view)
        nextButton.addTarget(self, action: #selector(nextPressed(sender:)), for: .touchUpInside)
        //view.addSubview(nextButton)
    }
    
    //
    //
    //TEXT FIELDS DELEGATE
    //AND ANIMATIONS
    //
    //  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(!isKeyboardActive){
            animateMoveUp()
            isKeyboardActive = true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(isKeyboardActive){
            animateMoveDown()
            isKeyboardActive = false
        }
    }
    
    func animateMoveDown(){
        let value:CGFloat = rh(175)
        let buttonMove = rh(35)
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.moveAllViewsDown(value:value)
            self.nextButton.center.y += buttonMove
            self.imageLogo.center.y += buttonMove
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func animateMoveUp(){
        let value:CGFloat = rh(175)
        let buttonMove = rh(35)
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.moveAllViewsUp(value:value)
            self.nextButton.center.y -= buttonMove
            self.imageLogo.center.y -= buttonMove
        }, completion: { _ in
            self.view.isUserInteractionEnabled = true
        })
    }
    
    func moveAllViewsUp(value:CGFloat){
        for x in self.view.subviews{
            x.center.y -= value
        }
    }
    func moveAllViewsDown(value:CGFloat){
        for x in self.view.subviews{
            x.center.y += value
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func endEditing(){
        self.view.endEditing(true)
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
        arrayTextField[2].text = arraySexe[row]
    }
    
    
    //
    //DATEPICKER VIEW FOR BIRTHDAY DELEGATE
    //
    @IBAction func DP(_ sender: UITextField) {
        
        let datePickerView = UIDatePicker()
        datePickerView.backgroundColor = .white
        datePickerView.datePickerMode = .date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        TB_Birth.text = dateFormatter.string(from: sender.date)
        
    }

    //
    //EVENT ON CLICK NEXT
    //
    func nextPressed(sender:UIButton){
        endEditing()
        if(TB_Nom.text != "" && TB_Prenom.text != "" && TB_Sexe.text != "" && TB_Birth.text != ""){
            firstName = TB_Nom.text!
            lastName = TB_Prenom.text!
            sexe = TB_Sexe.text!
            birthdate = TB_Birth.text!
            
            performSegue(withIdentifier: "toSignUp2", sender: nil)
        }
        else{
            Utility().alert(message: "Vous devez remplir tout les champs", title: "Message", control: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toSignUp2"){
            (segue.destination as! SignUp2).firstName = self.firstName
            (segue.destination as! SignUp2).lastName = self.lastName
            (segue.destination as! SignUp2).sexe = self.sexe
            (segue.destination as! SignUp2).birthdate = self.birthdate
        }
    }

}
