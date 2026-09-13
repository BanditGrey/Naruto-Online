const fs = require("fs");

const s = fs.readFileSync("legacy/scripts_as3/Resources/Constants/CONST_NETWORK.as", "utf8");
const lines = s.split("\n");

const modules = [];
const opcodes = [];

for (const line of lines) {
  const modMatch = line.match(/(MODULARID_\w+|MODELARID_\w+)\s*:\s*(?:uint|int)\s*=\s*(\d+);/);
  if (modMatch) {
    modules.push({ name: modMatch[1], base: parseInt(modMatch[2], 10) });
  }

  const opMatch = line.match(/public static const (\w+)\s*:\s*(?:uint|int)\s*=\s*(.*?);/);
  if (opMatch && !opMatch[1].startsWith("CONNECTIONSTATE") && !opMatch[1].startsWith("SIZE_") && !opMatch[1].startsWith("PACKET_")) {
    opcodes.push({ name: opMatch[1], expr: opMatch[2].trim() });
  }
}

console.log("Total Modules in CONST_NETWORK:", modules.length);
console.log("Total Opcodes in CONST_NETWORK:", opcodes.length);
console.log("\nAll Modules:");
console.table(modules);
