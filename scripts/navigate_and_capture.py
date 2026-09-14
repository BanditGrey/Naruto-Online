import sys
sys.path.append(r"d:\naruto Online")
import time
import pyautogui
from scripts.automate_captures import get_window, capture_region

hwnd, rect = get_window()

# 1. Close active window (click red X at 1118, 186 or press ESC)
pyautogui.click(1118, 186)
time.sleep(0.3)
pyautogui.press('esc')
time.sleep(1.0)
capture_region(rect, "10_AFTER_CLOSE_FORMATION")

# 2. Click Túi Đồ (Mochila at 1260, 790)
pyautogui.click(1260, 790)
time.sleep(1.5)
capture_region(rect, "11_BAG_INVENTORY_OFFICIAL")

# 3. Close Mochila (ESC)
pyautogui.press('esc')
time.sleep(1.0)

# 4. Click Ảo Nghĩa (Talentos at 1080, 790)
pyautogui.click(1080, 790)
time.sleep(1.5)
capture_region(rect, "12_TALENTS_OFFICIAL")

# 5. Close Talentos (ESC)
pyautogui.press('esc')
time.sleep(1.0)

# 6. Click Hội Quán (Taverna at 930, 100)
# Top bar buttons are around y: 90-120
# Let's capture village after closing
capture_region(rect, "13_VILLAGE_CLEAN")

print("Navigation sequence completed!")
