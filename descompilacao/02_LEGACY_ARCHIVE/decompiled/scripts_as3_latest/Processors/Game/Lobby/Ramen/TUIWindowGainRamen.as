package Processors.Game.Lobby.Ramen
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.*;
   import Logics.DatebaseVO.VO.TTreeChest;
   import Logics.Ramn.*;
   import Logics.Vip.*;
   import Processors.Game.Lobby.Common.*;
   import Resources.Constants.*;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_Ramen;
   import flash.display.*;
   import flash.events.*;
   import flash.text.*;
   
   public class TUIWindowGainRamen extends TProcessorLobbyWindows
   {
      
      protected var FRamenScene:MovieClip;
      
      protected var FTF_ShopLevel:TextField;
      
      protected var FMC_GetRamen:MovieClip;
      
      protected var FMC_BackShop:MovieClip;
      
      protected var FMC_VIP:MovieClip;
      
      protected var FTF_CurVip:TextField;
      
      protected var FTF_CurGainSilver:TextField;
      
      protected var FTF_CuGainGiftCertificate:TextField;
      
      protected var FTF_NextVip:TextField;
      
      protected var FTF_NextGainSilver:TextField;
      
      protected var FTF_NextGainGiftCertificate:TextField;
      
      protected var FMC_NotVIP:MovieClip;
      
      protected var FTF_NotVipGainSilver:TextField;
      
      protected var FTF_NotVipGainGiftCertificate:TextField;
      
      protected var FTF_VipGainSilver:TextField;
      
      protected var FTF_VipGainGiftCertificate:TextField;
      
      protected var FMC_Recharge:MovieClip;
      
      protected var FRamenData:TRamenData;
      
      protected var FVipData:TVip;
      
      protected var FTreeChestBins:TBins;
      
      protected var FOnShortcutHyperlinks:Function;
      
      protected var FGetRewards:Function;
      
      public function TUIWindowGainRamen(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FVipData = SLogicsCore.Character.VipData;
         this.FRamenData = SLogicsCore.RamenData;
      }
      
      protected function ResourcesPerform_Dispatch() : void
      {
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-this.x,-this.y,CONST_COMMON.STAGE_Max_Width,CONST_COMMON.STAGE_Max_Height);
         this.graphics.endFill();
         this.FRamenScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_RAMEN.RESOURCE_ClassName_GainRamen) as MovieClip;
         addChild(this.FRamenScene);
         this.FTF_ShopLevel = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_TF_ShopLevel];
         this.FMC_GetRamen = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_GetRamen];
         this.FMC_BackShop = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_BackShop];
         this.FMC_VIP = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_VIP];
         this.FMC_NotVIP = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_NotVIP];
         this.FTF_CurVip = this.FMC_VIP[CONST_RAMEN.RESOURCE_Link_TF_CurVip];
         this.FTF_CurGainSilver = this.FMC_VIP[CONST_RAMEN.RESOURCE_Link_TF_CurGainSilver];
         this.FTF_CuGainGiftCertificate = this.FMC_VIP[CONST_RAMEN.RESOURCE_Link_TF_CurGainGiftCertificate];
         this.FTF_NextVip = this.FMC_VIP[CONST_RAMEN.RESOURCE_Link_TF_NextVip];
         this.FTF_NextGainSilver = this.FMC_VIP[CONST_RAMEN.RESOURCE_Link_TF_NextGainSilver];
         this.FTF_NextGainGiftCertificate = this.FMC_VIP[CONST_RAMEN.RESOURCE_Link_TF_NextGainGiftCertificate];
         this.FTF_NotVipGainSilver = this.FMC_NotVIP[CONST_RAMEN.RESOURCE_Link_TF_NotVipGainSilver];
         this.FTF_NotVipGainGiftCertificate = this.FMC_NotVIP[CONST_RAMEN.RESOURCE_Link_TF_NotVipGainGiftCertificate];
         this.FTF_VipGainSilver = this.FMC_NotVIP[CONST_RAMEN.RESOURCE_Link_TF_VipGainSilver];
         this.FTF_VipGainGiftCertificate = this.FMC_NotVIP[CONST_RAMEN.RESOURCE_Link_TF_VipGainGiftCertificate];
         this.FMC_Recharge = this.FMC_NotVIP[CONST_RAMEN.RESOURCE_Link_MC_Recharge];
         this.FTreeChestBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_TreeChest);
         this.ResourcesPerform_Locations();
      }
      
      protected function ResourcesPerform_Locations() : void
      {
         TGameUtil.setButtonMode(this.FMC_GetRamen,true);
         this.FMC_GetRamen.addEventListener(MouseEvent.CLICK,this.OnGetRewards);
         TGameUtil.setButtonMode(this.FMC_BackShop,true);
         this.FMC_BackShop.addEventListener(MouseEvent.CLICK,this.OnTurnBack);
         TGameUtil.setButtonMode(this.FMC_Recharge,true);
         this.FMC_Recharge.addEventListener(MouseEvent.CLICK,this.OnRecharge);
      }
      
      protected function GetCoin(param1:TTreeChest) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         if(param1 == null)
         {
            return 0;
         }
         _loc3_ = param1.RewardsVect.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.RewardsVect[_loc2_];
            if(_loc4_.type == 0 && _loc4_.code == 0)
            {
               return _loc4_.amount;
            }
            _loc2_++;
         }
         return 0;
      }
      
      protected function GetVouchers(param1:TTreeChest) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         if(param1 == null)
         {
            return 0;
         }
         _loc3_ = param1.RewardsVect.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = param1.RewardsVect[_loc2_];
            if(_loc4_.type == 0 && _loc4_.code == 2)
            {
               return _loc4_.amount;
            }
            _loc2_++;
         }
         return 0;
      }
      
      protected function Update() : void
      {
         var _loc1_:TTreeChest = null;
         var _loc2_:TTreeChest = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         this.FTF_ShopLevel.text = STRING_Ramen.FORMAT_LV1 + (this.FRamenData.SelfRamenLevel - this.FRamenData.SelfRamenRewardCount + 1);
         _loc1_ = this.FTreeChestBins.GetDatebaseByValue2("TreeLv",this.FRamenData.SelfRamenLevel - this.FRamenData.SelfRamenRewardCount + 1,"VipLv",this.FVipData.VipLevel) as TTreeChest;
         _loc2_ = this.FTreeChestBins.GetDatebaseByValue2("TreeLv",this.FRamenData.SelfRamenLevel - this.FRamenData.SelfRamenRewardCount + 1,"VipLv",this.FVipData.VipLevel + 1) as TTreeChest;
         _loc3_ = this.GetCoin(_loc1_);
         _loc4_ = this.GetVouchers(_loc1_);
         _loc5_ = this.GetCoin(_loc2_);
         _loc6_ = this.GetVouchers(_loc2_);
         if(this.FVipData.VipLevel > 0)
         {
            this.FMC_VIP.visible = true;
            this.FMC_NotVIP.visible = false;
            this.FTF_NextVip.visible = Boolean(_loc2_ != null);
            this.FTF_NextGainSilver.visible = Boolean(_loc2_ != null);
            this.FTF_NextGainGiftCertificate.visible = Boolean(_loc2_ != null);
            this.FTF_CurVip.text = TUtilityString.Format(STRING_Ramen.STRING_VipLevel,this.FVipData.VipLevel);
            this.FTF_CurGainSilver.text = STRING_COMMON.ITEMNAME_Coin + ": " + _loc3_;
            this.FTF_CuGainGiftCertificate.text = STRING_COMMON.ITEMNAME_Vouchers + ": " + _loc4_;
            if(_loc2_ != null)
            {
               this.FTF_NextVip.text = TUtilityString.Format(STRING_Ramen.STRING_NextVipLevel,this.FVipData.VipLevel + 1);
               this.FTF_NextGainSilver.text = STRING_COMMON.ITEMNAME_Coin + ": " + _loc5_;
               this.FTF_NextGainGiftCertificate.text = STRING_COMMON.ITEMNAME_Vouchers + ": " + _loc6_;
            }
         }
         else
         {
            this.FMC_VIP.visible = false;
            this.FMC_NotVIP.visible = true;
            this.FTF_NotVipGainSilver.text = STRING_COMMON.ITEMNAME_Coin + ": " + _loc3_;
            this.FTF_NotVipGainGiftCertificate.text = STRING_COMMON.ITEMNAME_Vouchers + ": " + _loc4_;
            this.FTF_VipGainSilver.text = STRING_COMMON.ITEMNAME_Coin + ": " + _loc5_;
            this.FTF_VipGainGiftCertificate.text = STRING_COMMON.ITEMNAME_Vouchers + ": " + _loc6_;
         }
      }
      
      protected function OnGetRewards(param1:MouseEvent) : void
      {
         if(this.FGetRewards != null)
         {
            this.FGetRewards(this);
         }
         Visible = false;
      }
      
      protected function OnTurnBack(param1:MouseEvent) : void
      {
         Visible = false;
      }
      
      protected function OnRecharge(param1:MouseEvent) : void
      {
         if(this.FOnShortcutHyperlinks != null)
         {
            this.FOnShortcutHyperlinks(this,CONST_SHORTCUTS.POSITION_Avatar,CONST_SHORTCUTS.TYPE_Avatar_VIP);
         }
      }
      
      public function get OnShortcutHyperlinks() : Function
      {
         return this.FOnShortcutHyperlinks;
      }
      
      public function set OnShortcutHyperlinks(param1:Function) : void
      {
         this.FOnShortcutHyperlinks = param1;
      }
      
      public function get GetRewards() : Function
      {
         return this.FGetRewards;
      }
      
      public function set GetRewards(param1:Function) : void
      {
         this.FGetRewards = param1;
      }
      
      public function ResourcesPerformDispatch() : void
      {
         this.ResourcesPerform_Dispatch();
      }
      
      public function Show() : void
      {
         Visible = true;
         this.Update();
      }
      
      public function Hide() : void
      {
         Visible = false;
      }
   }
}

