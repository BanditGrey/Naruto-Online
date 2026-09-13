const fs = require("fs");
const zlib = require("zlib");
const path = require("path");

const outDir = "D:/naruto Online/database/extracted";
if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });

// 1. Extract Censor Words
function extractCensor(binPath, outJsonPath) {
  const raw = fs.readFileSync(binPath);
  const buf = zlib.inflateSync(raw);
  const count = buf.readUInt32LE(0);
  let offset = 4;
  const list = [];
  for (let i = 0; i < count; i++) {
    const id = buf.readUInt32LE(offset); offset += 4;
    const len = buf.readUInt32LE(offset); offset += 4;
    const word = buf.toString("utf8", offset, offset + len); offset += len;
    list.push({ id, word });
  }
  fs.writeFileSync(outJsonPath, JSON.stringify(list, null, 2), "utf8");
  console.log(`Extracted ${list.length} censor words to ${outJsonPath}`);
  return list;
}

extractCensor("D:/naruto Online/decompiled/bin_database/02000000.bin", path.join(outDir, "censor_words_en.json"));
const fullCensor = extractCensor("D:/naruto Online/decompiled/bin_database/02000000~1.bin", path.join(outDir, "censor_words.json"));

// 2. Extract All Tables from 01000000~1.bin (Latest Revision)
const constFile = "D:/naruto Online/decompiled/scripts_as3_latest/Resources/Constants/CONST_DATEBASEVO.as";
const constContent = fs.readFileSync(constFile, "utf8");

const classMap = {};
const mapReg = /public static const\s+(\w+)\s*:\s*Class\s*=\s*(\w+)\s*;/g;
let m;
while ((m = mapReg.exec(constContent)) !== null) {
  classMap[m[1]] = m[2];
}

const arrayMatch = constContent.match(/CLASSTYPE_NAMES:Vector\.<Class> = Vector\.<Class>\(\[([\s\S]*?)\]\);/);
const classConstants = arrayMatch[1].split(",").map(s => s.trim()).filter(Boolean);

const xmlMatch = constContent.match(/XML_NAMES:Vector\.<String> = Vector\.<String>\(\[([\s\S]*?)\]\);/);
let tableNames = xmlMatch ? xmlMatch[1].split(",").map(s => s.trim().replace(/^"|"$/g, "")).filter(Boolean) : [];

const voDir = "D:/naruto Online/decompiled/scripts_as3_latest/Logics/DatebaseVO";
const schemas = [];

for (let i = 0; i < classConstants.length; i++) {
  const cConst = classConstants[i];
  const className = classMap[cConst] || cConst.replace("CLASSTYPE_", "T");
  const tableName = tableNames[i] || className;

  let filePath = path.join(voDir, "VO", className + ".as");
  if (!fs.existsSync(filePath)) filePath = path.join(voDir, className + ".as");
  if (!fs.existsSync(filePath)) {
    schemas.push({ className, tableName, fields: null });
    continue;
  }

  const code = fs.readFileSync(filePath, "utf8");
  const streamMatch = code.match(/function ReadDataByStream\([^\)]*\)\s*:\s*void\s*\{([\s\S]*?)\n\s{6}\}/);
  if (!streamMatch) {
    schemas.push({ className, tableName, fields: null });
    continue;
  }

  const body = streamMatch[1];
  const lines = body.split("\n");
  const fields = [];

  for (const line of lines) {
    const trimmed = line.trim();
    if (!trimmed) continue;
    let type = null;
    if (trimmed.includes("FetchUTF")) type = "string";
    else if (trimmed.includes("readUnsignedInt")) type = "uint32";
    else if (trimmed.includes("readInt")) type = "int32";
    else if (trimmed.includes("readBoolean")) type = "boolean";
    else if (trimmed.includes("readFloat")) type = "float";

    if (!type) continue;
    let propName = null;
    const assignMatch = trimmed.match(/this\.([a-zA-Z0-9_]+)\s*=/);
    if (assignMatch) {
      propName = assignMatch[1];
      if (propName.startsWith("F") && propName.length > 1 && propName[1] === propName[1].toUpperCase()) {
        propName = propName.slice(1, 2).toLowerCase() + propName.slice(2);
      }
    }
    fields.push({ prop: propName, type });
  }
  schemas.push({ className, tableName, fields });
}

class BinaryReader {
  constructor(buffer) {
    this.buffer = buffer;
    this.offset = 0;
  }
  readUInt32() {
    const v = this.buffer.readUInt32LE(this.offset);
    this.offset += 4;
    return v;
  }
  readInt32() {
    const v = this.buffer.readInt32LE(this.offset);
    this.offset += 4;
    return v;
  }
  readFloat() {
    const v = this.buffer.readFloatLE(this.offset);
    this.offset += 4;
    return Math.round(v * 100) / 100;
  }
  readBoolean() {
    const v = this.buffer.readUInt8(this.offset) !== 0;
    this.offset += 1;
    return v;
  }
  fetchUTF() {
    const len = this.readUInt32();
    if (len === 0) return "";
    const str = this.buffer.toString("utf8", this.offset, this.offset + len);
    this.offset += len;
    return str;
  }
}

const latestBinPath = "D:/naruto Online/decompiled/bin_database/01000000~1.bin";
const rawBin = fs.readFileSync(latestBinPath);
const buf = zlib.inflateSync(rawBin);
const reader = new BinaryReader(buf);

const tableSummary = [];
const allTables = {};

for (let i = 0; i < schemas.length; i++) {
  const schema = schemas[i];
  if (reader.offset >= buf.length) break;

  const count = reader.readUInt32();
  const rows = [];

  for (let r = 0; r < count; r++) {
    const row = { id: reader.readUInt32() };
    for (const field of schema.fields) {
      let val;
      if (field.type === "string") val = reader.fetchUTF();
      else if (field.type === "uint32") val = reader.readUInt32();
      else if (field.type === "int32") val = reader.readInt32();
      else if (field.type === "boolean") val = reader.readBoolean();
      else if (field.type === "float") val = reader.readFloat();

      if (field.prop) {
        row[field.prop] = val;
      }
    }
    rows.push(row);
  }

  allTables[schema.tableName] = rows;
  tableSummary.push({
    index: i,
    tableName: schema.tableName,
    className: schema.className,
    count: rows.length
  });
}

console.log(`Unpacked ${tableSummary.length} tables from latest bin (${latestBinPath}).`);

// Save latest tables index
fs.writeFileSync(path.join(outDir, "tables_index_latest.json"), JSON.stringify(tableSummary, null, 2), "utf8");

// Save specific updated tables that are critical
const specialTables = [
  { table: "ErrorCode", file: "error_codes.json" },
  { table: "OccultEffect", file: "occult_effects.json" },
  { table: "NinjaUpgrade_ItemTrans", file: "ninja_upgrade_trans.json" },
  { table: "SystemLanguage", file: "system_language.json" },
  { table: "MusicConfig", file: "music_config.json" },
  { table: "Fetters", file: "ninja_fetters.json" },
  { table: "BloodSoul_Attr", file: "blood_soul_attr.json" },
  { table: "WuxingConfig", file: "wuxing_config.json" },
  { table: "ItemBox", file: "item_boxes.json" },
  { table: "TreeChest", file: "tree_chests.json" }
];

for (const entry of specialTables) {
  if (allTables[entry.table]) {
    fs.writeFileSync(path.join(outDir, entry.file), JSON.stringify(allTables[entry.table], null, 2), "utf8");
    console.log(`Saved ${entry.table} (${allTables[entry.table].length} rows) to ${entry.file}`);
  }
}
