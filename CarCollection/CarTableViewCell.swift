//
//  CarTableViewCell.swift
//  CarCollection
//
//  Created by Zholbarys on 08.11.2024.
//

import UIKit

class CarTableViewCell: UITableViewCell {
 
    @IBOutlet var carTitleLabel: UILabel!
    @IBOutlet var carYearLabel: UILabel!
    @IBOutlet var carPosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "CarTableViewCell "
    
    static func nib() -> UINib{
        return UINib(nibName: "CarTableViewCell", bundle: nil)
    }
    
    func configure(with model: Car){
        self.carTitleLabel.text = model.Title
        self.carYearLabel.text = model.Year
        let url = model.Poster
        let data = try! Data(contentsOf: URL(string: url)!)
        self.carPosterImageView.image = UIImage(data: data)
    }
}
