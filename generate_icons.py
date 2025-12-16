import os
import json
import shutil
import argparse

def create_imageset(svg_file, output_directory, is_template):
    base_name = os.path.splitext(svg_file)[0].split('/')[-1]
    
    imageset_folder = os.path.join(output_directory, f"{base_name}.imageset")
    
    os.makedirs(imageset_folder, exist_ok=True)
    
    shutil.copy(svg_file, os.path.join(imageset_folder, os.path.basename(svg_file)))
    
    contents = {
        "images": [
            {
                "filename": os.path.basename(svg_file),
                "idiom": "universal"
            }
        ],
        "info": {
            "author": "xcode",
            "version": 1
        },
        "properties": {
            "preserves-vector-representation": True,
        }
    }
    
    if is_template:
        contents["properties"]["template-rendering-intent"] = "template"
    
    with open(os.path.join(imageset_folder, "Contents.json"), 'w') as json_file:
        json.dump(contents, json_file, indent=4)

def generate_icons(svg_directory):
    print("Generating icons...")
    output_directory = 'SBBDesignSystemMobileSwiftUI/Resources/Assets.xcassets/Images/SBB Icons/'
    if os.path.exists(output_directory):
        shutil.rmtree(output_directory)
    icons = [i for i in os.listdir(svg_directory) if i.endswith('.svg')]
    for i, filename in enumerate(icons):
        print(f"\tIcon {i}/{len(icons)}", end='\r')
        full_svg_path = os.path.join(svg_directory, filename)
        create_imageset(full_svg_path, output_directory, True)
    print(f"\t{len(icons)} icons generated.")
    index_path = os.path.join(svg_directory, "index.json")
    shutil.copy(index_path, 'SBBDesignSystemMobileSwiftUI/Resources/SBBIconsIndex.json')
    print(f"\tIcons index updated.")

def generate_pictos(svg_directory):
    print("Generating pictograms...")
    output_directory = 'SBBDesignSystemMobileSwiftUI/Resources/Assets.xcassets/Images/SBB Pictos/'
    if os.path.exists(output_directory):
        shutil.rmtree(output_directory)
    pictograms = [p for p in os.listdir(svg_directory) if p.endswith('.svg')]
    for i, filename in enumerate(pictograms):
        print(f"\tPicto {i}/{len(pictograms)}", end='\r')
        full_svg_path = os.path.join(svg_directory, filename)
        create_imageset(full_svg_path, output_directory, False)
    print(f"\t{len(pictograms)} pictograms generated.")
            

def main(icons_directory, pictos_directory):
    generate_icons(icons_directory)
    generate_pictos(pictos_directory)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process SVG files to create imagesets.')
    parser.add_argument('--icons-repo', type=str, help='Path to the repo sbb-icons')
    parser.add_argument('--pictos-repo', type=str, help='Path to the repo picto-library')
    args = parser.parse_args()
    main(os.path.join(args.icons_repo, 'icons'), os.path.join(args.pictos_repo, 'pictos', 'svg-digital'))
