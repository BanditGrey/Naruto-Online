import sys
sys.path.append(r"d:\naruto Online")
import time
import pyautogui
from scripts.automate_captures import get_window, capture_region

hwnd, rect = get_window()

def close_active_modal():
    # Press ESC to close modal cleanly
    pyautogui.press('esc')
    time.sleep(1.5)

def open_and_wait_capture(click_x, click_y, name, wait_sec=6.0):
    print(f"\n>>> Opening {name} at ({click_x}, {click_y})...")
    pyautogui.click(click_x, click_y)
    print(f"Waiting {wait_sec}s for assets to load completely...")
    time.sleep(wait_sec)
    
    # Capture the loaded window!
    path = capture_region(rect, name)
    print(f"Successfully captured {name} -> {path}")
    
    # Close modal
    close_active_modal()

# First, close whatever is open right now (Shop Ryo)
close_active_modal()

# Let's verify clean village screen
capture_region(rect, "20_CLEAN_VILLAGE")

# 1. Open Túi Đồ (Mochila / Backpack)
# Button is at (1375, 797)
open_and_wait_capture(1375, 797, "21_OFFICIAL_MOCHILA_BAG", wait_sec=6.0)

# 2. Open Ảo Nghĩa (Talentos / Esotéricas)
# Button is at (1185, 797)
open_and_wait_capture(1185, 797, "22_OFFICIAL_TALENTOS_SKILLS", wait_sec=6.0)

# 3. Open Hội Quán (Taverna de Recrutamento)
# Top bar button is at (930, 100)
open_and_wait_capture(930, 100, "23_OFFICIAL_TAVERNA_RECRUIT", wait_sec=6.0)

# 4. Open Đấu Trường (Arena)
# Top bar button is at (760, 100)
open_and_wait_capture(760, 100, "24_OFFICIAL_ARENA_PVP", wait_sec=6.0)

# 5. Open Con Đường Hokage (Caminho Hokage / Fases PvE)
# Top bar button is at (1120, 100)
open_and_wait_capture(1120, 100, "25_OFFICIAL_HOKAGE_ROAD_PVE", wait_sec=6.0)

print("\n>>> ALL OFFICIAL SCREENS CAPTURED WITH FULL LOADING TIME!")
