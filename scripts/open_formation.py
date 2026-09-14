import sys
sys.path.append(r"d:\naruto Online")
import time
import pyautogui
from scripts.automate_captures import get_window, capture_region

hwnd, rect = get_window()

# Step 1: Close the modal by clicking X at (1415, 110)
pyautogui.click(1415, 110)
print("Clicked Close (X) at (1415, 110)")
time.sleep(1.0)

# Step 2: Click Trận Hình (Formation) button at (1180, 790)
pyautogui.click(1180, 790)
print("Clicked Tran Hinh at (1180, 790)")
time.sleep(1.5)

# Step 3: Capture the formation screen!
capture_region(rect, "02_FORMATION_OFFICIAL_OPEN")
