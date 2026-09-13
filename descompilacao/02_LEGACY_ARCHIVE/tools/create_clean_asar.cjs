const fs = require('fs');
const path = require('path');

function createAsar(srcDir, destFile) {
  console.log(`Packaging ${srcDir} -> ${destFile}...`);

  const fileEntries = [];
  
  function scan(dir, relPath = '') {
    const entries = fs.readdirSync(dir, { withFileTypes: true });
    const dirObj = { files: {} };

    for (const entry of entries) {
      const fullPath = path.join(dir, entry.name);
      const entryRel = relPath ? `${relPath}/${entry.name}` : entry.name;

      if (entry.isDirectory()) {
        dirObj.files[entry.name] = scan(fullPath, entryRel);
      } else {
        const stat = fs.statSync(fullPath);
        const data = fs.readFileSync(fullPath);
        dirObj.files[entry.name] = {
          size: stat.size,
          offset: 'PLACEHOLDER'
        };
        fileEntries.push({ relPath: entryRel, data, dirObjRef: dirObj.files[entry.name] });
      }
    }
    return dirObj;
  }

  const rootHeader = scan(srcDir);

  // Compute offsets
  let currentOffset = 0;
  for (const item of fileEntries) {
    item.dirObjRef.offset = currentOffset.toString();
    currentOffset += item.data.length;
  }

  // Format header JSON
  const headerJson = JSON.stringify(rootHeader);
  const headerBuf = Buffer.from(headerJson, 'utf8');

  // ASAR pickle format:
  // Offset 0: 4 (pickle header size = 4 bytes)
  // Offset 4: total payload size in bytes (headerPayloadLen)
  // Offset 8: header size in bytes
  // Offset 12: json string length in bytes
  // Offset 16: json string
  const jsonLen = headerBuf.length;
  const paddingLen = (4 - (jsonLen % 4)) % 4;
  const payloadSize = 4 + 4 + 4 + jsonLen + paddingLen; // 12 bytes metadata + json + padding

  const headerBlock = Buffer.alloc(16 + jsonLen + paddingLen);
  headerBlock.writeUInt32LE(4, 0); // pickle size
  headerBlock.writeUInt32LE(payloadSize, 4); // total size
  headerBlock.writeUInt32LE(payloadSize - 4, 8); // header size
  headerBlock.writeUInt32LE(jsonLen, 12); // json string length
  headerBuf.copy(headerBlock, 16);

  // Write file: header + all file buffers
  const outStream = fs.createWriteStream(destFile);
  outStream.write(headerBlock);
  for (const item of fileEntries) {
    outStream.write(item.data);
  }
  outStream.end(() => {
    const totalSize = fs.statSync(destFile).size;
    console.log(`Successfully created ${destFile} (${(totalSize / 1024).toFixed(1)} KB, ${fileEntries.length} files)`);
  });
}

const appDir = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app');
const targetAsar = path.join('D:', 'naruto Online', 'official_client', 'resources', 'app.asar');

createAsar(appDir, targetAsar);
