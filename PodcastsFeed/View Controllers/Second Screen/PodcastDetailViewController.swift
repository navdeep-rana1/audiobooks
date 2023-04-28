//
//  PodcastDetailViewController.swift
//  PodcastsFeed
//
//  Created by Nav on 27/04/23.
//

import UIKit

class PodcastDetailViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var imagePodcast: UIImageView!
    @IBOutlet weak var buttonFavourite: UIButton!
    @IBOutlet weak var labelDescription: UILabel!
    var model: Podcast?
    var imageLoader: ImageLoader?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewObjects()
        manageFavourite(isFromButton: false)
        
        labelTitle.text = model?.title
        labelAuthor.text = model?.publisher
        labelDescription.attributedText = model?.description.htmlAttributedString()
        guard let imageURL = model?.imageURL else {return}
        imageLoader?.loadImageData(from: imageURL, completion: { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imagePodcast.image = UIImage(data: data)
                }
            case .failure(_):
                
                self?.imagePodcast.image = UIImage(named: "questionmark.app.fill")
            }
        })
        // Do any additional setup after loading the view.
    }
    
    private func setupViewObjects(){
        imagePodcast.layer.cornerRadius = 25
        buttonFavourite.layer.cornerRadius = 10
    }
    
    @IBAction func actionFavourite(_ sender: UIButton) {
        manageFavourite(isFromButton: true)
        
    }
    
    private func manageFavourite(isFromButton: Bool){
        
        guard let model = model else {return}
        if UserDefaults.standard.bool(forKey: model.id) == true{
            if isFromButton{ UserDefaults.standard.set(false, forKey: model.id)
                buttonFavourite.setTitle("Favourite", for: .normal)
            }else{
                buttonFavourite.setTitle("Favourited", for: .normal)
            }
        }else{
            if isFromButton{ UserDefaults.standard.set(true, forKey: model.id)
                buttonFavourite.setTitle("Favourited", for: .normal)
            }else{
                buttonFavourite.setTitle("Favourite", for: .normal)

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
