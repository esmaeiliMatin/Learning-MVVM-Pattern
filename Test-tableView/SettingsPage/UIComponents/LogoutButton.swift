import UIKit

class LogoutButton: UIButton {
    
    init(title: String, iconName: String) {
        super.init(frame: .zero)
        
        var config = UIButton.Configuration.tinted()
        config.baseBackgroundColor = .white
        config.title = title
        config.image = UIImage(systemName: "door.right.hand.open")
        config.imagePadding = 8
        
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
        tintColor = .systemRed
        layer.cornerRadius = 22
        layer.borderWidth = 1.0
        layer.borderColor = CGColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        backgroundColor = .white
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
