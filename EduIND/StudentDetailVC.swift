//
//  StudentDetailVC.swift
//  EduIND
//
//  Created by Abhishet on 31/05/2016.
//  Copyright © 2016 Abhishet. All rights reserved.
//

import UIKit

class StudentDetailVC: UIViewController {
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentAge: UILabel!
    @IBOutlet weak var studentAddress: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    @IBOutlet weak var studentDesc: UITextView!
    
    var name:String!
    var age:String!
    var address:String!
    var image:NSData!
    var desc:String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        studentName.text = name
        studentAge.text = age
        studentAddress.text = address
        studentImage.image = UIImage(data: image)
        studentDesc.text = desc
    }
    
    func setDetails(name:String, age:String, city:String, state:String, country:String, desc:String, image:NSData) {
        self.name = name
        self.age = age
        self.address = "\(city), \(state), \(country)"
        self.desc = desc
        self.image = image
    }
    
}
