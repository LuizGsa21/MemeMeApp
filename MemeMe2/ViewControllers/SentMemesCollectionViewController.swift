//
//  SentMemesCollectionViewController.swift
//  MemeMe2
//
//  Created by Luiz Arantes Sa on 3/30/19.
//  Copyright © 2019 Luiz Arantes Sa. All rights reserved.
//

import UIKit

private let reuseIdentifier = MemeCollectionViewCell.className

class SentMemesCollectionViewController: UICollectionViewController {


    
    var memes: [Meme]! {
        return Meme.allMemes
    }
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    
    override func loadView() {
        super.loadView()
        self.flowLayout = (self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout)
        self.setupMemeEditorButton()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sent Memes"
        updateItemSize(containerSize: self.view.bounds.size)
    }

    override func viewWillLayoutSubviews() {
        print()
    }

    func updateItemSize(containerSize: CGSize ) {
        // viewWillTransition is getting called before self.view.
        // This occurs when we rotate from the table view tab.
        guard self.flowLayout != nil else {
            return;
        }

        let spacing: CGFloat = 3.0
        let dimension = (containerSize.width - (2.0 * spacing)) / 3
        
        self.flowLayout.minimumLineSpacing = spacing
        self.flowLayout.minimumInteritemSpacing = spacing
        self.flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        self.collectionViewLayout.invalidateLayout()

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateItemSize(containerSize: size)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detail = storyboard!.instantiateViewController(withIdentifier: MemeDetailViewController.className) as! MemeDetailViewController
        detail.image = self.memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detail, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        
        var meme = self.memes[indexPath.row]
        // cell.textLabel?.text = meme.name
        cell.backgroundColor = UIColor.black
        cell.imageView!.image = meme.memedImage
    
        // Configure the cell
    
        return cell
    }

}
