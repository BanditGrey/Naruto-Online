from PIL import Image

# Let's inspect 00_CURRENT_SCREEN.png to find the exact positions of all bottom buttons
img = Image.open(r"d:\naruto Online\Client\tools\official_references\live_captures\00_CURRENT_SCREEN.png")

# The buttons are:
# 1. Nhan Doi
# 2. Ao Nghia
# 3. Tran Hinh
# 4. Tui Do
# 5. Thu
# 6. To Chuc

# Let's crop each button individually and save them so we have 100% extracted canonical button icons!
buttons = [
    ("btn_nhan_doi", 1060, 755, 1130, 840),
    ("btn_ao_nghia", 1150, 755, 1220, 840),
    ("btn_tran_hinh", 1245, 755, 1315, 840),
    ("btn_tui_do", 1340, 755, 1410, 840),
    ("btn_thu", 1435, 755, 1505, 840),
    ("btn_to_chuc", 1530, 755, 1600, 840),
]

for name, x1, y1, x2, y2 in buttons:
    b_img = img.crop((x1, y1, x2, y2))
    b_path = rf"d:\naruto Online\Client\public\assets\ui\hud\{name}.png"
    b_img.save(b_path)
    print(f"Extracted {name} from ({x1},{y1}) to ({x2},{y2}) -> center at ({ (x1+x2)//2 }, { (y1+y2)//2 })")
