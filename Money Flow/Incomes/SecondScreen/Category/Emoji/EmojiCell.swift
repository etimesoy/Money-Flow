//
//  EmojiCell.swift
//  Money Flow
//
//  Created by Руслан on 06.07.2021.
//

import UIKit

class EmojiCell: UICollectionViewCell {

    @IBOutlet weak var emojiLabel: UILabel!
    
    weak var delegate: PopupScreenViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(_ emoji: String) {
        emojiLabel.text = emoji
    }

    @IBAction func cellButtonAction(_ sender: Any) {
        delegate?.updateChoiceWith(emojiLabel.text ?? "")
        delegate?.dismiss(animated: true)
    }
}
