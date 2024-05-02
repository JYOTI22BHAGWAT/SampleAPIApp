//
//  ViewController.swift
//  SampleAPIApp
//
//  Created by Jyoti Bhagwat on 02/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblUser: UITableView!
    
    var userLists = [userList]()
    var isDataLoading:Bool=false
    var pageNo:Int=0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblUser.delegate = self
        userAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
    }
    
    func userAPI(){
        APIViewmodel().callDataViewModel(urlStr: Constant.baseUrl, method: .get, paramDict: [:]) { (reponseData:[userList]?,response) in
            if reponseData != nil{
                let userObj = reponseData
                if(userObj != nil){
                    self.userLists = userObj ?? [userList]()
                    self.tblUser.reloadData()
                }
            }
        } onFailure: { error in
            print(error.localizedDescription)
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userObj = userLists[indexPath.row]
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.mainView.layer.cornerRadius = 12
        cell.mainView.layer.shadowColor = UIColor.gray.cgColor
        cell.mainView.layer.shadowOpacity = 0.6
        cell.lblID.text = "\(userObj.id ?? 0)"
        cell.lblTitle.text = userObj.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        vc.userDetails = userLists[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        if ((tblUser.contentOffset.y + tblUser.frame.size.height) >= tblUser.contentSize.height)
        {
            if !isDataLoading{
                isDataLoading = true
                pageNo = pageNo + 1
                print("Page No : Count \(pageNo)")
                //Call API with page no as a parameters
            }
        }
    }
}
