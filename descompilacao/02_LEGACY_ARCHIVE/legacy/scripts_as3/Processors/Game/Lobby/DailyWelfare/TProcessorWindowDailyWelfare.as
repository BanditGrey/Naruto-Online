package Processors.Game.Lobby.DailyWelfare
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DailyWelfare.TDailyWelfareData;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TDailyWelfareVO;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_DAILYWELFARE;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorWindowDailyWelfare extends TUIComponent
   {
      
      public static const CONST_CONFIG_ID:uint = 10000000;
      
      public static const REWARD_COUNT:uint = 3;
      
      public static const REWARD_STATUS_None:int = -1;
      
      public static const REWARD_STATUS_Canreceive:int = 0;
      
      public static const REWARD_STATUS_Received:int = 1;
      
      public static const GET_TYPE_Free:int = 0;
      
      public static const GET_TYPE_Gold:int = 1;
      
      public static const REWARD_TYPE_Coin:int = 1;
      
      public static const REWARD_TYPE_Exp:int = 2;
      
      public static const BTN_STATUS_RECEIVED:int = 5;
      
      public static const BTN_SELECT_STATUS_SELECTD:int = 1;
      
      public static const BTN_SELECT_STATUS_NONE:int = 2;
      
      protected var FDailyWelfareData:TDailyWelfareData;
      
      protected var FVipLimit:Vector.<uint>;
      
      protected var FCost:Vector.<uint>;
      
      protected var FExpFreeRate:Vector.<Number>;
      
      protected var FExpGoldRate:Vector.<Number>;
      
      protected var FCoinFreeRate:Vector.<Number>;
      
      protected var FCoinGoldRate:Vector.<Number>;
      
      protected var FCharacter:TCharacter;
      
      protected var FRewardType:uint;
      
      protected var FSelectBtnIndex:uint;
      
      protected var FSelectGetTypeVect:Vector.<int>;
      
      protected var FScene:MovieClip;
      
      protected var FUIWindowInformation:TUIWindowConfirmation;
      
      protected var FConfigValueBins:TBins;
      
      protected var FWelfareBins:TBins;
      
      protected var FWelfare_Daily_Active:uint;
      
      protected var FWelfare_Free_Exp_Fst:Number;
      
      protected var FWelfare_Free_Exp_Sec:Number;
      
      protected var FWelfare_Gold_Exp_Fst:Number;
      
      protected var FWelfare_Gold_Exp_Sec:Number;
      
      protected var FWelfare_Gold_Cost_Fst:uint;
      
      protected var FWelfare_Gold_Cost_Sec:uint;
      
      protected var FWelfare_Level_Coefficient:Number;
      
      protected var FWelfare_Level_Coefficient_Max:Number;
      
      protected var FWelfare_Level_Interval:uint;
      
      protected var FWelfare_Fst_Vip:uint;
      
      protected var FWelfare_Sec_Vip:uint;
      
      protected var FWelfare_Gold_Silver_Fst:Number;
      
      protected var FWelfare_Gold_Silver_Sec:Number;
      
      protected var FWelfare_Vip_Silver_Fst:Number;
      
      protected var FWelfare_Vip_Silver_Sec:Number;
      
      protected var FInitWelfare:Boolean;
      
      protected var FOnGenerateEffectText:Function;
      
      protected var FOnEffectSign:Function;
      
      public function TProcessorWindowDailyWelfare(param1:TUIComponent)
      {
         super(param1);
         this.FDailyWelfareData = new TDailyWelfareData();
         this.FSelectGetTypeVect = new Vector.<int>(REWARD_COUNT);
         this.FCharacter = SLogicsCore.Character;
         this.FInitWelfare = false;
      }
      
      protected function ResourcesPerformUIDispatch(param1:MovieClip) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         this.FScene = param1;
         addChild(this.FScene);
         _loc2_ = 0;
         while(_loc2_ < REWARD_COUNT)
         {
            _loc3_ = this.FScene["MC_Item_" + _loc2_];
            _loc3_.mc_BigBox.gotoAndStop(_loc2_ + 1);
            _loc3_.btn_GetType_0.gotoAndStop(1);
            _loc3_.btn_GetType_1.gotoAndStop(2);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < REWARD_COUNT)
         {
            this.FSelectGetTypeVect[_loc2_] = GET_TYPE_Free;
            _loc2_++;
         }
         this.ResourcesPerformUILocations();
      }
      
      protected function ResourcesPerformUILocations() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc2_ = this.FScene["MC_Item_" + _loc1_];
            _loc2_.btn_Get.addEventListener(MouseEvent.CLICK,this.OnGetRewardBtnClick);
            _loc2_.btn_GetType_0.addEventListener(MouseEvent.CLICK,this.OnChgRewardTypeClick);
            _loc2_.btn_GetType_1.addEventListener(MouseEvent.CLICK,this.OnChgRewardTypeClick);
            _loc1_++;
         }
      }
      
      protected function InitWelfare() : void
      {
         var _loc1_:TConfigValue = null;
         var _loc2_:TSystemLanguage = null;
         if(this.FInitWelfare)
         {
            return;
         }
         this.FWelfareBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DailyWelfare);
         this.FConfigValueBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Daily_Active) as TConfigValue;
         this.FWelfare_Daily_Active = _loc1_.Value as uint;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Free_Exp_Fst) as TConfigValue;
         this.FWelfare_Free_Exp_Fst = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Free_Exp_Sec) as TConfigValue;
         this.FWelfare_Free_Exp_Sec = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Gold_Exp_Fst) as TConfigValue;
         this.FWelfare_Gold_Exp_Fst = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Gold_Exp_Sec) as TConfigValue;
         this.FWelfare_Gold_Exp_Sec = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Gold_Cost_Fst) as TConfigValue;
         this.FWelfare_Gold_Cost_Fst = _loc1_.Value as uint;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Gold_Cost_Sec) as TConfigValue;
         this.FWelfare_Gold_Cost_Sec = _loc1_.Value as uint;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Level_Coefficient) as TConfigValue;
         this.FWelfare_Level_Coefficient = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Level_Coefficient_Max) as TConfigValue;
         this.FWelfare_Level_Coefficient_Max = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Level_Interval) as TConfigValue;
         this.FWelfare_Level_Interval = _loc1_.Value as uint;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Fst_Vip) as TConfigValue;
         this.FWelfare_Fst_Vip = _loc1_.Value as uint;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Sec_Vip) as TConfigValue;
         this.FWelfare_Sec_Vip = _loc1_.Value as uint;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Gold_Silver_Fst) as TConfigValue;
         this.FWelfare_Gold_Silver_Fst = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Gold_Silver_Sec) as TConfigValue;
         this.FWelfare_Gold_Silver_Sec = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Vip_Silver_Fst) as TConfigValue;
         this.FWelfare_Vip_Silver_Fst = _loc1_.Value as Number;
         _loc1_ = this.FConfigValueBins.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Welfare_Vip_Silver_Sec) as TConfigValue;
         this.FWelfare_Vip_Silver_Sec = _loc1_.Value as Number;
         this.FVipLimit = Vector.<uint>([0,this.FWelfare_Fst_Vip,this.FWelfare_Sec_Vip]);
         this.FCost = Vector.<uint>([0,this.FWelfare_Gold_Cost_Fst,this.FWelfare_Gold_Cost_Sec]);
         this.FExpFreeRate = Vector.<Number>([1,this.FWelfare_Free_Exp_Fst,this.FWelfare_Free_Exp_Sec]);
         this.FExpGoldRate = Vector.<Number>([1,this.FWelfare_Gold_Exp_Fst,this.FWelfare_Gold_Exp_Sec]);
         this.FCoinFreeRate = Vector.<Number>([1,this.FWelfare_Vip_Silver_Fst,this.FWelfare_Vip_Silver_Sec]);
         this.FCoinGoldRate = Vector.<Number>([1,this.FWelfare_Gold_Silver_Fst,this.FWelfare_Gold_Silver_Sec]);
         this.FUIWindowInformation = new TUIWindowConfirmation(this.Parent.Parent);
         this.FUIWindowInformation.OnOK = this.WindowInformationOnOK;
         this.FUIWindowInformation.x = (FUICore.StageWidth - this.FUIWindowInformation.WindowWidth) / 2;
         this.FUIWindowInformation.y = (FUICore.StageHeight - this.FUIWindowInformation.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowInformation);
         this.FInitWelfare = true;
      }
      
      protected function PerformPacket_DailyWelfare_LoadInfo(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:uint = 0;
         this.FDailyWelfareData.WorldLevel = param1.readUnsignedInt();
         _loc3_ = param1.readUnsignedShort();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc5_ = param1.readUnsignedInt() - 1;
            _loc4_ = param1.readInt();
            this.FDailyWelfareData.SetReardStatus(_loc5_,_loc4_);
            _loc2_++;
         }
         this.InitWelfare();
         this.CheckRewardStatus();
         if(Visible)
         {
            this.CheckRewardType();
            this.UpdateUI();
         }
      }
      
      protected function PerformPacket_DailyWelfare_GetRewardOk(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc2_ = param1.readUnsignedInt();
         _loc3_ = param1.readUnsignedInt();
         this.FDailyWelfareData.SetReardStatus(_loc2_ - 1,REWARD_STATUS_Received);
         this.UpdateUI();
         this.CheckRewardStatus();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TDailyWelfareVO = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.tf_worldLevel.text = SLogicsCore.Character.MainHero.GetLevelStrByLevel(this.FDailyWelfareData.WorldLevel);
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc2_ = this.FScene["MC_Item_" + _loc1_];
            if(this.FDailyWelfareData.RewardStatus[_loc1_] == REWARD_STATUS_None)
            {
               _loc2_.mc_Received.visible = false;
               _loc2_.mc_lock.visible = true;
               _loc2_.tf_VipLevel.visible = true;
               TGameUtil.setButtonMode(_loc2_.btn_Get,false);
            }
            else if(this.FDailyWelfareData.RewardStatus[_loc1_] == REWARD_STATUS_Canreceive)
            {
               _loc2_.mc_Received.visible = false;
               _loc2_.mc_lock.visible = false;
               _loc2_.tf_VipLevel.visible = false;
               TGameUtil.setButtonMode(_loc2_.btn_Get,true);
            }
            else if(this.FDailyWelfareData.RewardStatus[_loc1_] == REWARD_STATUS_Received)
            {
               _loc2_.mc_Received.visible = true;
               _loc2_.mc_lock.visible = false;
               _loc2_.tf_VipLevel.visible = false;
               TGameUtil.setButtonMode(_loc2_.btn_Get,false);
               _loc2_.btn_Get.gotoAndStop(BTN_STATUS_RECEIVED);
            }
            _loc3_ = this.FWelfareBins.GetDatebaseByIdentifier(CONST_CONFIG_ID + this.FCharacter.GetMainLevel()) as TDailyWelfareVO;
            if(this.FRewardType == REWARD_TYPE_Coin)
            {
               if(this.FSelectGetTypeVect[_loc1_] == GET_TYPE_Free)
               {
                  _loc2_.tf_reward.text = STRING_COMMON.ITEMNAME_Coin + ":" + Math.floor(_loc3_.DailySilver * this.FCoinFreeRate[_loc1_]);
               }
               else if(this.FSelectGetTypeVect[_loc1_] == GET_TYPE_Gold)
               {
                  _loc2_.tf_reward.text = STRING_COMMON.ITEMNAME_Coin + ":" + Math.floor(_loc3_.DailySilver * this.FCoinGoldRate[_loc1_]);
               }
            }
            else if(this.FRewardType == REWARD_TYPE_Exp)
            {
               _loc5_ = Math.min(Math.floor((this.FDailyWelfareData.WorldLevel - this.FCharacter.GetMainHeroLogicLevel(this.FCharacter.GetMainLevel())) / this.FWelfare_Level_Interval) * this.FWelfare_Level_Coefficient,this.FWelfare_Level_Coefficient_Max) + 1;
               _loc4_ = this.FWelfare_Daily_Active * _loc3_.ActiveExp * _loc3_.LevelCoefficient * _loc5_;
               if(this.FSelectGetTypeVect[_loc1_] == GET_TYPE_Free)
               {
                  _loc2_.tf_reward.text = STRING_COMMON.ITEMNAME_Exp + ":" + Math.floor(_loc4_ * this.FExpFreeRate[_loc1_]);
               }
               else if(this.FSelectGetTypeVect[_loc1_] == GET_TYPE_Gold)
               {
                  _loc2_.tf_reward.text = STRING_COMMON.ITEMNAME_Exp + ":" + Math.floor(_loc4_ * this.FExpGoldRate[_loc1_]);
               }
            }
            if(this.FVipLimit[_loc1_] > 0)
            {
               _loc2_.tf_VipLevel.text = TUtilityString.Format(STRING_DAILYWELFARE.STRING_VipLimit,this.FVipLimit[_loc1_]);
            }
            if(this.FCost[_loc1_] > 0)
            {
               _loc2_.tf_GetType_1.visible = true;
               _loc2_.btn_GetType_1.visible = true;
               if(this.FRewardType == REWARD_TYPE_Coin)
               {
                  _loc2_.tf_GetType_0.text = TUtilityString.Format(STRING_DAILYWELFARE.STRING_FreeGet,this.FCoinFreeRate[_loc1_] * 100 + "%");
                  _loc2_.tf_GetType_1.text = TUtilityString.Format(STRING_DAILYWELFARE.STRING_GoldGet,this.FCost[_loc1_],this.FCoinGoldRate[_loc1_] * 100 + "%");
               }
               else if(this.FRewardType == REWARD_TYPE_Exp)
               {
                  _loc2_.tf_GetType_0.text = TUtilityString.Format(STRING_DAILYWELFARE.STRING_FreeGet,this.FExpFreeRate[_loc1_] * 100 + "%");
                  _loc2_.tf_GetType_1.text = TUtilityString.Format(STRING_DAILYWELFARE.STRING_GoldGet,this.FCost[_loc1_],this.FExpGoldRate[_loc1_] * 100 + "%");
               }
            }
            else
            {
               _loc2_.tf_GetType_1.visible = false;
               _loc2_.btn_GetType_1.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function WindowInformationOnOK(param1:Object) : void
      {
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCost[this.FSelectBtnIndex])
         {
            if(this.FOnGenerateEffectText != null)
            {
               this.FOnGenerateEffectText(this,STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         this.GetReward(this.FSelectBtnIndex,GET_TYPE_Gold);
      }
      
      protected function GetReward(param1:uint, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DailyWelfare_GetReward_Req);
         _loc4_ = _loc3_.Data;
         _loc4_.writeInt(param1 + 1);
         _loc4_.writeInt(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function OnChgRewardTypeClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         _loc2_ = uint(int(String(param1.currentTarget.parent.name).slice(8)));
         this.FSelectGetTypeVect[_loc2_] = int(String(param1.currentTarget.name).slice(12));
         _loc3_ = String(param1.currentTarget.name).slice(0,12) + (this.FSelectGetTypeVect[_loc2_] + 1) % 2;
         param1.currentTarget.gotoAndStop(BTN_SELECT_STATUS_SELECTD);
         param1.currentTarget.parent[_loc3_].gotoAndStop(BTN_SELECT_STATUS_NONE);
         this.UpdateUI();
      }
      
      protected function OnGetRewardBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         if(Boolean(param1.currentTarget) && !param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = uint(int(String(param1.currentTarget.parent.name).slice(8)));
         if(this.FSelectGetTypeVect[_loc2_] == GET_TYPE_Free)
         {
            this.GetReward(_loc2_,GET_TYPE_Free);
         }
         else if(this.FSelectGetTypeVect[_loc2_] == GET_TYPE_Gold)
         {
            this.FSelectBtnIndex = _loc2_;
            this.FUIWindowInformation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_DailyWelfare_GetReward).DescribeString,this.FCost[_loc2_]);
            this.FUIWindowInformation.Visible = true;
         }
      }
      
      protected function CheckEffectSign(param1:Boolean) : void
      {
         if(this.FOnEffectSign != null)
         {
            this.FOnEffectSign(this,param1);
         }
      }
      
      public function set OnGenerateEffectText(param1:Function) : void
      {
         this.FOnGenerateEffectText = param1;
      }
      
      public function get OnGenerateEffectText() : Function
      {
         return this.FOnGenerateEffectText;
      }
      
      public function set OnEffectSign(param1:Function) : void
      {
         this.FOnEffectSign = param1;
      }
      
      public function get OnEffectSign() : Function
      {
         return this.FOnEffectSign;
      }
      
      public function CheckRewardType() : void
      {
         this.FRewardType = this.FCharacter.GetMainHeroLogicLevel(this.FCharacter.GetMainLevel()) >= this.FDailyWelfareData.WorldLevel ? uint(REWARD_TYPE_Coin) : uint(REWARD_TYPE_Exp);
      }
      
      public function CheckRewardStatus() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:Boolean = false;
         _loc3_ = false;
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc2_ = uint(this.FDailyWelfareData.RewardStatus[_loc1_]);
            if(_loc2_ != REWARD_STATUS_Received)
            {
               if(this.FCharacter.VipLevel >= this.FVipLimit[_loc1_])
               {
                  this.FDailyWelfareData.RewardStatus[_loc1_] = REWARD_STATUS_Canreceive;
                  _loc3_ = true;
               }
               else
               {
                  this.FDailyWelfareData.RewardStatus[_loc1_] = REWARD_STATUS_None;
               }
            }
            _loc1_++;
         }
         this.CheckEffectSign(_loc3_);
      }
      
      public function DailyWelfareUpdateUI() : void
      {
         this.UpdateUI();
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.ResourcesPerformUIDispatch(param1);
      }
      
      public function DailyWelfare_LoadInfo(param1:ByteArray) : void
      {
         this.PerformPacket_DailyWelfare_LoadInfo(param1);
      }
      
      public function DailyWelfare_GetRewardOk(param1:ByteArray) : void
      {
         this.PerformPacket_DailyWelfare_GetRewardOk(param1);
      }
   }
}

