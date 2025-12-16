#!/bin/sh
git clone https://github.com/sbb-design-systems/sbb-icons/
git clone https://github.com/sbb-design-systems/picto-library/
python generate_icons.py --icons-repo sbb-icons --pictos-repo picto-library
sudo rm -r sbb-icons
sudo rm -r picto-library
