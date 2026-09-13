package Processors.Game.Lobby.Ramen
{
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Foundation.Resources.Bins.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Ramn.*;
   import Logics.Signals.*;
   import Logics.Vip.*;
   import Processors.Game.Lobby.Common.*;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Windows.*;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TProcessorWindowRamen extends TProcessorLobbyWindow
   {
      
      public static const KEY_MAKE_RAMEN:uint = CONST_COUNTER.KEY_MAKE_RAMEN;
      
      protected var FScene:MovieClip;
      
      protected var FBT_Goods:MovieClip;
      
      protected var FMC_CD:MovieClip;
      
      protected var FBT_ReceiveAwards:MovieClip;
      
      protected var FTF_GoodsNum:TextField;
      
      protected var FTF_ReceiveAwardsNum:TextField;
      
      protected var FTF_CD:TextField;
      
      protected var FMC_Exp:MovieClip;
      
      protected var FTF_ExpNum:TextField;
      
      protected var FTF_LV:TextField;
      
      protected var FMC_ExpBar:MovieClip;
      
      protected var FTF_ShopName:TextField;
      
      protected var FTF_CostGold:TextField;
      
      protected var FTF_GainSilver:TextField;
      
      protected var FTF_TF:TextField;
      
      protected var FTF_NowCount:TextField;
      
      protected var FTF_VIP:TextField;
      
      protected var FTF_NextCount:TextField;
      
      protected var FTF_Limit:TextField;
      
      protected var FMC_MakeRamenOnce:MovieClip;
      
      protected var FTF_MakeRamenOnce:TextField;
      
      protected var FMC_MakeRamenOneTime:MovieClip;
      
      protected var FTF_MakeRamenOneTime:TextField;
      
      protected var FMC_MakeRamenBatch:MovieClip;
      
      protected var FMC_BackMyShop:MovieClip;
      
      protected var FMC_View:MovieClip;
      
      protected var FMC_Boss:MovieClip;
      
      protected var FBuyMoneyBins:TBins;
      
      protected var FNoVipCount:uint;
      
      protected var FBatchCount:uint;
      
      protected var FRamenSendCount:uint;
      
      protected var FRamenSendCD:uint;
      
      protected var FCharacter:TCharacter;
      
      protected var FMyFriends:TFriendDigests;
      
      protected var FVipData:TVip;
      
      protected var FRamenData:TRamenData;
      
      protected var FFriendRamenData:TFriendRamenData;
      
      protected var FMakeRamenNum:uint;
      
      protected var FMakeRamenType:uint;
      
      protected var FCostGold:int;
      
      protected var FUIWindowConfirmationMakeRamen:TUIWindowConfirmation;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      protected var FIsFriendShop:Boolean;
      
      protected var FIsInit:Boolean;
      
      protected var FMakeRamen:Function;
      
      protected var FReturnMyShop:Function;
      
      protected var FSendSelfGoods:Function;
      
      protected var FSendFriendGoods:Function;
      
      protected var FShowReceiveWindow:Function;
      
      protected var FOnEffectFree:Function;
      
      public function TProcessorWindowRamen(param1:TUIComponent)
      {
         super(param1);
         this.FRamenData = SLogicsCore.RamenData;
         this.FCharacter = SLogicsCore.Character;
         this.FMyFriends = SLogicsCore.Friends;
         this.FVipData = this.FCharacter.VipData;
      }
      
      protected function ResourcesPerform_Dispatch(param1:MovieClip) : void
      {
         var _loc2_:TConfigValue = null;
         var _loc3_:TBins = null;
         this.FScene = param1;
         this.FTF_ShopName = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_ShopName];
         this.FBT_Goods = this.FScene[CONST_RAMEN.RESOURCE_Link_BT_Goods];
         this.FTF_GoodsNum = this.FBT_Goods[CONST_RAMEN.RESOURCE_Link_TF_GoodsNum];
         TGameUtil.setButtonMode(this.FBT_Goods,true);
         this.FMC_CD = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_CD];
         this.FTF_CD = this.FMC_CD[CONST_RAMEN.RESOURCE_Link_TF_CD];
         this.FBT_ReceiveAwards = this.FScene[CONST_RAMEN.RESOURCE_Link_BT_ReceiveAwards];
         this.FTF_ReceiveAwardsNum = this.FBT_ReceiveAwards[CONST_RAMEN.RESOURCE_Link_TF_ReceiveAwardsNum];
         TGameUtil.setButtonMode(this.FBT_ReceiveAwards,true);
         this.FMC_Exp = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_Exp] as MovieClip;
         this.FTF_ExpNum = this.FMC_Exp[CONST_RAMEN.RESOURCE_Link_TF_ExpNum];
         this.FTF_LV = this.FMC_Exp[CONST_RAMEN.RESOURCE_Link_TF_LV];
         this.FMC_ExpBar = this.FMC_Exp[CONST_RAMEN.RESOURCE_Link_MC_ExpBar];
         this.FTF_CostGold = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_CostGold];
         this.FTF_GainSilver = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_GainSilver1];
         this.FTF_TF = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_tf];
         this.FTF_NowCount = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_NowCount];
         this.FTF_VIP = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_VIP];
         this.FTF_NextCount = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_NextCount];
         this.FTF_Limit = this.FScene[CONST_RAMEN.RESOURCE_Link_TF_Limit];
         this.FMC_MakeRamenOnce = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_MakeRamenOnce];
         this.FMC_MakeRamenOneTime = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_MakeRamenOneTime];
         this.FMC_MakeRamenBatch = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_MakeRamenBatch];
         this.FMC_BackMyShop = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_BackMyShop];
         this.FTF_MakeRamenOnce = this.FMC_MakeRamenOnce[CONST_RAMEN.RESOURCE_Link_TF_MakeRamenOneTime];
         this.FTF_MakeRamenOneTime = this.FMC_MakeRamenOneTime[CONST_RAMEN.RESOURCE_Link_TF_MakeRamenOneTime];
         TGameUtil.setButtonMode(this.FMC_MakeRamenOnce,true);
         TGameUtil.setButtonMode(this.FMC_MakeRamenOneTime,true);
         TGameUtil.setButtonMode(this.FMC_MakeRamenBatch,true);
         TGameUtil.setButtonMode(this.FMC_BackMyShop,true);
         this.FMC_View = this.FScene[CONST_RAMEN.RESOURCE_Link_MC_View];
         this.FMC_Boss = this.FMC_View[CONST_RAMEN.RESOURCE_Link_MC_Boss];
         this.FUIWindowConfirmationMakeRamen = new TUIWindowConfirmation(Parent.Parent);
         this.FUIWindowConfirmationMakeRamen.OnOK = this.WindowConfirmationMakeRamenOnOK;
         this.FUIWindowConfirmationMakeRamen.x = (STAGE_Width - this.FUIWindowConfirmationMakeRamen.WindowWidth) / 2;
         this.FUIWindowConfirmationMakeRamen.y = (STAGE_Height - this.FUIWindowConfirmationMakeRamen.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmationMakeRamen);
         this.FUIWindowConfirmationMakeRamen.SetCheckBox(true);
         this.FUIWindowRecharge = new TUIWindowRecharge(Parent.Parent);
         this.FUIWindowRecharge.x = (STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         _loc3_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         _loc2_ = _loc3_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Ramen_NoVipCount) as TConfigValue;
         this.FNoVipCount = _loc2_.Value as uint;
         _loc2_ = _loc3_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Ramen_BatchCount) as TConfigValue;
         this.FBatchCount = _loc2_.Value as uint;
         _loc2_ = _loc3_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Ramen_Trains_CD) as TConfigValue;
         this.FRamenSendCD = _loc2_.Value as uint;
         _loc2_ = _loc3_.GetDatebaseByIdentifier(CONST_CONFIGVALUE.Ramen_TrainsCount) as TConfigValue;
         this.FRamenData.SelfRamenSendCount = _loc2_.Value as uint;
         this.FBuyMoneyBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_BuyMoney);
         this.FIsInit = true;
         this.ResourcesPerform_Locations();
      }
      
      protected function ResourcesPerform_Locations() : void
      {
         this.FBT_Goods.addEventListener(MouseEvent.CLICK,this.OnSendGoods);
         this.FBT_ReceiveAwards.addEventListener(MouseEvent.CLICK,this.OnShowReceiveWindow);
         this.FMC_BackMyShop.addEventListener(MouseEvent.CLICK,this.OnBackShop);
         this.FMC_MakeRamenOnce.addEventListener(MouseEvent.CLICK,this.OnMakeRamen);
         this.FMC_MakeRamenOneTime.addEventListener(MouseEvent.CLICK,this.OnMakeRamen);
         this.FMC_MakeRamenBatch.addEventListener(MouseEvent.CLICK,this.OnMakeRamen);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TSignal = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         if(this.FIsInit)
         {
            if(!this.FIsFriendShop)
            {
               _loc4_ = this.FRamenData.SelfRamenSendCD + this.FRamenSendCD - STimingCore.GetServerTick();
               if(_loc4_ <= 0)
               {
                  this.FBT_Goods.visible = Boolean(this.FRamenData.CanSendGoodsCount > 0);
                  this.FTF_GoodsNum.text = "*" + this.FRamenData.CanSendGoodsCount.toString();
                  this.FMC_CD.visible = false;
               }
               else
               {
                  this.FBT_Goods.visible = false;
                  this.FMC_CD.visible = true;
                  this.FTF_CD.text = TGameUtil.fomatSmallTime(_loc4_);
               }
            }
         }
         _loc1_ = SLogicsCore.SignalRetrieve(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_MakeRamen_Ret);
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_ = _loc1_.Identifier;
         _loc3_ = uint(_loc1_.Value);
         if(_loc2_ == KEY_MAKE_RAMEN)
         {
            if(this.FVipData.VipLevel == 0)
            {
               this.FMakeRamenNum = this.FNoVipCount - _loc3_;
            }
            else
            {
               this.FMakeRamenNum = this.FVipData.DailyChangeNum - _loc3_;
            }
            if(this.FIsInit)
            {
               this.UpDateTextFields(_loc3_);
            }
            if(this.FOnEffectFree != null)
            {
               this.FOnEffectFree(_loc3_ == 0);
            }
         }
         super.LogicsPerform();
      }
      
      protected function UpdateUI() : void
      {
         var _loc1_:String = null;
         var _loc2_:TFriendDigest = null;
         var _loc3_:TTree = null;
         if(this.FIsFriendShop)
         {
            this.FBT_Goods.visible = false;
            this.FBT_ReceiveAwards.visible = false;
            this.FMC_CD.visible = false;
            if(this.FFriendRamenData.FriendRamenSendGoodsCount <= 0)
            {
               this.FTF_GoodsNum.text = "";
               this.FBT_Goods.visible = true;
            }
            _loc1_ = "";
            _loc2_ = this.FMyFriends.GetDigestByIdentifier(this.FFriendRamenData.Identifier0,this.FFriendRamenData.Identifier1);
            if(this.FMyFriends != null)
            {
               _loc1_ = _loc2_.Name;
            }
            this.FTF_ShopName.text = _loc1_ + STRING_Ramen.FORMAT_ShopName;
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Tree,this.FFriendRamenData.FriendRamenLevel) as TTree;
            this.FTF_LV.text = SLogicsCore.Character.MainHero.GetLevelStrByLevelLineFeed(this.FFriendRamenData.FriendRamenLevel);
            this.FTF_ExpNum.text = STRING_COMMON.ITEMNAME_Exp + ":  " + this.FFriendRamenData.FriendRamenCurrentExp.toString() + "/" + _loc3_.Exp;
            this.FMC_ExpBar.scaleX = Math.max(Math.min(this.FFriendRamenData.FriendRamenCurrentExp / _loc3_.Exp,1),0);
            this.FMC_View.gotoAndStop(_loc3_.ModelId);
         }
         else
         {
            this.FBT_Goods.visible = false;
            this.FBT_ReceiveAwards.visible = false;
            this.FMC_CD.visible = false;
            this.FTF_GoodsNum.text = "*" + this.FRamenData.CanSendGoodsCount;
            if(this.FRamenData.SelfRamenRewardCount > 0)
            {
               this.FTF_ReceiveAwardsNum.text = "*" + this.FRamenData.SelfRamenRewardCount;
               this.FBT_ReceiveAwards.visible = true;
            }
            this.FTF_ShopName.text = this.FCharacter.NickName + STRING_Ramen.FORMAT_ShopName;
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Tree,this.FRamenData.SelfRamenLevel) as TTree;
            this.FTF_LV.text = SLogicsCore.Character.MainHero.GetLevelStrByLevelLineFeed(this.FRamenData.SelfRamenLevel);
            this.FTF_ExpNum.text = STRING_COMMON.ITEMNAME_Exp + ":  " + this.FRamenData.SelfRamenCurrentExp.toString() + "/" + _loc3_.Exp;
            this.FMC_ExpBar.scaleX = Math.max(Math.min(this.FRamenData.SelfRamenCurrentExp / _loc3_.Exp,1),0);
            this.FMC_View.gotoAndStop(_loc3_.ModelId);
         }
      }
      
      protected function UpDateTextFields(param1:int) : void
      {
         var _loc2_:TBuyMoney = null;
         var _loc3_:TBuyMoney = null;
         var _loc4_:TVipConfig = null;
         if(param1 < CONST_PROTAGONIST.LevelRamenNum)
         {
            _loc2_ = this.FBuyMoneyBins.GetDatebaseByIdentifier(param1 + 1) as TBuyMoney;
         }
         else
         {
            _loc2_ = this.FBuyMoneyBins.GetDatebaseByIdentifier(param1) as TBuyMoney;
         }
         _loc3_ = this.FBuyMoneyBins.GetDatebaseByIdentifier(this.FCharacter.GetMainLevel()) as TBuyMoney;
         this.FTF_MakeRamenOnce.text = param1 == 0 ? STRING_Ramen.STRING_Free : STRING_Ramen.STRING_Make;
         this.FTF_MakeRamenOneTime.text = param1 == 0 ? STRING_Ramen.STRING_Free : STRING_Ramen.STRING_Make;
         this.FTF_CostGold.text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenCostGold,_loc2_.CostGold);
         this.FTF_GainSilver.text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenGainSliver,_loc3_.Money);
         if(this.FVipData.VipLevel == this.FVipData.VipLevelUpperLimit)
         {
            this.FTF_NowCount.text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenCount,this.FMakeRamenNum);
            this.FTF_VIP.visible = this.FTF_NextCount.visible = false;
            this.FTF_TF.x = 105;
            this.FTF_NowCount.x = this.FTF_TF.x + this.FTF_TF.width;
         }
         else
         {
            this.FTF_VIP.visible = this.FTF_NextCount.visible = true;
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_VipConfig,this.FVipData.VipLevel + 1) as TVipConfig;
            this.FTF_NowCount.text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenCount,this.FMakeRamenNum);
            this.FTF_VIP.text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenVIP,this.FVipData.VipLevel + 1);
            this.FTF_NextCount.text = TUtilityString.Format(STRING_Ramen.FORMAT_MakeRamenCount,_loc4_.DailyChangeNum);
         }
      }
      
      protected function CheckBtn() : void
      {
         if(this.FIsFriendShop)
         {
            this.FMC_MakeRamenOnce.visible = false;
            this.FMC_MakeRamenOneTime.visible = false;
            this.FMC_MakeRamenBatch.visible = false;
            this.FMC_BackMyShop.visible = true;
            this.FTF_Limit.visible = false;
         }
         else
         {
            if(this.FVipData.MoreChange)
            {
               this.FMC_MakeRamenOnce.visible = false;
               this.FMC_MakeRamenOneTime.visible = true;
               this.FMC_MakeRamenBatch.visible = true;
               this.FTF_Limit.visible = false;
            }
            else
            {
               this.FMC_MakeRamenOnce.visible = true;
               this.FMC_MakeRamenOneTime.visible = false;
               this.FMC_MakeRamenBatch.visible = false;
               this.FTF_Limit.visible = true;
            }
            this.FMC_BackMyShop.visible = false;
         }
      }
      
      protected function OnSendGoods(param1:MouseEvent) : void
      {
         var _loc2_:TTree = null;
         if(this.FIsFriendShop)
         {
            if(this.FSendFriendGoods != null)
            {
               this.FSendFriendGoods(this);
            }
         }
         else
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Tree,this.FRamenData.SelfRamenLevel) as TTree;
            if(this.FCharacter.GetMainLevel() <= this.FRamenData.SelfRamenLevel && this.FRamenData.SelfRamenCurrentExp >= _loc2_.Exp - 1)
            {
               EffectGenerateText(STRING_Ramen.STRING_FullLevel);
               return;
            }
            if(this.FSendSelfGoods != null)
            {
               this.FSendSelfGoods(0);
            }
         }
      }
      
      protected function OnShowReceiveWindow(param1:MouseEvent) : void
      {
         if(this.FShowReceiveWindow != null)
         {
            this.FShowReceiveWindow(this);
         }
      }
      
      protected function OnBackShop(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         this.FIsFriendShop = false;
         this.UpdateUI();
         this.CheckBtn();
         if(this.FReturnMyShop != null)
         {
            this.FReturnMyShop(this);
         }
      }
      
      protected function OnMakeRamen(param1:MouseEvent) : void
      {
         var _loc2_:TBuyMoney = null;
         var _loc3_:TBuyMoney = null;
         var _loc4_:TBuyMoney = null;
         var _loc5_:TConfigValue = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         TutorialNextStep(2301);
         if(this.FMakeRamenNum <= 0)
         {
            EffectGenerateText(STRING_Ramen.STRING_FinishMakeRamen);
            return;
         }
         if(this.FVipData.VipLevel == 0)
         {
            _loc2_ = this.FBuyMoneyBins.GetDatebaseByIdentifier(this.FNoVipCount - this.FMakeRamenNum + 1) as TBuyMoney;
         }
         else
         {
            _loc2_ = this.FBuyMoneyBins.GetDatebaseByIdentifier(this.FVipData.DailyChangeNum - this.FMakeRamenNum + 1) as TBuyMoney;
         }
         _loc3_ = this.FBuyMoneyBins.GetDatebaseByIdentifier(this.FCharacter.GetMainLevel()) as TBuyMoney;
         switch(param1.target)
         {
            case this.FMC_MakeRamenOnce:
            case this.FMC_MakeRamenOneTime:
               this.FMakeRamenType = 0;
               this.FCostGold = _loc2_.CostGold;
               if(!this.FUIWindowConfirmationMakeRamen.IsSelected && this.FCostGold != 0)
               {
                  this.FUIWindowConfirmationMakeRamen.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Ramen_Make).DescribeString,this.FCostGold);
                  this.FUIWindowConfirmationMakeRamen.SetCheckBox(true);
                  this.FUIWindowConfirmationMakeRamen.Visible = true;
               }
               else if(this.FMakeRamen != null)
               {
                  this.FMakeRamen(this,this.FMakeRamenType);
               }
               break;
            case this.FMC_MakeRamenBatch:
               this.FMakeRamenType = 1;
               _loc4_ = this.FBuyMoneyBins.GetDatebaseByIdentifier(this.FVipData.DailyChangeNum - this.FMakeRamenNum + 1) as TBuyMoney;
               if(_loc4_ == null)
               {
                  return;
               }
               _loc6_ = uint(this.FBuyMoneyBins.GetIndexByDateBase(_loc4_));
               if(_loc6_ == -1)
               {
                  return;
               }
               _loc8_ = 0;
               if(this.FMakeRamenNum < this.FBatchCount)
               {
                  _loc9_ = _loc6_ + this.FMakeRamenNum;
               }
               else
               {
                  _loc9_ = _loc6_ + this.FBatchCount;
               }
               _loc10_ = _loc6_;
               while(_loc10_ < _loc9_)
               {
                  _loc4_ = this.FBuyMoneyBins.GetDatebaseByIndex(_loc10_) as TBuyMoney;
                  _loc8_ += _loc4_.CostGold;
                  _loc10_++;
               }
               if(this.FMakeRamenNum < this.FBatchCount)
               {
                  _loc7_ = this.FMakeRamenNum;
               }
               else
               {
                  _loc7_ = this.FBatchCount;
               }
               this.FCostGold = _loc8_;
               if(this.FCostGold != 0)
               {
                  this.FUIWindowConfirmationMakeRamen.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Ramen_Make_All).DescribeString,_loc8_,_loc7_,_loc3_.Money * _loc7_);
                  this.FUIWindowConfirmationMakeRamen.SetCheckBox(false);
                  this.FUIWindowConfirmationMakeRamen.Visible = true;
               }
               else if(this.FMakeRamen != null)
               {
                  this.FMakeRamen(this,this.FMakeRamenType);
               }
         }
      }
      
      protected function WindowConfirmationMakeRamenOnOK(param1:Object) : void
      {
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCostGold)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         if(this.FMakeRamen != null)
         {
            this.FMakeRamen(this,this.FMakeRamenType);
         }
      }
      
      public function get MakeRamen() : Function
      {
         return this.FMakeRamen;
      }
      
      public function set MakeRamen(param1:Function) : void
      {
         this.FMakeRamen = param1;
      }
      
      public function get ReturnMyShop() : Function
      {
         return this.FReturnMyShop;
      }
      
      public function set ReturnMyShop(param1:Function) : void
      {
         this.FReturnMyShop = param1;
      }
      
      public function get SendSelfGoods() : Function
      {
         return this.FSendSelfGoods;
      }
      
      public function set SendSelfGoods(param1:Function) : void
      {
         this.FSendSelfGoods = param1;
      }
      
      public function get SendFriendGoods() : Function
      {
         return this.FSendFriendGoods;
      }
      
      public function set SendFriendGoods(param1:Function) : void
      {
         this.FSendFriendGoods = param1;
      }
      
      public function get ShowReceiveWindow() : Function
      {
         return this.FShowReceiveWindow;
      }
      
      public function set ShowReceiveWindow(param1:Function) : void
      {
         this.FShowReceiveWindow = param1;
      }
      
      public function get OnEffectFree() : Function
      {
         return this.FOnEffectFree;
      }
      
      public function set OnEffectFree(param1:Function) : void
      {
         this.FOnEffectFree = param1;
      }
      
      public function SelfSendGoodsOk() : void
      {
         this.UpdateUI();
         this.CheckBtn();
      }
      
      public function Update() : void
      {
         this.UpdateUI();
      }
      
      public function BackMyShop() : void
      {
         this.FIsFriendShop = false;
         this.UpdateUI();
         this.CheckBtn();
      }
      
      public function VisitFriendShop(param1:TFriendRamenData) : void
      {
         this.FIsFriendShop = true;
         this.FFriendRamenData = param1;
         this.UpdateUI();
         this.CheckBtn();
      }
      
      public function ResourcesPerformDispatch(param1:MovieClip) : void
      {
         this.ResourcesPerform_Dispatch(param1);
      }
   }
}

