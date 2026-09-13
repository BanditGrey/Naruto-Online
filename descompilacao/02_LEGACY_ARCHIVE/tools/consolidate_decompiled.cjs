const fs = require("fs");
const path = require("path");

const targetBase = "D:/naruto Online/decompiled";

const dirs = [
  path.join(targetBase, "scripts_as3_legacy"),
  path.join(targetBase, "scripts_as3_latest"),
  path.join(targetBase, "swfs"),
  path.join(targetBase, "texclient"),
  path.join(targetBase, "bin_database"),
  path.join(targetBase, "audio"),
  path.join(targetBase, "web_portal"),
  path.join(targetBase, "network_captures"),
  path.join(targetBase, "extracted_swf_assets"),
  path.join(targetBase, "jpexs_export")
];

for (const d of dirs) {
  if (!fs.existsSync(d)) {
    fs.mkdirSync(d, { recursive: true });
  }
}

console.log("Directories created successfully in", targetBase);

function copyDirRecursive(src, dest) {
  if (!fs.existsSync(src)) return 0;
  if (!fs.existsSync(dest)) fs.mkdirSync(dest, { recursive: true });
  let count = 0;
  const entries = fs.readdirSync(src, { withFileTypes: true });
  for (const entry of entries) {
    const srcPath = path.join(src, entry.name);
    const destPath = path.join(dest, entry.name);
    if (entry.isDirectory()) {
      count += copyDirRecursive(srcPath, destPath);
    } else {
      if (!fs.existsSync(destPath) || fs.statSync(destPath).size !== fs.statSync(srcPath).size) {
        fs.copyFileSync(srcPath, destPath);
      }
      count++;
    }
  }
  return count;
}

const desktopSrc = "C:/Users/Daniel/Desktop/naruto online import";

console.log("1. Copying files from Desktop import...");
const desktopEntries = fs.readdirSync(desktopSrc, { withFileTypes: true });
let swfCount = 0;
let texCount = 0;
let binCount = 0;
let audioCount = 0;
let webCount = 0;

for (const entry of desktopEntries) {
  if (entry.isDirectory()) continue;
  const lower = entry.name.toLowerCase();
  const srcP = path.join(desktopSrc, entry.name);

  if (lower.endsWith(".swf")) {
    fs.copyFileSync(srcP, path.join(targetBase, "swfs", entry.name));
    swfCount++;
  } else if (lower.endsWith(".texclient")) {
    fs.copyFileSync(srcP, path.join(targetBase, "texclient", entry.name));
    texCount++;
  } else if (lower.includes(".bin")) {
    fs.copyFileSync(srcP, path.join(targetBase, "bin_database", entry.name));
    binCount++;
  } else if (lower.endsWith(".mp3") || lower.endsWith(".wav") || lower.endsWith(".ogg")) {
    fs.copyFileSync(srcP, path.join(targetBase, "audio", entry.name));
    audioCount++;
  } else {
    fs.copyFileSync(srcP, path.join(targetBase, "web_portal", entry.name));
    webCount++;
  }
}
console.log(`Copied from Desktop: ${swfCount} SWFs, ${texCount} texclients, ${binCount} bins, ${audioCount} audio, ${webCount} web assets.`);

console.log("2. Copying Wireshark capture and helper scripts...");
const sharkSrc = path.join(desktopSrc, "shark");
const sharkCount = copyDirRecursive(sharkSrc, path.join(targetBase, "network_captures"));
console.log(`Copied ${sharkCount} files to network_captures.`);

console.log("3. Copying JPEXS export...");
const exportSrc = path.join(desktopSrc, "export");
const exportCount = copyDirRecursive(exportSrc, path.join(targetBase, "jpexs_export"));
console.log(`Copied ${exportCount} files to jpexs_export.`);

console.log("4. Copying AS3 legacy scripts...");
const legacyCount = copyDirRecursive("legacy/scripts_as3", path.join(targetBase, "scripts_as3_legacy"));
console.log(`Copied ${legacyCount} legacy AS3 scripts.`);

console.log("5. Copying AS3 debug 2 (latest) scripts...");
const latestCount = copyDirRecursive("debug 2/scripts", path.join(targetBase, "scripts_as3_latest"));
console.log(`Copied ${latestCount} latest AS3 scripts.`);

console.log("6. Copying raw extracted SWF assets (Scripts_AS)...");
const rawExtractedCount = copyDirRecursive("legacy/raw_assets/Scripts_AS", path.join(targetBase, "extracted_swf_assets"));
console.log(`Copied ${rawExtractedCount} raw extracted SWF asset files.`);

console.log("All consolidation tasks completed successfully!");
