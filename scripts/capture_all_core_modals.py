import sys
sys.path.append(r"d:\naruto Online")
import time
import pyautogui
from scripts.automate_captures import get_window, capture_region

hwnd, rect = get_window()

def click_and_capture(close_pos, open_pos, name, wait_sec=1.5):
    if close_pos:
        pyautogui.click(close_pos[0], close_pos[1])
        print(f"Closed modal at {close_pos}")
        time.sleep(1.0)
    if open_pos:
        pyautogui.click(open_pos[0], open_pos[1])
        print(f"Opened {name} at {open_pos}")
        time.sleep(wait_sec)
    capture_region(rect, name)

# 1. Close Formation and Open Bag (Túi Đồ at 1260, 790)
click_and_capture((1415, 110), (1260, 790), "03_BAG_OFFICIAL_OPEN")

# 2. Close Bag and Open Talentos (Ảo Nghĩa at 1080, 790)
click_and_capture((1415, 110), (1080, 790), "04_TALENTS_OFFICIAL_OPEN")

# 3. Close Talentos and Open Taverna (Hội Quán at 780, 130)
click_and_capture((1415, 110), (780, 130), "05_TAVERN_OFFICIAL_OPEN")

# 4. Close Taverna and Open Arena (Đấu Trường at 600, 130)
click_and_capture((1415, 110), (600, 130), "06_ARENA_OFFICIAL_OPEN")

print("All modals captured successfully!")
