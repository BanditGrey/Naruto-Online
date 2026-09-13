const fs = require('fs');
const filePath = 'D:/naruto Online/temp_export_as3/scripts/Processors/Game/Lobby/Account/TProcessorAccount.as';
let content = fs.readFileSync(filePath, 'utf8');

const regex = /protected function PacketPerform_SC_CharInfoNtf\(param1:TPacket\) : void\s*\{[\s\S]*?FAffairGenerator\.Generate\(AFFAIRID_TimingWaitLoaded\);\s*\}/;

const newMethod = `protected function PacketPerform_SC_CharInfoNtf(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:THero = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerCharacter.UnstreamizeBasicProperties(_loc2_,this.FCharacter,null);
         this.FUnstreamizerCharacter.UnstreamizeHeros(_loc2_,this.FCharacter.Heros,null);
         _loc3_ = this.FCharacter.GetMainHero();
         if(_loc3_ != null)
         {
            _loc3_.Name = this.FCharacter.NickName;
         }
         this.Visible = false;
         this.ProcessorCreateRole();
         this.ProcessorOnEnterTown();
         this.ProcessorOnInitRequests();
      }`;

if (!regex.test(content)) {
  console.error('Regex match failed!');
} else {
  content = content.replace(regex, newMethod);
  fs.writeFileSync(filePath, content, 'utf8');
  console.log('Successfully patched TProcessorAccount.as!');
}
