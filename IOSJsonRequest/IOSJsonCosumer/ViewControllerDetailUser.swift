//
//  ViewControllerDetailUser.swift
//  IOSJsonCosumer
//
//  Created by Haikal Rios on 19/10/17.
//  Copyright © 2017 IESB. All rights reserved.
//

import UIKit




class ViewControllerDetailUser: UIViewController{

    @IBOutlet weak var tableViewAlbum: UITableView!{
        didSet{
            tableViewAlbum.delegate = self
            tableViewAlbum.dataSource = self
        }
    }
    @IBOutlet weak var imagePerfil: UIImageView!
    @IBOutlet weak var labelWebSite: UILabel!
    @IBOutlet weak var labelMail: UILabel!
    @IBOutlet weak var labelNome: UILabel!

    @IBAction func pressEditarPhoto(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        self.present(picker, animated: true, completion: nil)
       
    }
    
    var user: UserTO?
    
   override func viewDidLoad() {
        super.viewDidLoad()
        labelNome.text = user?.name
        labelMail.text = user?.email
        labelWebSite.text = user?.website

    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewControllerDetailUser: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albuns", for: indexPath) as! TableViewCellAlbum
        
        
        
        return cell
    }


}

extension ViewControllerDetailUser: UITableViewDelegate{
    
}


extension ViewControllerDetailUser: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imagePerfil.image = image
        dismiss(animated:true, completion: nil)

    }
}


