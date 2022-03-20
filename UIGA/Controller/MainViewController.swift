//
//  MainViewController.swift
//  UIGA
//
//  Created by Nikita Sibirtsev on 17/03/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBAction func moveToWeather(_ sender: CustomButton) {
        performSegue(withIdentifier: "weather", sender: nil)
        
        
    }
    
    @IBAction func moveToDa40(_ sender: CustomButton) {
        performSegue(withIdentifier: "da40", sender: nil)
    }
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weather" {
            let destinationVC = segue.destination as! WeatherViewController
        }
        
    }*/
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
