import ctypes
from ctypes import wintypes
import time
import os
import mss
from PIL import Image

user32 = ctypes.windll.user32

class RECT(ctypes.Structure):
    _fields_ = [("left", ctypes.c_long),
                ("top", ctypes.c_long),
                ("right", ctypes.c_long),
                ("bottom", ctypes.c_long)]

def get_game_hwnd():
    hdesk = user32.OpenInputDesktop(0, False, 0x01FF)
    if hdesk:
        user32.SetThreadDesktop(hdesk)
        
    target = []
    def enum_cb(hwnd, lparam):
        length = user32.GetWindowTextLengthW(hwnd)
        if length > 0:
            buff = ctypes.create_unicode_buffer(length + 1)
            user32.GetWindowTextW(hwnd, buff, length + 1)
            if "Naruto 568Play" in buff.value:
                target.append(hwnd)
                return False
        return True
    
    WNDENUMPROC = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
    user32.EnumWindows(WNDENUMPROC(enum_cb), 0)
    return target[0] if target else None

def capture(name="screen"):
    hwnd = get_game_hwnd()
    if not hwnd:
        print("Window not found")
        return None
    
    user32.ShowWindow(hwnd, 9) # SW_RESTORE
    user32.SetForegroundWindow(hwnd)
    time.sleep(0.3)
    
    rect = RECT()
    user32.GetWindowRect(hwnd, ctypes.byref(rect))
    w = rect.right - rect.left
    h = rect.bottom - rect.top
    
    with mss.mss() as sct:
        monitor = {"left": rect.left, "top": rect.top, "width": w, "height": h}
        sct_img = sct.grab(monitor)
        img = Image.frombytes("RGB", sct_img.size, sct_img.bgra, "raw", "BGRX")
        os.makedirs(r"d:\naruto Online\Client\tools\official_references\live_captures", exist_ok=True)
        out_path = os.path.join(r"d:\naruto Online\Client\tools\official_references\live_captures", f"{name}.png")
        img.save(out_path)
        print(f"Captured: {out_path} ({w}x{h})")
        return out_path

def click_relative(rel_x, rel_y):
    hwnd = get_game_hwnd()
    if not hwnd:
        return
    rect = RECT()
    user32.GetWindowRect(hwnd, ctypes.byref(rect))
    abs_x = rect.left + rel_x
    abs_y = rect.top + rel_y
    
    user32.SetForegroundWindow(hwnd)
    time.sleep(0.1)
    user32.SetCursorPos(abs_x, abs_y)
    time.sleep(0.05)
    user32.mouse_event(2, 0, 0, 0, 0) # MOUSEEVENTF_LEFTDOWN
    time.sleep(0.05)
    user32.mouse_event(4, 0, 0, 0, 0) # MOUSEEVENTF_LEFTUP
    print(f"Clicked at window relative ({rel_x}, {rel_y}) -> screen ({abs_x}, {abs_y})")

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == "capture":
        name = sys.argv[2] if len(sys.argv) > 2 else "snapshot"
        capture(name)
    elif len(sys.argv) > 3 and sys.argv[1] == "click":
        click_relative(int(sys.argv[2]), int(sys.argv[3]))
        time.sleep(0.5)
        name = sys.argv[4] if len(sys.argv) > 4 else "after_click"
        capture(name)
    else:
        capture("current")
