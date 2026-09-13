const fs = require("fs");
const path = require("path");

function walk(dir) {
  let files = [];
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  for (const e of entries) {
    const full = path.join(dir, e.name);
    if (e.isDirectory()) files = files.concat(walk(full));
    else if (e.name.endsWith(".as")) files.push(full);
  }
  return files;
}

const f1 = walk("legacy/scripts_as3");
const f2 = walk("debug 2/scripts");

const map1 = {};
for (const p of f1) {
  const rel = path.relative("legacy/scripts_as3", p).replace(/\\/g, "/");
  map1[rel] = fs.statSync(p).size;
}

const map2 = {};
for (const p of f2) {
  const rel = path.relative("debug 2/scripts", p).replace(/\\/g, "/");
  map2[rel] = fs.statSync(p).size;
}

const diffs = [];
for (const k in map2) {
  if (map1[k] !== undefined && map1[k] !== map2[k]) {
    diffs.push({ file: k, legacySize: map1[k], debug2Size: map2[k], delta: map2[k] - map1[k] });
  }
}

console.log("Modified classes count:", diffs.length);
diffs.sort((a,b) => Math.abs(b.delta) - Math.abs(a.delta));
console.table(diffs.slice(0, 35));

const categories = {};
for (const d of diffs) {
  const cat = d.file.split("/")[0];
  categories[cat] = (categories[cat] || 0) + 1;
}
console.log("Differences by Category:", categories);
