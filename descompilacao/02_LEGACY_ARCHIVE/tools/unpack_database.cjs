const fs = require("fs");
const path = require("path");
const zlib = require("zlib");

// 1. Read CONST_DATEBASEVO.as
const constFile = "D:/naruto Online/legacy/scripts_as3/Resources/Constants/CONST_DATEBASEVO.as";
const constContent = fs.readFileSync(constFile, "utf8");

// Parse CLASSTYPE mappings
const classMap = {};
const mapReg = /public static const\s+(\w+)\s*:\s*Class\s*=\s*(\w+)\s*;/g;
let m;
while ((m = mapReg.exec(constContent)) !== null) {
  classMap[m[1]] = m[2];
}

// Parse CLASSTYPE_NAMES array
const arrayMatch = constContent.match(/CLASSTYPE_NAMES:Vector\.<Class> = Vector\.<Class>\(\[([\s\S]*?)\]\);/);
if (!arrayMatch) {
  console.error("Could not find CLASSTYPE_NAMES array!");
  process.exit(1);
}
const classConstants = arrayMatch[1].split(",").map(s => s.trim()).filter(Boolean);

// Parse XML_NAMES array
const xmlMatch = constContent.match(/XML_NAMES:Vector\.<String> = Vector\.<String>\(\[([\s\S]*?)\]\);/);
let tableNames = [];
if (xmlMatch) {
  tableNames = xmlMatch[1].split(",").map(s => s.trim().replace(/^"|"$/g, "")).filter(Boolean);
}

console.log(`Loaded ${classConstants.length} table definitions.`);

// 2. Build Schema for each class
const voDir = "D:/naruto Online/legacy/scripts_as3/Logics/DatebaseVO";
const schemas = [];

for (let i = 0; i < classConstants.length; i++) {
  const cConst = classConstants[i];
  const className = classMap[cConst] || cConst.replace("CLASSTYPE_", "T");
  const tableName = tableNames[i] || className;

  let filePath = path.join(voDir, "VO", className + ".as");
  if (!fs.existsSync(filePath)) {
    filePath = path.join(voDir, className + ".as");
  }

  if (!fs.existsSync(filePath)) {
    console.warn(`File not found for ${className} (${filePath})`);
    schemas.push({ className, tableName, fields: null });
    continue;
  }

  const code = fs.readFileSync(filePath, "utf8");
  const streamMatch = code.match(/function ReadDataByStream\([^\)]*\)\s*:\s*void\s*\{([\s\S]*?)\n\s{6}\}/);
  if (!streamMatch) {
    console.warn(`ReadDataByStream not found for ${className}`);
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

// 3. Binary Reader Little Endian
class BinaryReader {
  constructor(buffer) {
    this.buffer = buffer;
    this.offset = 0;
  }

  readUInt32() {
    const val = this.buffer.readUInt32LE(this.offset);
    this.offset += 4;
    return val;
  }

  readInt32() {
    const val = this.buffer.readInt32LE(this.offset);
    this.offset += 4;
    return val;
  }

  readFloat() {
    const val = this.buffer.readFloatLE(this.offset);
    this.offset += 4;
    return Math.round(val * 100) / 100;
  }

  readBoolean() {
    const val = this.buffer.readUInt8(this.offset) !== 0;
    this.offset += 1;
    return val;
  }

  fetchUTF() {
    const len = this.readUInt32();
    if (len === 0) return "";
    const str = this.buffer.toString("utf8", this.offset, this.offset + len);
    this.offset += len;
    return str;
  }
}

// 4. Open and Decompress
const binPath = "C:/Users/Daniel/Desktop/naruto online/01000000.bin";
if (!fs.existsSync(binPath)) {
  console.error("Binary database file not found:", binPath);
  process.exit(1);
}
const raw = fs.readFileSync(binPath);
console.log(`Decompressing ${binPath} (${raw.length} bytes)...`);
const buf = zlib.inflateSync(raw);
console.log(`Decompressed size: ${buf.length} bytes.`);
const reader = new BinaryReader(buf);

const outDir = "D:/naruto Online/database/extracted";
fs.mkdirSync(outDir, { recursive: true });

const tableSummary = [];
const allTables = {};

for (let i = 0; i < schemas.length; i++) {
  const schema = schemas[i];
  if (reader.offset >= buf.length) {
    console.log(`Reached end of buffer at table ${i} (${schema.tableName})`);
    break;
  }

  const count = reader.readUInt32();
  const tableRows = [];

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

    tableRows.push(row);
  }

  allTables[schema.tableName] = tableRows;
  tableSummary.push({
    index: i,
    tableName: schema.tableName,
    className: schema.className,
    count: tableRows.length
  });
}

console.log(`Successfully unpacked ${tableSummary.length} tables cleanly.`);

// 5. Export Key Datasets
const keyMappings = [
  { table: "BaseHero", file: "heroes.json" },
  { table: "BasePet", file: "pets.json" },
  { table: "PetImage", file: "pet_images.json" },
  { table: "City", file: "cities.json" },
  { table: "SkillConfig", file: "skills.json" },
  { table: "Article", file: "items.json" },
  { table: "BaseEquip", file: "equips.json" },
  { table: "Enemy", file: "enemies.json" },
  { table: "EnemyArmy", file: "enemy_armies.json" },
  { table: "Task", file: "tasks.json" },
  { table: "TaskDramaDialogue", file: "dialogues.json" },
  { table: "Tavern_Warrior", file: "tavern_warriors.json" },
  { table: "Tavern_Grade", file: "tavern_grades.json" },
  { table: "DungeonsBattle", file: "dungeons.json" },
  { table: "NPC", file: "npcs.json" },
  { table: "RoleModel", file: "role_models.json" },
  { table: "EightInnerGates_Attr", file: "eight_gates.json" },
  { table: "HeroTalent", file: "talents.json" },
  { table: "Suit", file: "suits.json" }
];

for (const m of keyMappings) {
  if (allTables[m.table]) {
    const p = path.join(outDir, m.file);
    fs.writeFileSync(p, JSON.stringify(allTables[m.table], null, 2), "utf8");
    console.log(`Saved [${m.table}] (${allTables[m.table].length} rows) -> ${m.file}`);
  }
}

// Save index
fs.writeFileSync(path.join(outDir, "tables_index.json"), JSON.stringify(tableSummary, null, 2), "utf8");
console.log(`Saved table index to tables_index.json.`);
console.log("Database extraction completed successfully!");
