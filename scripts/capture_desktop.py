import ctypes
import mss
from PIL import Image

user32 = ctypes.windll.user32
hdesk = user32.OpenInputDesktop(0, False, 0x01FF)
if hdesk:
    user32.SetThreadDesktop(hdesk)

output_path = r"d:\naruto Online\Client\tools\official_references\LIVE_DESKTOP_CAPTURE.png"

with mss.mss() as sct:
    # Capture the primary monitor
    monitor = sct.monitors[1]
    sct_img = sct.grab(monitor)
    img = Image.frombytes("RGB", sct_img.size, sct_img.bgra, "raw", "BGRX")
    img.save(output_path)
    print(f"Captured screen: {sct_img.size} saved to {output_path}")
