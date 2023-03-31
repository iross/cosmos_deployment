import os
import sys
import glob
from PIL import Image


if len(sys.argv)>=2:
    BASE_DIR = sys.argv[1]
else:
    BASE_DIR="/hdd/iaross/cosmos_6Aug_reload_output/"

print(os.path.join(BASE_DIR, "images", "*.png"))
files = glob.glob(os.path.join(BASE_DIR, "images", "*.png"))
for path in files:
    if os.path.exists(path.replace("png","jpg")): continue
    im = Image.open(path)
    im.save(path.replace("png","jpg"), quality=40, optimize=True)
    im.thumbnail((200,200))
    im.save(path.replace(".png","_thumb.jpg"), quality=40, optimize=True)

