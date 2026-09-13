const fs = require("fs");

const processorDiffs = [
  "Processors/Game/Lobby/TProcessorLobby.as",
  "Processors/Game/Lobby/Shortcuts/TProcessorShortcuts.as",
  "Processors/Game/Lobby/Shortcuts/Window/TWindowMap.as",
  "Processors/Game/Lobby/Shortcuts/Window/TWindowAvatar.as",
  "Processors/Game/Lobby/Backpack/TProcessorWindowUserAssets.as",
  "Processors/Game/Lobby/Exercise/AccountTransfer/TProcessorAccountTransfer.as",
  "Processors/Game/Lobby/Discord/TProcessorDiscord.as"
];

for (const p of processorDiffs) {
  const s1 = fs.readFileSync("legacy/scripts_as3/" + p, "utf8");
  const s2 = fs.readFileSync("debug 2/scripts/" + p, "utf8");
  console.log("=== " + p + " ===");
  console.log("Lines legacy:", s1.split("\n").length, "Lines debug2:", s2.split("\n").length);
}
