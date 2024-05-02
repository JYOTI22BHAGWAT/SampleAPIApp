//
//  UserDetailViewController.swift
//  SampleAPIApp
//
//  Created by Jyoti Bhagwat on 02/05/24.
//

import Foundation
import UIKit

class UserDetailViewController : UIViewController
{
    var userDetails : userList?
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    func setupData() {
        lblID.text = "\(userDetails?.id ?? 0)"
        lblTitle.text = userDetails?.title
        lblDescription.text = userDetails?.body
    }
    //MARK: - Clicks
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

