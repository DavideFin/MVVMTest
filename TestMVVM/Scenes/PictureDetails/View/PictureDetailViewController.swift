//
//  PictureDetailViewController.swift
//  TestMVVM
//
//  Created by Davide Fin on 27/02/2020.
//  Copyright © 2020 Davide Fin. All rights reserved.
//

import UIKit

class PictureDetailViewController: UIViewController {

    @IBOutlet weak var theImageView: UIImageView!
    
    var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = self.picture {
            if let picture_url = URL( string: data.image_url ) {
                theImageView.kf.setImage(with: picture_url)
            }
        }
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
