//
//  SentMemesTableViewController.swift
//  MemeMe2
//
//  Created by Luiz Arantes Sa on 3/30/19.
//  Copyright © 2019 Luiz Arantes Sa. All rights reserved.
//

import UIKit


class SentMemesTableViewController: UITableViewController {

    var memes: [Meme]! {
        return Meme.allMemes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sent Memes"
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.setupMemeEditorButton()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath)
        let meme = self.memes[indexPath.row]
        cell.textLabel!.text = meme.topText + "..." + meme.bottomText
        cell.textLabel!.lineBreakMode = .byTruncatingMiddle
        cell.imageView!.contentMode = .scaleAspectFit
        cell.imageView!.image = meme.memedImage

        // cell.imageView!.contentMode = .scaleAspectFit
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = storyboard!.instantiateViewController(withIdentifier: MemeDetailViewController.className) as! MemeDetailViewController
        detail.image = self.memes[indexPath.row].memedImage
        self.navigationController!.pushViewController(detail, animated: true)
    }

    override func unwind (_ sender: UIStoryboardSegue) {
        if sender.source is MemeEditorViewController {
            self.tableView.reloadData()
        }
    }
}
