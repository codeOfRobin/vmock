//
//  pdfView.swift
//  vmock
//
//  Created by Robin Malhotra on 14/01/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import UIKit

class pdfView: UIView {


//     Only override drawRect: if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {

    }

    
    override func drawLayer(layer: CALayer, inContext context: CGContext)
    {
        
        CGContextSetRGBFillColor(context, 1.0,1.0,1.0,1.0);
        CGContextFillRect(context, self.bounds);
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextSetInterpolationQuality(context, CGInterpolationQuality.High);
        displayPDF(context, pageNumber: 0, filename: "soffes")

    }
    
    func getPDFDoc(filename:String)->CGPDFDocumentRef
    {
        let url = NSBundle.mainBundle().URLForResource(filename+".pdf", withExtension: nil)
        let pdf = CGPDFDocumentCreateWithURL(url)
        print(CGPDFDocumentGetNumberOfPages(pdf))
        return pdf!
    }
    
    func displayPDF(context:CGContextRef , pageNumber:Int, filename:String)
    {
        let document = getPDFDoc("soffes")
        let page  = CGPDFDocumentGetPage(document, 1)
        CGContextConcatCTM(context, CGPDFPageGetDrawingTransform(page, CGPDFBox.BleedBox, layer.bounds, 0, true))
        CGContextDrawPDFPage(context, page)
        CGContextRestoreGState(context);
        
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), true, UIScreen.mainScreen().scale);
//        self.layer.renderInContext(context)
//        let finalImage = UIGraphicsGetImageFromCurrentImageContext();
//        let finView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
//        finView.image = finalImage
//        self.addSubview(finView)
//        UIGraphicsEndImageContext();
    }


}
