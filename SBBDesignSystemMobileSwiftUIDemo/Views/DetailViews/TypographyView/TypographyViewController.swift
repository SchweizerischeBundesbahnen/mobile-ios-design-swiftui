//
//  Copyright © 2018 SBB. All rights reserved.
//

import UIKit
import SBBDesignSystemMobileSwiftUI

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
        
        headerWhiteLabel.font = .xlarge_light
        headerWhiteLabel.textColor = .sbbColor(.textWhite)
        headerWhiteLabel.text = "xlarge light"
        
        headlineBlackLabel.font = .large_bold
        headlineBlackLabel.textColor = .sbbColor(.textBlack)
        headlineBlackLabel.text = "large bold"
        
        headlineWhiteLabel.font = .large_bold
        headlineWhiteLabel.textColor = .sbbColor(.textWhite)
        headlineWhiteLabel.text = "large bold"
        
        titleBlackLabel.font = .medium_bold
        titleBlackLabel.textColor = .sbbColor(.textBlack)
        titleBlackLabel.text = "medium bold"
        
        titleMetalLabel.font = .medium_bold
        titleMetalLabel.textColor = .sbbColor(.textMetal)
        titleMetalLabel.text = "medium bold"
        
        titleModulLabel.font = .large_light
        titleModulLabel.textColor = .sbbColor(.textBlack)
        titleModulLabel.text = "large light"
        
        subtitleBlackLabel.font = .small_bold
        subtitleBlackLabel.textColor = .sbbColor(.textBlack)
        subtitleBlackLabel.text = "small bold"
        
        subtitleMetalLabel.font = .small_bold
        subtitleMetalLabel.textColor = .sbbColor(.textMetal)
        subtitleMetalLabel.text = "small bold"
        
        copyBlackLabel.font = .large_light
        copyBlackLabel.textColor = .sbbColor(.textBlack)
        copyBlackLabel.text = "large light"
        
        copyWhiteLabel.font = .large_light
        copyWhiteLabel.textColor = .white
        
        bodyBlackLabel.font = .medium_light
        bodyBlackLabel.textColor = .sbbColor(.textBlack)
        bodyBlackLabel.text = """
        SBB medium light black
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        bodyMetalLabel.font = .medium_light
        bodyMetalLabel.textColor = .sbbColor(.textMetal)
        bodyMetalLabel.text = """
        SBB medium light metal
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        bodyRedLabel.font = .medium_light
        bodyRedLabel.textColor = .sbbColor(.textRed)
        bodyRedLabel.text = """
        SBB medium light red
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat. thisl
        """
        
        legendNormalBlackLabel.font = .small_light
        legendNormalBlackLabel.textColor = .sbbColor(.textBlack)
        legendNormalBlackLabel.text = """
        SBB small light black
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalMetalLabel.font = .small_light
        legendNormalMetalLabel.textColor = .sbbColor(.textMetal)
        legendNormalMetalLabel.text = """
        SBB small light metal
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalRedLabel.font = .small_light
        legendNormalRedLabel.textColor = .sbbColor(.textRed)
        legendNormalRedLabel.text = """
        SBB small light red
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendNormalWhiteLabel.font = .small_light
        legendNormalWhiteLabel.textColor = .sbbColor(.textWhite)
        legendNormalWhiteLabel.text = """
        SBB small light white
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
        
        legendSmallLabel.font = .xsmall_light
        legendSmallLabel.textColor = .sbbColor(.textBlack)
        legendSmallLabel.text = """
        SBB xsmall light
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis congue placerat massa condimentum pharetra. Cras iaculis neque ut urna auctor dignissim id quis sapien. Sed ullamcorper ornare cursus. Quisque venenatis iaculis quam posuere pharetra. Pellentesque feugiat viverra augue nec feugiat.
        """
    }
}
