import UIKit

class PurchasesStatusIcon: UIView {
    
    // MARK: - properties
    lazy var name: String = ""
    lazy var uiImageView = UIImageView()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        uiImageView.backgroundColor = .clear
        
        addSubview(uiImageView)
        uiImageView.setCenterAnchorToCenterOfSuperview(axis: .horizontal)
        uiImageView.setCenterAnchorToCenterOfSuperview(axis: .vertical)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(ovalIn: self.bounds.insetBy(dx: 1, dy: 1))
        let strokeColor = #colorLiteral(red: 0.8894182444, green: 0.8894182444, blue: 0.8894182444, alpha: 1)
        strokeColor.setStroke()
        circlePath.lineWidth = 1.0
        circlePath.stroke()
    }
    
    func setImage(imageName: String) {
        let image = UIImage(systemName: imageName)
        uiImageView.image = image ?? UIImage()
    }
}
