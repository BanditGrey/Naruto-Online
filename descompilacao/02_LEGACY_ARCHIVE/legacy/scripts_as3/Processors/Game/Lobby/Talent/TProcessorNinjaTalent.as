package Processors.Game.Lobby.Talent
{
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.THeroTalent;
   import Logics.DatebaseVO.VO.TRefreshTalentConfig;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Talent.TUnstreamizerNinjaTalent;
   import Logics.Talent.TNinjaTalentData;
   import Logics.Talent.TNinjaTalentVO;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.Lobby.Talent.Component.TUINinjaTalentBox;
   import Processors.Game.Windows.Information.TUIWindowPromptFrame;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorNinjaTalent extends TProcessorLobbyWindows
   {
      
      protected var FMainClip:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FProcessorTalentPerview:TProcessorTalentPerview;
      
      protected var FWindowTalent:TProcessorWindowNinjaTalent;
      
      protected var FUIWindowPromptFrame:TUIWindowPromptFrame;
      
      protected var FBTN_Upgrade:MovieClip;
      
      protected var mcExpBar:MovieClip;
      
      protected var FBTN_gotoward:MovieClip;
      
      protected var FBTN_Exchange:MovieClip;
      
      protected var FBtn_Close:SimpleButton;
      
      protected var FBtn_Help:*;
      
      protected var MC_Hero:MovieClip;
      
      protected var FUIHero:TUIHero;
      
      protected var expBarWid:int;
      
      protected var CurId:int;
      
      protected var curExp:int;
      
      protected var curLevel:int;
      
      protected var FCharacter:TCharacter;
      
      protected var FCostItemId:int;
      
      protected var FUnstreamizerNinjaTalent:TUnstreamizerNinjaTalent;
      
      protected var FNinjaTalentData:TNinjaTalentData;
      
      protected var FHint:THint;
      
      public var GotoOpenLevelGifts:Function;
      
      public var GotoOpenTalentGifts:Function;
      
      public function TProcessorNinjaTalent(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerNinjaTalent = new TUnstreamizerNinjaTalent();
         this.FNinjaTalentData = SLogicsCore.NinjaTalentData;
         this.FHint = new THint();
      }
      
      public static function AttributeFormat(param1:int, param2:Number = 0, param3:Boolean = false) : String
      {
         var _loc4_:int = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1);
         var _loc5_:String = "";
         if(_loc4_ >= 0)
         {
            return STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc4_];
         }
         if(param3)
         {
            _loc5_ = param2 + "%";
         }
         else
         {
            _loc5_ = param2 + "";
         }
         return _loc5_;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4026531843);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         this.FMainClip = TUtilityReflection.CreateDisplayObjectInstance("MC_NinjaTallent") as MovieClip;
         addChild(this.FMainClip);
         this.FProcessorTalentPerview = new TProcessorTalentPerview(Parent);
         this.FProcessorTalentPerview.OnRefreshTalentForce = this.PerformPacket_CS_RefreshTalent_Force;
         this.FProcessorTalentPerview.Load();
         this.FWindowTalent = new TProcessorWindowNinjaTalent(this.FMainClip["TalentWindow"]);
         this.FWindowTalent.OnNinjaTalentRefreshReq = this.PerformPacket_CS_NinjaTalent_Refresh_Req;
         this.FWindowTalent.OnNinjaTalentSetReq = this.PerformPacket_CS_NinjaTalent_Set_Req;
         this.FWindowTalent.OnBoxLockOnOver = this.OnBoxLockOnOver;
         this.FWindowTalent.OnBoxLockOnOut = this.OnBoxLockOnOut;
         this.FWindowTalent.OnGetInventoryById = this.getInventoryById;
         this.FWindowTalent.OnEffectGenerateText = this.OnEffectGenerateText;
         this.FWindowTalent.OnOpenTalentPerview = this.OnOpenTalentPerview;
         this.FWindowTalent.Visible = false;
         this.FUITab = new TUITab(this);
         this.FUITab.SetTabByIndex(this.FMainClip["mc_tab_0"],0);
         this.FUITab.SetTabByIndex(this.FMainClip["mc_tab_1"],1);
         this.FUITab.OnSwitch = this.OnTabChange;
         this.FUITab.Init();
         this.FBtn_Close = this.FMainClip["Btn_Close"];
         this.FBtn_Help = this.FMainClip["Btn_Help"];
         this.FBTN_Upgrade = this.FMainClip["BTN_upgrade"];
         TGameUtil.setButtonMode(this.FBTN_Upgrade,true);
         this.mcExpBar = this.FMainClip["MC_Bar"] as MovieClip;
         this.expBarWid = this.mcExpBar.width;
         this.FBTN_gotoward = this.FMainClip["BTN_gotoward"];
         TGameUtil.setButtonMode(this.FBTN_gotoward,true);
         this.FBTN_Exchange = this.FMainClip["BTN_Exchange"];
         TGameUtil.setButtonMode(this.FBTN_Exchange,true);
         this.FMainClip.x = stage.stageWidth - this.FMainClip.width >> 1;
         this.FMainClip.y = stage.stageHeight - this.FMainClip.height >> 1;
         this.FUIWindowPromptFrame = new TUIWindowPromptFrame(Parent);
         this.FUIWindowPromptFrame.Callback = this.PerformPacket_CS_NinjaTalent_Upgrade_Req;
         this.FUIWindowPromptFrame.x = (FUICore.StageWidth - this.FUIWindowPromptFrame.Window_Width) / 2;
         this.FUIWindowPromptFrame.y = (FUICore.StageHeight - this.FUIWindowPromptFrame.Window_Height) / 2;
         TUtilityUIWindow.SetupWindowPromptFrame(this.FUIWindowPromptFrame);
         this.FUIHero = new TUIHero(this);
         this.MC_Hero = this.FMainClip["mc_hero"];
         this.MC_Hero.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         this.FCharacter = SLogicsCore.Character;
         this.FUIHero.Context = this.FCharacter.MainHero;
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,99100002) as TConfigValue;
         this.FCostItemId = _loc1_.Value[0];
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,99100005) as TConfigValue;
         this.FWindowTalent.ConfigValue = _loc1_.Value as Vector.<Object>;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FBTN_Upgrade.addEventListener(MouseEvent.CLICK,this.OnClickUpgrade);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver,false,0,true);
         this.FBtn_Help.addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut,false,0,true);
         this.FBTN_gotoward.addEventListener(MouseEvent.CLICK,this.ProcessorOpenLevelGifts);
         this.FBTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOpenTalentGifts);
         super.ResourcesPerform_UILocations();
      }
      
      private function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:THero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as THero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.Identifier) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_Heros);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      protected function OnBoxLockOnOver(param1:TUINinjaTalentBox) : void
      {
         var _loc2_:THeroTalent = null;
         if(param1.NinjaTalentVO.RefreshId != 0)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_HeroTalent,param1.NinjaTalentVO.Talent) as THeroTalent;
            this.FHint.Caption = _loc2_.TalentDesc;
         }
         else
         {
            this.FHint.Caption = TUtilityString.GetText(80002372 + param1.PosIdx);
         }
         ProcessorTipOnOver(this,this.FHint);
      }
      
      protected function OnBoxLockOnOut() : void
      {
         ProcessorTipOnOut(this);
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:THint = new THint();
         if(UIHelpTipsHintOnOver != null)
         {
            _loc2_.Content = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.HELPTIPS_NinjaTalent);
            UIHelpTipsHintOnOver(this,_loc2_);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(UIHelpTipsHintOnOut != null)
         {
            UIHelpTipsHintOnOut(this);
         }
      }
      
      protected function ProcessorOpenLevelGifts(param1:MouseEvent) : void
      {
         if(this.GotoOpenLevelGifts != null)
         {
            this.GotoOpenLevelGifts();
         }
      }
      
      protected function ProcessorOpenTalentGifts(param1:MouseEvent) : void
      {
         if(this.GotoOpenTalentGifts != null)
         {
            this.GotoOpenTalentGifts();
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaTalent_Info_Ret,this.PerformPacket_SC_NinjaTalent_Info_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaTalent_Upgrade_Ret,this.PerformPacket_SC_NinjaTalent_Upgrade_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaTalent_Refresh_Ret,this.PerformPacket_SC_NinjaTalent_Refresh_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_NinjaTalent_Set_Ret,this.PerformPacket_SC_NinjaTalent_Set_Ret);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_RefreshTalent_Force,this.PerformPacket_SC_RefreshTalent_Force);
         super.PacketRegisterRoutines();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_NinjaTalent_Info_Req();
      }
      
      override protected function LogicsPerform() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FUIHero.Update();
         this.FWindowTalent.LogicsPerform();
         super.LogicsPerform();
      }
      
      private function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function PerformPacket_SC_NinjaTalent_Info_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         this.CurId = _loc2_.readInt();
         this.curExp = _loc2_.readInt();
         this.FUnstreamizerNinjaTalent.Unstreamize(_loc2_,this.FNinjaTalentData,null);
         this.FWindowTalent.UpdateUI(this.FNinjaTalentData);
         this.UpdateNinjaTalentInfo(this.CurId,this.curExp);
      }
      
      protected function PerformPacket_SC_NinjaTalent_Upgrade_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.CurId = _loc2_.readInt();
         this.curExp = _loc2_.readInt();
         this.UpdateNinjaTalentInfo(this.CurId,this.curExp);
      }
      
      protected function PerformPacket_SC_NinjaTalent_Refresh_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerNinjaTalent.UnstreamizationPerformByRefresh(_loc2_,this.FNinjaTalentData,null);
         this.FWindowTalent.UpdateUI(this.FNinjaTalentData);
      }
      
      protected function PerformPacket_SC_NinjaTalent_Set_Ret(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FNinjaTalentData.CurHeroId = _loc2_.readUnsignedInt();
         this.FWindowTalent.UpdateUI(this.FNinjaTalentData);
      }
      
      protected function PerformPacket_SC_RefreshTalent_Force(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TNinjaTalentVO = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc6_ = int(_loc2_.readUnsignedInt());
         _loc7_ = int(_loc2_.readUnsignedInt());
         _loc5_ = this.FNinjaTalentData.GetNinjaTalentVOByIndex(_loc7_ - 1);
         _loc5_.Identity = _loc6_;
         _loc5_.RefreshId = _loc6_;
         this.FNinjaTalentData.RefreshStatus = false;
         _loc5_.RefreshStatus = false;
         this.FWindowTalent.UpdateUI(this.FNinjaTalentData);
      }
      
      protected function PerformPacket_CS_RefreshTalent_Force(param1:int) : void
      {
         var _loc3_:TPacket = null;
         if(!this.FWindowTalent.CurrNinjaTalentBox)
         {
            return;
         }
         this.FProcessorTalentPerview.Visible = false;
         var _loc2_:int = this.FWindowTalent.CurrNinjaTalentBox.PosIdx + 1;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_RefreshTalent_Force);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(_loc2_);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PerformPacket_CS_NinjaTalent_Info_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaTalent_Info_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_NinjaTalent_Upgrade_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaTalent_Upgrade_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PerformPacket_CS_NinjaTalent_Refresh_Req(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:TPacket = null;
         _loc4_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaTalent_Refresh_Req);
         _loc4_.Data.writeInt(param1);
         _loc4_.Data.writeInt(param2);
         _loc4_.Data.writeInt(param3);
         SNetworkCore.Transceiver.PacketTransmit(_loc4_);
      }
      
      protected function PerformPacket_CS_NinjaTalent_Set_Req(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NinjaTalent_Set_Req);
         _loc3_.Data.writeInt(param1);
         _loc3_.Data.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnTabChange(param1:int) : void
      {
         this.FTabIndex = param1;
         this.FWindowTalent.Visible = this.FTabIndex == 1;
      }
      
      protected function OnClickUpgrade(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.getInventoryById(this.FCostItemId);
         if(_loc2_ < 1)
         {
            EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Emblem_01));
            return;
         }
         this.FUIWindowPromptFrame.MaxCount = _loc2_;
         this.FUIWindowPromptFrame.Visible = true;
      }
      
      protected function UpdateNinjaTalentInfo(param1:int, param2:int) : void
      {
         var _loc3_:TRefreshTalentConfig = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RefreshTalentConfig,param1) as TRefreshTalentConfig;
         this.FMainClip["MC_Level_Num"].text = TUtilityString.Format(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Emblem_04),_loc3_.Class,_loc3_.Classlevel);
         this.FMainClip["TF_Exp"].text = TUtilityString.Format(TUtilityString.GetText(70470011),param2 - _loc3_.AllExp,_loc3_.NeedExp);
         this.FMainClip["MC_Bar"]["MC_Mask"].width = (param2 - _loc3_.AllExp) / _loc3_.NeedExp * this.expBarWid;
         this.FMainClip["TF_ItemNum"].text = this.getInventoryById(this.FCostItemId);
         this.FormatTalentAttribute(_loc3_);
      }
      
      protected function FormatTalentAttribute(param1:TRefreshTalentConfig) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:TRefreshTalentConfig = null;
         var _loc6_:Array = null;
         _loc5_ = param1.NextRefreshTalentConfig;
         _loc2_ = int(param1.Porperties.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1.Porperties[_loc4_];
            this.FMainClip["TF_Cur_Attribute_" + _loc4_].text = AttributeFormat(_loc3_[0]);
            this.FMainClip["TF_Cur_Value_" + _loc4_].text = AttributeFormat(0,_loc3_[1]);
            if(_loc5_)
            {
               _loc6_ = _loc5_.Porperties[_loc4_];
               this.FMainClip["TF_Next_Attribute_" + _loc4_].text = AttributeFormat(_loc6_[0]);
               this.FMainClip["TF_Next_Value_" + _loc4_].text = AttributeFormat(0,_loc6_[1]);
            }
            else
            {
               this.FMainClip["TF_Next_Attribute_" + _loc4_].text = AttributeFormat(_loc3_[0]);
               this.FMainClip["TF_Next_Value_" + _loc4_].text = AttributeFormat(0,_loc3_[1]);
            }
            _loc4_++;
         }
         _loc2_ = int(param1.Porpertyrates.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1.Porpertyrates[_loc4_];
            this.FMainClip["TF_Attribute_" + _loc4_].text = AttributeFormat(_loc3_[0]);
            this.FMainClip["TF_AttriValue_" + _loc4_].text = AttributeFormat(0,_loc3_[1],true);
            _loc4_++;
         }
      }
      
      protected function OnOpenTalentPerview() : void
      {
         if(!this.FWindowTalent.CurrNinjaTalentBox)
         {
            EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_NinjaTalent_02));
            return;
         }
         if(this.FProcessorTalentPerview)
         {
            this.FProcessorTalentPerview.Visible = true;
         }
      }
      
      protected function OnEffectGenerateText() : void
      {
         EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_NinjaTalent_01));
      }
      
      public function getInventoryById(param1:int) : int
      {
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         return _loc2_.GetAllCountByTempletID(param1);
      }
   }
}

