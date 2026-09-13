package Processors.Game.Lobby.Protagonist
{
   import Foundation.Common.*;
   import Foundation.Common.Integer.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import Logics.Military.*;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.HelpTips.*;
   import Rendering.Overlayers.Hints.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.utils.*;
   
   public class TProcessorProtagonist extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Protagonist:int = 665;
      
      protected static const SIZE_HEIGHT_Protagonist:int = 480;
      
      protected var FProcessorWindowProtagonist:TProcessorWindowProtagonist;
      
      protected var FBinsMilitary:TBins;
      
      protected var FBinsHeroExp:TBins;
      
      protected var FMilitaryData:TMilitaryData;
      
      protected var FHeroExpData:THeroExpData;
      
      protected var FBoundsProtagonist:TBounds;
      
      protected var FPositioning:uint;
      
      protected var FOnMilitaryRankChange:Function;
      
      protected var FOnUserUpdateBaseInfo:Function;
      
      protected var FCheckCanUpgradeMilitary:Function;
      
      protected var FAddPopTips:Function;
      
      protected var FUpdateHeroPower:Function;
      
      public function TProcessorProtagonist(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowProtagonist = new TProcessorWindowProtagonist(this);
         this.FProcessorWindowProtagonist.OnUpgradeMilitary = this.PerformPacket_CS_UpgradeReq;
         this.FProcessorWindowProtagonist.OnGetIncome = this.PerformPacket_CS_ReceiveSalaryReq;
         this.FProcessorWindowProtagonist.HintOnOver = this.UIComponentsOnOver;
         this.FProcessorWindowProtagonist.HintOnOut = this.UIComponentsOnOut;
         this.FProcessorWindowProtagonist.OnHelpTipsOver = UIHelpTipsHintOnOver;
         this.FProcessorWindowProtagonist.OnHelpTipsOut = UIHelpTipsHintOnOut;
         this.FBoundsProtagonist = new TBounds();
         this.FBoundsProtagonist.Width = SIZE_WIDTH_Protagonist;
         this.FBoundsProtagonist.Height = SIZE_HEIGHT_Protagonist;
         ComponentBoundsCenter(this.FProcessorWindowProtagonist,this.FBoundsProtagonist);
         this.FMilitaryData = new TMilitaryData(CONST_PROTAGONIST.MilitaryInforNum);
         this.FMilitaryData.OrganizationName = "";
         this.FHeroExpData = new THeroExpData(CONST_PROTAGONIST.LevelNum);
         FOverlayerHint = new TOverlayerHint(this);
         FOverlayerHint.visible = false;
         FOverlayerHelpTips = new TOverlayerHelpTips(this);
         FOverlayerHelpTips.Visible = false;
         SetUIModuleID(CONST_MODULES.MODULE_Protagonist);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PROTAGONIST.RESOURCESID_Swf_Protagonist);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MilitaryRank_MilitaryRankInfoRet,this.PerformPacket_SC_MilitaryRankInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MilitaryRank_UpgradeRet,this.PerformPacket_SC_UpgradeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_MilitaryRank_ReceiveSalaryRet,this.PerformPacket_SC_ReceiveSalaryRet);
      }
      
      protected function PerformPacket_SC_MilitaryRankInfoRet(param1:TPacket) : void
      {
         var _loc2_:TCharacter = null;
         var _loc3_:Boolean = false;
         this.FMilitaryData.MilitaryRank = param1.Data.readUnsignedInt();
         this.FMilitaryData.CurrentCredit = param1.Data.readUnsignedInt();
         this.FMilitaryData.SalaryState = param1.Data.readByte() == 0;
         if(visible)
         {
            this.FProcessorWindowProtagonist.MilitaryData = this.FMilitaryData;
            this.FProcessorWindowProtagonist.Update();
            this.FProcessorWindowProtagonist.visible = true;
         }
         this.CheckIfCanUpgrade();
      }
      
      protected function PerformPacket_SC_UpgradeRet(param1:TPacket) : void
      {
         var _loc2_:TCharacter = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         _loc2_ = SLogicsCore.Character;
         _loc3_ = param1.Data.readByte();
         if(_loc3_ != 0)
         {
            return;
         }
         this.FMilitaryData.MilitaryRank = param1.Data.readUnsignedInt();
         this.FMilitaryData.CurrentCredit = param1.Data.readUnsignedInt();
         this.FMilitaryData.SalaryState = param1.Data.readByte() == 0;
         this.FProcessorWindowProtagonist.MilitaryData = this.FMilitaryData;
         this.FProcessorWindowProtagonist.Update();
         _loc2_.MilitaryRank = this.FMilitaryData.MilitaryRank;
         _loc2_.Prestige = this.FMilitaryData.CurrentCredit;
         if(this.FOnMilitaryRankChange != null)
         {
            this.FOnMilitaryRankChange(this);
         }
         if(this.FUpdateHeroPower != null)
         {
            this.FUpdateHeroPower(this,SLogicsCore.Character.Heros.GetHeroByIndex(0).Identifier);
         }
         this.FlyTextUpgradeMilitary();
      }
      
      protected function PerformPacket_SC_ReceiveSalaryRet(param1:TPacket) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TCharacter = SLogicsCore.Character;
         _loc3_ = param1.Data.readByte();
         if(_loc3_ == 0)
         {
            this.FMilitaryData.CurrentSilverCoin.High = param1.Data.readUnsignedInt();
            this.FMilitaryData.CurrentSilverCoin.Low = param1.Data.readUnsignedInt();
            this.FMilitaryData.CurrentSpirit = param1.Data.readUnsignedInt();
            this.FProcessorWindowProtagonist.MilitaryData = this.FMilitaryData;
            this.FProcessorWindowProtagonist.Update();
            _loc2_.CreditSilverCoin.High = this.FMilitaryData.CurrentSilverCoin.High;
            _loc2_.CreditSilverCoin.Low = this.FMilitaryData.CurrentSilverCoin.Low;
            _loc2_.GeneralsSoul = this.FMilitaryData.CurrentSpirit;
            if(this.FOnUserUpdateBaseInfo != null)
            {
               this.FOnUserUpdateBaseInfo(this);
            }
            this.FlyTextRecevieSalary();
         }
      }
      
      protected function PerformPacket_CS_MilitaryRankInfoReq() : void
      {
         TUtilityTransmitEmptyInfor.TransmitEmptyPacket(CONST_NETWORK.PACKETID_CS_MilitaryRank_MilitaryRankInfoReq);
      }
      
      protected function PerformPacket_CS_UpgradeReq() : void
      {
         TUtilityTransmitEmptyInfor.TransmitEmptyPacket(CONST_NETWORK.PACKETID_CS_MilitaryRank_Upgrade);
      }
      
      protected function PerformPacket_CS_ReceiveSalaryReq() : void
      {
         TUtilityTransmitEmptyInfor.TransmitEmptyPacket(CONST_NETWORK.PACKETID_CS_MilitaryRank_ReceiveSalary);
      }
      
      protected function FlyTextRecevieSalary() : void
      {
         var _loc1_:TMilitaryLocalData = null;
         var _loc2_:String = null;
         _loc1_ = this.FMilitaryData.GetMilitaryInforByIndex(this.FMilitaryData.MilitaryRank - CONST_PROTAGONIST.MilitaryInforMinID);
         _loc2_ = STRING_COMMON.ITEMNAME_Coin + "*" + _loc1_.AnyMilitarySalarySilvercoin + "\n";
         _loc2_ += STRING_COMMON.ITEMNAME_Soul + "*" + _loc1_.AnyMilitarySalarySpirit;
         EffectGenerateText(_loc2_);
      }
      
      protected function FlyTextUpgradeMilitary() : void
      {
         var _loc1_:TMilitaryLocalData = null;
         var _loc2_:String = null;
         _loc1_ = this.FMilitaryData.GetMilitaryInforByIndex(this.FMilitaryData.MilitaryRank - CONST_PROTAGONIST.MilitaryInforMinID);
         _loc2_ = STRING_PROTAGONIST.STRING_UpgradeSuccess;
         _loc2_ = _loc2_.split("%name%").join(_loc1_.AnyMilitaryName);
         EffectGenerateText(_loc2_);
      }
      
      protected function GetInforFromOtherModule() : void
      {
         var _loc1_:UInt64 = null;
         var _loc2_:TBaseHero = null;
         var _loc3_:UInt64 = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,SLogicsCore.Character.Heros.GetHeroByIndex(0).Identifier) as TBaseHero;
         this.FMilitaryData.JobID = _loc2_.Profession;
         this.FMilitaryData.RoleName = SLogicsCore.Character.NickName;
         this.FMilitaryData.CountryName = STRING_COMMON.FamilyNames[SLogicsCore.Character.Country];
         this.FMilitaryData.Level = SLogicsCore.Character.GetMainLevelCopy();
         _loc3_ = SLogicsCore.Character.GetMainExperience();
         this.FMilitaryData.Experience.High = _loc3_.High;
         this.FMilitaryData.Experience.Low = _loc3_.Low;
         _loc1_ = this.FHeroExpData.UpgradeNeedExp(this.FMilitaryData.Level);
         this.FMilitaryData.UpgradeNeedExperience.High = _loc1_.High;
         this.FMilitaryData.UpgradeNeedExperience.Low = _loc1_.Low;
         this.FMilitaryData.BattleValue = SLogicsCore.Character.GetFightingPowerPVE().ToNumber();
      }
      
      protected function InitMilitaryBaseInfor() : void
      {
         var _loc1_:TMilitaryLocalData = null;
         var _loc2_:int = 0;
         var _loc3_:TMilitary = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc4_ = CONST_PROTAGONIST.MilitaryInforMinID;
         _loc5_ = this.FMilitaryData.InforCount;
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc3_ = this.FBinsMilitary.GetDatebaseByIdentifier(_loc4_ + _loc2_) as TMilitary;
            _loc1_ = new TMilitaryLocalData(CONST_PROTAGONIST.ATTRIBUTE_NUM);
            this.FMilitaryData.SetMilitaryInforByIndex(_loc1_,_loc2_);
            this.FlushMilitaryData(_loc3_,_loc1_);
            _loc2_++;
         }
      }
      
      protected function InitHeroExp() : void
      {
         var _loc1_:int = 0;
         var _loc2_:THeroExp = null;
         _loc1_ = 0;
         while(_loc1_ < CONST_PROTAGONIST.LevelNum)
         {
            _loc2_ = this.FBinsHeroExp.GetDatebaseByIndex(_loc1_) as THeroExp;
            this.FHeroExpData.SetNeedExpByIndex(_loc1_,_loc2_.NeedExp);
            this.FHeroExpData.SetNeedExpIndexByIndex(_loc1_,_loc2_.Identifier);
            _loc1_++;
         }
      }
      
      protected function FlushMilitaryData(param1:TMilitary, param2:TMilitaryLocalData) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TAddOther = null;
         param2.AnyMilitaryName = param1.Name;
         param2.AnyMilitaryNamePrefix = param1.PrefixBefor;
         param2.AnyMilitaryNameSubfix = param1.PrefixEnd;
         param2.AnyMilitaryCreditDayCost = param1.CostCredit;
         param2.UpgradeAnyLevelNeedCredit = param1.NeedCredit;
         param2.AnyMilitarySalarySilvercoin = param1.RewardSiliverCoin;
         param2.AnyMilitarySalarySpirit = param1.RewardSpirit;
         param2.AnyMilitaryMaxHeroNum = param1.MaxHeroNum;
         param2.AnyMilitaryFightHeroNum = param1.FightHeroNum;
         _loc4_ = int(param1.AddOtherArray.length);
         param2.AnyMilitaryUseableCount = _loc4_;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.AddOtherArray[_loc3_];
            param2.AnyMilitaryAttributesValue[_loc3_] = _loc5_.Value.toString();
            _loc3_++;
         }
      }
      
      protected function ProcessorStreamData(param1:ByteArray) : void
      {
         if(param1 != null)
         {
            this.FPositioning = param1.readUnsignedByte();
         }
      }
      
      override protected function PopTipsNotifyCheck() : void
      {
         if(FOnCheckPopTipsModes != null)
         {
            FOnCheckPopTipsModes(this,CONST_POPTIPS.POPTIP_Goto_AvaterHead);
         }
      }
      
      protected function UIComponentsOnOver(param1:Object, param2:THint) : void
      {
         FOverlayerHint.Context = param2;
         FOverlayerHint.Render(FUICore.MouseCoordinate);
         FOverlayerHint.Show();
      }
      
      protected function UIComponentsOnOut(param1:Object) : void
      {
         FOverlayerHint.Hide();
      }
      
      override public function set OnClose(param1:Function) : void
      {
         FOnClose = param1;
         this.FProcessorWindowProtagonist.OnClose = param1;
      }
      
      public function set OnMilitaryRankChange(param1:Function) : void
      {
         this.FOnMilitaryRankChange = param1;
      }
      
      public function get OnUserUpdateBaseInfo() : Function
      {
         return this.FOnUserUpdateBaseInfo;
      }
      
      public function set OnUserUpdateBaseInfo(param1:Function) : void
      {
         this.FOnUserUpdateBaseInfo = param1;
      }
      
      public function set CheckCanUpgradeMilitary(param1:Function) : void
      {
         this.FCheckCanUpgradeMilitary = param1;
      }
      
      public function set AddPopTips(param1:Function) : void
      {
         this.FAddPopTips = param1;
      }
      
      public function set UpdateHeroPower(param1:Function) : void
      {
         this.FUpdateHeroPower = param1;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FProcessorWindowProtagonist.OnShortcutHyperlinks = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         this.ProcessorStreamData(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowProtagonist.Load();
            return;
         }
         this.GetInforFromOtherModule();
         this.PerformPacket_CS_MilitaryRankInfoReq();
         this.FProcessorWindowProtagonist.Show();
         this.FProcessorWindowProtagonist.PerformPosition(this.FPositioning);
      }
      
      override public function Unmount() : void
      {
         this.CheckIfCanUpgrade();
         this.FPositioning = 0;
         super.Unmount();
      }
      
      public function UpdatePrestige() : void
      {
         this.FMilitaryData.CurrentCredit = SLogicsCore.Character.Prestige;
         this.FMilitaryData.MilitaryRank = SLogicsCore.Character.MilitaryRank;
         this.CheckIfCanUpgrade();
      }
      
      public function LoadMilitaryInfor() : void
      {
         this.FBinsMilitary = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Military);
         this.FBinsHeroExp = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_HeroExp);
         this.InitMilitaryBaseInfor();
         this.InitHeroExp();
      }
      
      public function CheckIfCanUpgrade() : void
      {
         var _loc1_:TMilitaryLocalData = null;
         var _loc2_:Boolean = false;
         if(this.FMilitaryData.MilitaryRank + 1 <= CONST_PROTAGONIST.MilitaryInforMaxID && this.FMilitaryData.MilitaryRank != 0)
         {
            _loc1_ = this.FMilitaryData.GetMilitaryInforByIndex(this.FMilitaryData.MilitaryRank - CONST_PROTAGONIST.MilitaryInforMinID + 1);
            if(_loc1_ == null)
            {
               return;
            }
            this.FMilitaryData.CurrentCredit == SLogicsCore.Character.Prestige;
            if(this.FMilitaryData.CurrentCredit >= _loc1_.UpgradeAnyLevelNeedCredit)
            {
               _loc2_ = true;
               if(this.FAddPopTips != null)
               {
                  this.FAddPopTips(this,CONST_POPTIPS.POPTIP_ToleranceLevel);
               }
            }
            else
            {
               _loc2_ = false;
            }
         }
         _loc2_ ||= this.FMilitaryData.SalaryState;
         if(this.FCheckCanUpgradeMilitary != null)
         {
            this.FCheckCanUpgradeMilitary(CONST_SHORTCUTS.POSITION_Avatar,CONST_SHORTCUTS.TYPE_Avatar_Military,_loc2_);
         }
      }
      
      public function SetPlayerOrganizationalName(param1:String) : void
      {
         this.FMilitaryData.OrganizationName = param1;
      }
      
      public function RequestMilitaryBaseInfor() : void
      {
         this.PerformPacket_CS_MilitaryRankInfoReq();
      }
   }
}

