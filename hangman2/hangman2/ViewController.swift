//
//  ViewController.swift
//  hangman2
//
//  Created by avier Hernandez on 2/5/2022.
//  Copyright © 2022 Javier Hernandez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayWordLabel: UILabel!
    @IBOutlet weak var wrongLetters: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var hangmanImage: UIImageView!
    
    //These are the words people will try to guess
    var wordArray = ["JAVIER", "VICTOR", "MIGUEL"]
    var set1 = ["PERRO", "CINCO","CARRO","JARRA","CHAVA"]
    var set2 = ["ABRAZO","BALAZO","IPHONE","MORADO","AMIGOS"]
    var set3 = ["CABELLO","CROACIA","ALGEBRA","TRAFICO","SOBORNO"]
    var set1Active = true
    var set2Active = false
    var set3Active = false
    
    
     var word = ""
    
    
    var wrongLettersArray = [Character]()
    
   
    var usedLetters = [Character]()
    
   
    var displayWordArray = [Character]()
    
    
    var displayWord = ""
    
   
    var guess: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        word = set1.randomElement()!
        
        usedLetters = Array(word)
       
        for i in 1...word.count{
            
            displayWord += "?"
            
            displayWordLabel.text = displayWord
            displayWordArray=Array(displayWord)
        }
        
    }
    
    //Este botón es para adivinar si la letra que eligió se ecnuentra en el set de ese momento

    @IBAction func guessButton(_ sender: UIButton) {
        
        guessTextField.resignFirstResponder()
        
       
        let guess1 = guessTextField.text
        
        if guess1 == ""{
            guessTextField.placeholder = "Ingresa una letra"
        }else if guess1!.count > 1{
            guessTextField.placeholder = "Ingresa otra letra"
        }else{
            guess = Character(guessTextField.text!.capitalized)
            
            checkForLetter()
            displayWord = String(displayWordArray)
            displayWordLabel.text = displayWord
            guessTextField.text = ""
            checkForWin()
        }
        
        
        
    }
    
    //este botón reinicia el set
    
    @IBAction func resetButton(_ sender: UIButton) {
        
        guessTextField.text = ""
        hangmanImage.image = UIImage(contentsOfFile: "")
        gameImage.image = UIImage(contentsOfFile: "")
        wrongLettersArray = []
        wrongLetters.text = ""
        displayWord = ""
        
        
        
        
        if(set1Active==true){
            word = set1.randomElement()!
            usedLetters = Array(word)
        }else if(set2Active==true){
            word = set2.randomElement()!
            usedLetters = Array(word)
        }else{
            word = set3.randomElement()!
            usedLetters = Array(word)
        }
        
       
        
        for i in 1...word.count{
            displayWord += "?"
            displayWordLabel.text = displayWord
            displayWordArray = Array(displayWord)
        }
        
        
    }
    
    //Esta función checa si la letra existe en la palabra del set y si no hace llamar a la función placeImage
    
    func checkForLetter(){
        
        if usedLetters.contains(guess){
            
            for i in 0...word.count - 1 {
                if guess == usedLetters[i]{
                    displayWordArray[i] = guess
                }
            }
            
        }else {
            wrongLettersArray.append(guess)
            wrongLetters.text = String(wrongLettersArray)
            placeImage()
        }
        
    }
    
    //En caso de tener una letra incorrecta se activa esta función para ir poniendo las imágenes del ahorcado
    
    func placeImage(){
        let p1 = UIImage(named: "foto1")
        let p2 = UIImage(named: "foto2")
        let p3 = UIImage(named: "foto3")
        let p4 = UIImage(named: "foto4")
        let p5 = UIImage(named: "foto5")
        let p6 = UIImage(named: "foto6")
        
        let imageArray = [p1, p2, p3, p4, p5, p6]
        
        hangmanImage.image = imageArray[wrongLettersArray.count-1]
    }
    
    //Esta función activa que cuando haya 6 errores se pierda el juego
    
    func checkForWin(){
        
        if wrongLettersArray.count == 6{
            
            gameImage.image = UIImage(named: "gameOver2")
            
        }else if displayWord.contains("?"){
            
            
        }else{
            resetAll()
        }
    }
    
    //cuando el usuario pasa de nivel se activa esta función
    
    func resetAll(){
        guessTextField.text = ""
        hangmanImage.image = UIImage(contentsOfFile: "")
        gameImage.image = UIImage(contentsOfFile: "")
        wrongLettersArray = []
        wrongLetters.text = ""
        displayWord = ""
        
        if(set1Active==true){
            word = set2.randomElement()!
            usedLetters = Array(word)
            set1Active=false
            set2Active=true
        }else if(set2Active==true){
            word = set3.randomElement()!
            usedLetters = Array(word)
            set2Active=false
            set3Active=true
        }else if(set3Active==true){
            gameImage.image = UIImage(named: "youWin2")
        }
        
        
        
        for i in 1...word.count{
            displayWord += "?"
            displayWordLabel.text = displayWord
            displayWordArray = Array(displayWord)
        }
    }
}

