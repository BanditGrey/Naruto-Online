import os
import re

cache_dir = r"C:\Users\Daniel\AppData\Roaming\vn.568play.naruto\Partitions\naruto\Cache"
dest_dir = r"d:\naruto Online\descompilacao\04_LIVE_CACHE_EXTRACTED"
os.makedirs(dest_dir, exist_ok=True)

mapped = []

for root, dirs, files in os.walk(cache_dir):
    for f in files:
        if f.startswith("f_"):
            fp = os.path.join(root, f)
            try:
                with open(fp, "rb") as h:
                    content = h.read()
                    # Check URL anywhere in file (usually near end)
                    urls = re.findall(b"https?://[a-zA-Z0-9\\.\\-_/]+\\.[a-zA-Z0-9_]+", content)
                    if urls:
                        first_url = urls[-1].decode("latin1", errors="ignore")
                        mapped.append((f, first_url, len(content)))
            except Exception as e:
                pass

print(f"Total mapped cache files with URLs: {len(mapped)}")
for f, url, sz in sorted(mapped, key=lambda x: x[1]):
    print(f"{f} ({sz} bytes) -> {url}")
