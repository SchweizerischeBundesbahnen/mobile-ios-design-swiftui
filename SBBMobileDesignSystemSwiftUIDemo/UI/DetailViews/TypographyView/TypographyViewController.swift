//
//  ME01TypographyViewController.swift
//  MobileDesignSystem
//
//  Created by Terence on 13.07.18.
//  Copyright © 2018 SBB. All rights reserved.
//

import UIKit
import SBBMobileDesignSystemSwiftUI

class TypographyViewController: UIViewController {
    

    @IBOutlet weak var headerWhiteLabel: UILabel!
    @IBOutlet weak var headlineBlackLabel: UILabel!
    @IBOutlet weak var headlineWhiteLabel: UILabel!
    @IBOutlet weak var titleBlackLabel: UILabel!
    @IBOutlet weak var titleMetalLabel: UILabel!
    @IBOutlet weak var titleModulLabel: UILabel!
    @IBOutlet weak var subtitleBlackLabel: UILabel!
    @IBOutlet weak var subtitleMetalLabel: UILabel!
    @IBOutlet weak var copyBlackLabel: UILabel!
    @IBOutlet weak var copyWhiteLabel: UILabel!
    @IBOutlet weak var bodyBlackLabel: UILabel!
    @IBOutlet weak var bodyMetalLabel: UILabel!
    @IBOutlet weak var bodyRedLabel: UILabel!
    @IBOutlet weak var legendNormalBlackLabel: UILabel!
    @IBOutlet weak var legendNormalMetalLabel: UILabel!
    @IBOutlet weak var legendNormalRedLabel: UILabel!
    @IBOutlet weak var legendNormalWhiteLabel: UILabel!
    @IBOutlet weak var legendSmallLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Typography"
        
        headerWhiteLabel.font = .sbbHeader
        headerWhiteLabel.textColor = SBBColor.color(withSBBColor: .textWhite)
        
        headlineBlackLabel.font = .sbbHeadline
        
        headlineWhiteLabel.font = .sbbHeadline
        headlineWhiteLabel.textColor = SBBColor.color(withSBBColor: .textWhite)
        
        titleBlackLabel.font = .sbbTitleDefault
        titleMetalLabel.font = .sbbTitleDefault
        titleMetalLabel.textColor = SBBColor.color(withSBBColor: .textMetal)
        
        titleModulLabel.font = .sbbTitleModul
        
        subtitleBlackLabel.font = .sbbSubtitle
        subtitleMetalLabel.font = .sbbSubtitle
        subtitleMetalLabel.textColor = SBBColor.color(withSBBColor: .textMetal)
        
        copyBlackLabel.font = .sbbCopy
        
        copyWhiteLabel.font = .sbbCopy
        copyWhiteLabel.textColor = .white
        
        
        bodyBlackLabel.font = .sbbBody
        bodyBlackLabel.text = """
        SBB Body black
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        bodyMetalLabel.font = .sbbBody
        bodyMetalLabel.textColor = SBBColor.color(withSBBColor: .textMetal)
        bodyMetalLabel.text = """
        SBB Body metal
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        bodyRedLabel.font = .sbbBody
        bodyRedLabel.textColor = SBBColor.color(withSBBColor: .textRed)
        bodyRedLabel.text = """
        SBB Body red
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat. thisl
        """
        
        legendNormalBlackLabel.font = .sbbLegend
        legendNormalBlackLabel.text = """
        SBB Legend Normal black
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalMetalLabel.font = .sbbLegend
        legendNormalMetalLabel.textColor = SBBColor.color(withSBBColor: .textMetal)
        legendNormalMetalLabel.text = """
        SBB Legend Normal metal
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalRedLabel.font = .sbbLegend
        legendNormalRedLabel.textColor = SBBColor.color(withSBBColor: .textRed)
        legendNormalRedLabel.text = """
        SBB Legend Normal red
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalWhiteLabel.font = .sbbLegend
        legendNormalWhiteLabel.textColor = SBBColor.color(withSBBColor: .textWhite)
        legendNormalWhiteLabel.text = """
        SBB Legend Normal white
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendSmallLabel.font = .sbbLegendSmall
        legendSmallLabel.text = """
        SBB Legend Small
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
    }
}
