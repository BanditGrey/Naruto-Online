const fs = require("fs");
const zlib = require("zlib");
const path = require("path");

const unpackSrc = fs.readFileSync("tools/unpack_database.cjs", "utf8");
const idx = unpackSrc.indexOf("const binPath = ");
const prefix = unpackSrc.slice(0, idx);

const runCode = `
function parse(filePath) {
  const raw = fs.readFileSync(filePath);
  const buf = zlib.inflateSync(raw);
  const reader = new BinaryReader(buf);
  const counts = {};
  for (let i = 0; i < schemas.length; i++) {
    if (reader.offset >= buf.length) break;
    const schema = schemas[i];
    const count = reader.readUInt32();
    counts[schema.tableName] = count;
    for (let r = 0; r < count; r++) {
      reader.readUInt32();
      for (const field of schema.fields) {
        if (field.type === 'string') reader.fetchUTF();
        else if (field.type === 'uint32') reader.readUInt32();
        else if (field.type === 'int32') reader.readInt32();
        else if (field.type === 'boolean') reader.readBoolean();
        else if (field.type === 'float') reader.readFloat();
      }
    }
  }
  return { counts, offset: reader.offset, total: buf.length };
}

const f1 = 'C:/Users/Daniel/Desktop/naruto online import/01000000.bin';
const f2 = 'C:/Users/Daniel/Desktop/naruto online import/01000000~1.bin';

const r1 = parse(f1);
const r2 = parse(f2);
console.log('01000000.bin: read ' + r1.offset + ' of ' + r1.total + ' bytes.');
console.log('01000000~1.bin: read ' + r2.offset + ' of ' + r2.total + ' bytes.');

const diffs = [];
for (const k in r2.counts) {
  const c1 = r1.counts[k] || 0;
  const c2 = r2.counts[k] || 0;
  if (c1 !== c2) {
    diffs.push({ table: k, v1: c1, v2: c2, diff: c2 - c1 });
  }
}
console.log('Total tables with differences: ' + diffs.length);
console.table(diffs);
`;

eval(prefix + runCode);
