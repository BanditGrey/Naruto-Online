import sys
sys.path.append(r"d:\naruto Online")
import time
import pyautogui
from PIL import Image
from scripts.automate_captures import get_window, capture_region

# Load 01_FORMATION_MENU_CAPTURED.png to find red close button (X)
img = Image.open(r"d:\naruto Online\Client\tools\official_references\live_captures\01_FORMATION_MENU_CAPTURED.png")
# The modal is in the upper half. Close button is top right of the brown frame.
# Looking at the image, the brown frame right edge is around x: 1440, y: 100.
# Let's crop around x: 1380 to 1460, y: 80 to 130
crop_x = img.crop((1380, 80, 1460, 130))
crop_x.save(r"d:\naruto Online\Client\tools\official_references\live_captures\test_close_x.png")

# Also let's find Tran Hinh button on the bottom bar:
# It's at x: 1170, y: 790
print("Saved test_close_x.png")
