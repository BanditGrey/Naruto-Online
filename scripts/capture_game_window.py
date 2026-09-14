import ctypes
from ctypes import wintypes
import mss
from PIL import Image

user32 = ctypes.windll.user32
hdesk = user32.OpenInputDesktop(0, False, 0x01FF)
if hdesk:
    user32.SetThreadDesktop(hdesk)

# Find window with title containing "Naruto"
class RECT(ctypes.Structure):
    _fields_ = [("left", ctypes.c_long),
                ("top", ctypes.c_long),
                ("right", ctypes.c_long),
                ("bottom", ctypes.c_long)]

target_hwnd = None

def enum_cb(hwnd, lparam):
    global target_hwnd
    length = user32.GetWindowTextLengthW(hwnd)
    if length > 0:
        buff = ctypes.create_unicode_buffer(length + 1)
        user32.GetWindowTextW(hwnd, buff, length + 1)
        if "Naruto 568Play" in buff.value:
            target_hwnd = hwnd
            return False
    return True

WNDENUMPROC = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
user32.EnumWindows(WNDENUMPROC(enum_cb), 0)

print(f"Target window HWND: {target_hwnd}")

if target_hwnd:
    rect = RECT()
    user32.GetWindowRect(target_hwnd, ctypes.byref(rect))
    print(f"Window bounds: Left={rect.left}, Top={rect.top}, Right={rect.right}, Bottom={rect.bottom}, Width={rect.right - rect.left}, Height={rect.bottom - rect.top}")
    
    with mss.mss() as sct:
        monitor = {
            "left": rect.left,
            "top": rect.top,
            "width": rect.right - rect.left,
            "height": rect.bottom - rect.top
        }
        sct_img = sct.grab(monitor)
        img = Image.frombytes("RGB", sct_img.size, sct_img.bgra, "raw", "BGRX")
        out_path = r"d:\naruto Online\Client\tools\official_references\LIVE_GAME_WINDOW_CURRENT.png"
        img.save(out_path)
        print(f"Saved game window crop to: {out_path}")
else:
    print("Window not found via EnumWindows")
