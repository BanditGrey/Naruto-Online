import time
import os
import ctypes
import pyautogui
from PIL import Image
import mss

pyautogui.FAILSAFE = False

user32 = ctypes.windll.user32
hdesk = user32.OpenInputDesktop(0, False, 0x01FF)
if hdesk:
    user32.SetThreadDesktop(hdesk)

import sys
sys.path.append(r"d:\naruto Online")
from scripts.game_tools import get_game_hwnd, RECT

def get_window():
    hwnd = get_game_hwnd()
    if not hwnd:
        print("Game window not found!")
        return None, None
    user32.ShowWindow(hwnd, 9)
    user32.SetForegroundWindow(hwnd)
    time.sleep(0.5)
    
    rect = RECT()
    user32.GetWindowRect(hwnd, ctypes.byref(rect))
    return hwnd, rect

def capture_region(rect, name):
    out_dir = r"d:\naruto Online\Client\tools\official_references\live_captures"
    os.makedirs(out_dir, exist_ok=True)
    out_path = os.path.join(out_dir, f"{name}.png")
    
    with mss.mss() as sct:
        monitor = {
            "left": rect.left,
            "top": rect.top,
            "width": rect.right - rect.left,
            "height": rect.bottom - rect.top
        }
        sct_img = sct.grab(monitor)
        img = Image.frombytes("RGB", sct_img.size, sct_img.bgra, "raw", "BGRX")
        img.save(out_path)
        print(f"[CAPTURED] {out_path} ({img.width}x{img.height})")
        return out_path

hwnd, rect = get_window()
if hwnd:
    print(f"Game Rect: left={rect.left}, top={rect.top}, w={rect.right-rect.left}, h={rect.bottom-rect.top}")
    # Let's take snapshot of current screen
    capture_region(rect, "00_CURRENT_SCREEN")
