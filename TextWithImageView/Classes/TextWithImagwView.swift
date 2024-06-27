
import UIKit
import Kingfisher
import SnapKit

public class TextWithImagwView : UIView {
    
    public enum Alignment {
        case left
        case right
    }
    
    private let imageView = AnimatedImageView()
    public let textView = UITextView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     텍스트에 이미지를 넣어서 표현하는 뷰
     - Parameters:
        - imageURL: 텍스트에 넣을 이미지 뷰
        - text: 텍스트
        - align: 정렬 방향
        - maxScale: 이미지 최대 비율 (1보다 클 수 없으며, 1보다 크면 1로 처리)
     */
    public convenience init(imageURL : String, text : [String], align : Alignment, maxScale : CGFloat) {
        self.init()
       
        self.addSubview(textView)
        textView.isScrollEnabled = false
        textView.isEditable = false
        
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        text.forEach { str in
            textView.text += str + "\n\n"
        }
        
        if let imageURL = URL(string: imageURL) {
            imageView.kf.setImage(with: imageURL) { [weak self] res in
                let resImage = try? res.get()
                
                guard var size = resImage?.image.size else { return }
                guard let viewFrame = self?.frame else { return }
                
                guard let image = resImage?.image else { return }
              
                if size.width > viewFrame.width * (maxScale > 1 ? 1 : maxScale) {
                    self?.imageView.image = self?.resizeImage(image: image, newWidth: viewFrame.width * (maxScale > 1 ? 1 : maxScale))
                    size = self?.imageView.image?.size ?? .zero
                   
                }
                
                guard let imageView = self?.imageView else { return }
                self?.textView.addSubview(imageView)
                
                
                if align == .left {
                    let exclusionPath = UIBezierPath(rect: CGRect.init(x: 0, y: 0, width: size.width , height: size.height))
                    self?.textView.textContainer.exclusionPaths = [exclusionPath]
                    
                    imageView.snp.makeConstraints { make in
                        make.leading.equalToSuperview()
                        make.top.equalToSuperview()
                        make.height.equalTo(size.height)
                        make.width.equalTo(size.width)
                    }
                    
                }
                else {
                    let exclusionPath = UIBezierPath(rect: CGRect.init(x: viewFrame.width - size.width, y: 0, width: size.width , height: size.height))
                    self?.textView.textContainer.exclusionPaths = [exclusionPath]
                    
                    imageView.snp.makeConstraints { make in
                        make.trailing.equalToSuperview()
                        make.leading.equalTo(viewFrame.width - size.width)
                        make.top.equalToSuperview()
                        make.height.equalTo(size.height)
                        make.width.equalTo(size.width)
                    }
                }
               
            }
                
        }
 
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
}
