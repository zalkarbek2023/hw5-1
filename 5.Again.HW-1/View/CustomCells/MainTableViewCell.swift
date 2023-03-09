//
//  MainTableViewCell.swift
//  5.Again.HW-1
//
//  Created by zalkarbek on 8/3/23.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    static var tableViewCellReuseID = String(describing: MainTableViewCell.self)
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    private var product: ProductModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func displayInfo(_ items: ProductModel) {
        product = items
        mainLabel.text! = items.title
        loadImageURL(url: items.images.first!)
    }

    func loadImageURL(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.mainImage.image = UIImage(data: data)!
            }
        }
        task.resume()
    }
    
}
