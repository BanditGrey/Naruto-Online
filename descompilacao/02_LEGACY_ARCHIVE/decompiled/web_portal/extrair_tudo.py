import os
import glob
import zlib
import lzma
import subprocess
from concurrent.futures import ThreadPoolExecutor

# Ajuste o caminho do ffdec.jar se necessário
FFDEC_PATH = r"C:\Program Files (x86)\FFDec\ffdec.jar"
if not os.path.exists(FFDEC_PATH):
    FFDEC_PATH = r"C:\Program Files\FFDec\ffdec.jar"

OUTPUT_DIR = "Extracao_Total"
SCRIPTS_DIR = os.path.join(OUTPUT_DIR, "Scripts_AS")
IMAGES_DIR = os.path.join(OUTPUT_DIR, "Imagens_SWF")
TEXTURES_DIR = os.path.join(OUTPUT_DIR, "Texturas_TexClient")

os.makedirs(SCRIPTS_DIR, exist_ok=True)
os.makedirs(IMAGES_DIR, exist_ok=True)
os.makedirs(TEXTURES_DIR, exist_ok=True)

def exportar_swf(swf_file):
    """Executa o FFDec via CLI para extrair scripts e imagens de um SWF"""
    nome_base = os.path.splitext(os.path.basename(swf_file))[0]
    out_script = os.path.join(SCRIPTS_DIR, nome_base)
    out_image = os.path.join(IMAGES_DIR, nome_base)
    
    print(f"[SWF] Processando: {os.path.basename(swf_file)}")
    cmd = [
        "java", "-Xmx1024m", "-jar", FFDEC_PATH,
        "-export", "script,image",
        out_script, swf_file
    ]
    try:
        subprocess.run(cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, check=True)
    except Exception as e:
        print(f"[ERRO SWF] Falha em {swf_file}: {e}")

def descompactar_textura(raw_file):
    """Tenta descompactar arquivos binários e .TexClient usando ZLIB/LZMA"""
    nome = os.path.basename(raw_file)
    with open(raw_file, "rb") as f:
        data = f.read()

    # Tentativa ZLIB
    try:
        decompressed = zlib.decompress(data)
        ext = ".png" if decompressed.startswith(b"\x89PNG") else ".bin"
        out_path = os.path.join(TEXTURES_DIR, f"{nome}{ext}")
        with open(out_path, "wb") as out:
            out.write(decompressed)
        print(f"[TEXTURA] Descompactado (ZLIB): {nome} -> {ext}")
        return
    except Exception:
        pass

    # Tentativa LZMA
    try:
        decompressed = lzma.decompress(data)
        ext = ".png" if decompressed.startswith(b"\x89PNG") else ".bin"
        out_path = os.path.join(TEXTURES_DIR, f"{nome}{ext}")
        with open(out_path, "wb") as out:
            out.write(decompressed)
        print(f"[TEXTURA] Descompactado (LZMA): {nome} -> {ext}")
        return
    except Exception:
        pass

    # Se já for PNG puro sem compressão
    if data.startswith(b"\x89PNG"):
        out_path = os.path.join(TEXTURES_DIR, f"{nome}.png")
        with open(out_path, "wb") as out:
            out.write(data)
        print(f"[TEXTURA] PNG direto: {nome}")

def main():
    swfs = glob.glob("*.swf")
    tex_clients = glob.glob("*.TexClient") + glob.glob("*.bin")

    print(f"Encontrados: {len(swfs)} SWFs e {len(tex_clients)} arquivos de textura/binário.\n")

    # 1. Processa os arquivos .TexClient e .bin nativamente em paralelo
    print("--- Extraindo Texturas e Binários ---")
    with ThreadPoolExecutor(max_workers=8) as executor:
        executor.map(descompactar_textura, tex_clients)

    # 2. Processa os SWFs via FFDec CLI
    if os.path.exists(FFDEC_PATH):
        print("\n--- Extraindo Scripts e Imagens dos SWFs ---")
        with ThreadPoolExecutor(max_workers=4) as executor:
            executor.map(exportar_swf, swfs)
    else:
        print(f"\n[AVISO] FFDec não encontrado no caminho padrão: {FFDEC_PATH}")
        print("Configure o caminho correto da variável FFDEC_PATH para extrair os SWFs.")

    print("\nExtração finalizada! Verifique a pasta 'Extracao_Total'.")

if __name__ == "__main__":
    main()