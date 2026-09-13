const fs = require("fs");
const zlib = require("zlib");

function inspectCensor(path) {
  const raw = fs.readFileSync(path);
  const buf = zlib.inflateSync(raw);
  const count = buf.readUInt32LE(0);
  console.log(path, "Total words:", count);
  let offset = 4;
  const sample = [];
  for (let i = 0; i < Math.min(count, 15); i++) {
    const len = buf.readUInt32LE(offset);
    offset += 4;
    const str = buf.toString("utf8", offset, offset + len);
    offset += len;
    sample.push(str);
  }
  console.log("Sample words:", sample);
}

inspectCensor("C:/Users/Daniel/Desktop/naruto online import/02000000.bin");
inspectCensor("C:/Users/Daniel/Desktop/naruto online import/02000000~1.bin");
