package Processors.Game.Lobby.Organization.TreasureTree
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Organization.TreasureTree.TUserFruitInfo;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Strings.STRING_ORGANIZATION;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIFruitTip extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_RestPickTimes:TextField;
      
      protected var FTF_PickReward:TextField;
      
      protected var FTF_FruitStatus:TextField;
      
      protected var FBTN_Fast:SimpleButton;
      
      protected var FShowTime:uint;
      
      protected var FShowMatureOrShowEvolve:Boolean;
      
      protected var FFastGrowUpOnClick:Function;
      
      public function TUIFruitTip(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         this.FTF_RestPickTimes = FResource["TF_RestPickTimes"];
         this.FTF_PickReward = FResource["TF_PickReward"];
         this.FTF_FruitStatus = FResource["TF_FruitStatus"];
         this.FBTN_Fast = FResource["BTN_Fast"];
         addChild(FResource);
         FResource.x = 0;
         FResource.y = 0;
      }
      
      override protected function UILocations() : void
      {
         super.UILocations();
         this.FBTN_Fast.addEventListener(MouseEvent.CLICK,this.BTNFastClick,false,0,true);
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TUserFruitInfo = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         if(FContext == null)
         {
            this.Reset();
            return;
         }
         _loc1_ = FContext as TUserFruitInfo;
         _loc5_ = _loc1_.FruitMatureTime;
         _loc6_ = _loc1_.FruitEvolveTime;
         if(FTag < 4)
         {
            _loc2_ = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_CanPick,_loc1_.FruitName);
            if(_loc1_.FruitLevel == 5 && _loc5_ == 0)
            {
               _loc3_ = false;
            }
            else
            {
               _loc3_ = _loc5_ != 0 || _loc6_ != 0;
            }
            _loc4_ = _loc3_ ? !_loc3_ : _loc3_;
         }
         else
         {
            _loc2_ = STRING_ORGANIZATION.STRING_PickReward;
            _loc4_ = true;
         }
         this.FBTN_Fast.visible = _loc3_;
         this.FTF_RestPickTimes.visible = _loc4_;
         this.FTF_RestPickTimes.text = TUtilityString.Format(STRING_ORGANIZATION.FORMAT_OrgFruitRestPickCount,SLogicsCore.Organization.BasicTreasureTree.OrgFruitPickCount);
         this.FTF_PickReward.text = _loc2_;
         this.FShowTime = _loc6_ != 0 ? _loc6_ : _loc5_;
         this.FShowMatureOrShowEvolve = _loc6_ != 0;
         this.FTF_FruitStatus.visible = true;
      }
      
      protected function BTNFastClick(param1:MouseEvent) : void
      {
         if(this.FFastGrowUpOnClick != null)
         {
            this.FFastGrowUpOnClick(this,FContext,this.FShowMatureOrShowEvolve);
         }
      }
      
      public function set FastGrowUpOnClick(param1:Function) : void
      {
         this.FFastGrowUpOnClick = param1;
      }
      
      override public function Reset() : void
      {
         super.Reset();
         this.FBTN_Fast.visible = false;
      }
      
      public function UpdateCDTime() : void
      {
         var _loc1_:TUserFruitInfo = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         if(!this.Parent.Visible || !this.Visible)
         {
            return;
         }
         _loc1_ = FContext as TUserFruitInfo;
         if(_loc1_ != null)
         {
            _loc2_ = this.FShowTime - STimingCore.GetServerTick();
            _loc3_ = "";
            if(_loc1_.FruitLevel <= 5)
            {
               _loc3_ = TUtilityString.Format(this.FShowMatureOrShowEvolve ? (FTag == 4 ? STRING_ORGANIZATION.FORMAT_UpdateCDTime : STRING_ORGANIZATION.FORMAT_EvolveCDTime) : STRING_ORGANIZATION.FORMAT_MatureCDTime,TGameUtil.fomatTime(_loc2_));
            }
            this.FTF_FruitStatus.text = _loc3_;
            if(_loc1_.FruitLevel == 5)
            {
               if(_loc1_.FruitMatureTime != 0)
               {
                  this.FTF_FruitStatus.visible = true;
               }
               else
               {
                  this.FTF_FruitStatus.visible = false;
               }
            }
         }
      }
   }
}

