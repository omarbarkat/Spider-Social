//
//  TagsVC.swift
//  swift-up
//
//  Created by Omar barkat on 19/11/2023.
//

import UIKit

class TagsVC: UIViewController {
   var arrTags = ["dog","golden" , "daytime","nature","new","pet","ruzno","random","sea","winter","women"]
    @IBOutlet weak var collectionViewTags: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewTags.delegate = self
        collectionViewTags.dataSource = self
        
//        PostAPI.GetAllTags { tags in
//            print(tags)
//
//            self.arrTags = tags
//            self.collectionViewTags.reloadData()
//        }
    }
    


}
extension TagsVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTags.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCell", for: indexPath) as! TagsCell
        let currentCell = arrTags[indexPath.row]
        print(currentCell)
        cell.lblTags.text = currentCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let SelectedItem = arrTags[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "posts") as! PostsVC
        vc.arrTags = SelectedItem
        
        present(vc, animated: true, completion: nil)
    }
}
