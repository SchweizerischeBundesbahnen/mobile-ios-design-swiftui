//
//  ME01TypographyViewController.swift
//  MobileDesignSystem
//
//  Created by Terence on 13.07.18.
//  Copyright © 2018 SBB. All rights reserved.
//

import UIKit
import SBBMobileDesignSystemSwiftUI

class ME01TypographyViewController: UIViewController {
    
    @IBOutlet weak var headlineBlackLabel: UILabel!
    @IBOutlet weak var headerWhiteLabel: UILabel!
    @IBOutlet weak var headlineWhiteLabel: UILabel!
    @IBOutlet weak var copyBlackLabel: UILabel!
    @IBOutlet weak var copyWhiteLabel: UILabel!
    @IBOutlet weak var titleBlackLabel: UILabel!
    @IBOutlet weak var bodyMetalLabel: UILabel!
    @IBOutlet weak var bodyBlackLabel: UILabel!
    @IBOutlet weak var bodyRedLabel: UILabel!
    @IBOutlet weak var legendNormalBlackLabel: UILabel!
    @IBOutlet weak var legendNormalMetalLabel: UILabel!
    @IBOutlet weak var legendNormalRedLabel: UILabel!
    @IBOutlet weak var legendNormalWhiteLabel: UILabel!
    @IBOutlet weak var legendSmallLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Typography"
         
        bodyBlackLabel.text = """
        SBB Body black
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        bodyMetalLabel.text = """
        SBB Body metal
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        bodyRedLabel.text = """
        SBB Body red
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat. thisl
        """
        
        legendNormalBlackLabel.text = """
        SBB Legend Normal black
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalMetalLabel.text = """
        SBB Legend Normal metal
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalRedLabel.text = """
        SBB Legend Normal red
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalWhiteLabel.text = """
        SBB Legend Normal white
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendSmallLabel.text = """
        SBB Legend Small
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
    }
}
