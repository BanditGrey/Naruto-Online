package Processors.Game.Lobby.Prerogative.Compnent
{
   import Components.ScrollBar.TScrollBar;
   import Externals.SExternalCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Prerogative.TPlatformPrerogative;
   import Logics.Prerogative.TPrerogativeOne;
   import Logics.Prerogative.TPrerogativeOnes;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseBox;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Resources.Constants.CONST_ACTIVITYINNER;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TUIBaiduActive2 extends TUIBaseWindow
   {
      
      protected static const MIN_SCROLL_HEIGHT:Number = 181;
      
      protected static const ITEM_STAMP:Number = 5;
      
      protected static const SINGLE_ITEM_STAMP:Number = 375;
      
      protected static const ITEM_HEIGHT:Number = 70;
      
      protected var FMC_List:MovieClip;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FMC_Reward:MovieClip;
      
      protected var FLevelList:Vector.<DisplayObject>;
      
      protected var FYearReward:TUIBaseBox;
      
      protected var FPlatformPrerogative:TPlatformPrerogative;
      
      protected var FRewardSprite:Sprite;
      
      public function TUIBaiduActive2(param1:TUIComponent)
      {
         super(param1);
         this.FRewardSprite = new Sprite();
         this.FPlatformPrerogative = SLogicsCore.PlatformPrerogative;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TUIBaseBox = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         super.Resources_UIDispatch(param1);
         this.FMC_Reward = TUtilityReflection.CreateDisplayObjectInstance("MC_Reward") as MovieClip;
         this.FLevelList = new Vector.<DisplayObject>();
         this.FMC_List = param1[CONST_ACTIVITYINNER.RESOURCE_LINK_MC_LIST];
         this.FScrollBar = new TScrollBar(this.FMC_List,MIN_SCROLL_HEIGHT,false);
         this.FScrollBar.AddItem(this.FMC_Reward);
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc4_ = new TUIBaseBox(this,4);
            _loc4_.Perform_UIDispatch(this.FMC_Reward["MC_Level_" + _loc2_]);
            _loc4_.OnOverlay = this.SlotsOnOver;
            _loc4_.OnOut = this.SlotsOnOut;
            this.FLevelList[_loc2_] = _loc4_;
            _loc4_.OnGetBox = this.ProcessorGetWelfareOnClick;
            _loc2_++;
         }
         _loc4_ = new TUIBaseBox(this,4);
         _loc4_.Perform_UIDispatch(param1["MC_Level_6"]);
         _loc4_.OnOverlay = this.SlotsOnOver;
         _loc4_.OnOut = this.SlotsOnOut;
         this.FLevelList[6] = _loc4_;
         _loc4_.OnGetBox = this.ProcessorGetWelfareOnClick;
         TGameUtil.setButtonMode(param1.BTN_Renew,true);
         TGameUtil.setButtonMode(param1.BTN_Recharge,true);
         param1.BTN_Renew.addEventListener(MouseEvent.CLICK,this.ProcessorRenewOnClick);
         param1.BTN_Recharge.addEventListener(MouseEvent.CLICK,this.ProcessorRechargeOnClick);
         param1.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorShowDescOnClick);
         param1.BTN_Desc.buttonMode = true;
      }
      
      protected function UpdateSlotUI() : void
      {
         var _loc1_:TPrerogativeOnes = null;
         var _loc2_:TPrerogativeOne = null;
         var _loc3_:TUIVIPWelfare = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:TUIBaseBox = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         _loc1_ = SLogicsCore.PlatformPrerogative.PrerogativeOnes.GetPrerogativesByType(2);
         _loc9_ = _loc1_.Count;
         _loc5_ = 0;
         while(_loc5_ < _loc9_)
         {
            _loc6_ = this.FLevelList[_loc5_] as TUIBaseBox;
            _loc2_ = _loc1_.GetPrerogativeOneByIndex(_loc5_);
            _loc6_.UpdateUI(_loc2_.Inventories);
            _loc6_.SetMovieClipStatus("BTN_Get",false);
            _loc6_.SetNameText(_loc2_.WelfareName);
            _loc5_++;
         }
         _loc7_ = Boolean(this.FPlatformPrerogative.MemberLevel);
         _loc8_ = Boolean(this.FPlatformPrerogative.YearStatus);
         if(_loc7_)
         {
            if(this.FPlatformPrerogative.CommonPayIsGet == 0)
            {
               _loc6_ = this.FLevelList[uint(this.FPlatformPrerogative.MemberLevel - 1)] as TUIBaseBox;
               _loc6_.SetMovieClipStatus("BTN_Get",true);
               _loc6_.SetBtnText("BTN_Get",STRING_ACTIVITYINNER.STREING_CanReward);
            }
            else if(this.FPlatformPrerogative.LastLoginMemberLevel > 0)
            {
               _loc6_ = this.FLevelList[uint(this.FPlatformPrerogative.LastLoginMemberLevel - 1)] as TUIBaseBox;
               _loc6_.SetBtnText("BTN_Get",STRING_ACTIVITYINNER.STREING_AlreadyReward);
               _loc6_.SetMovieClipStatus("BTN_Get",false);
               _loc6_.SetBtnText("BTN_Get",STRING_ACTIVITYINNER.STREING_AlreadyReward);
            }
            _loc6_.SetMCIsVisible("BTN_Renew",_loc7_);
         }
         if(!_loc8_)
         {
            _loc6_ = this.FLevelList[6] as TUIBaseBox;
            _loc6_.SetMovieClipStatus("BTN_Get",false);
            FMC_Scene.visible = true;
            FMC_Scene["BTN_Renew"].visible = false;
            FMC_Scene["BTN_Recharge"].visible = true;
            _loc6_.SetBtnText("BTN_Get",STRING_ACTIVITYINNER.STREING_CanReward);
         }
         else
         {
            _loc6_ = this.FLevelList[6] as TUIBaseBox;
            _loc6_.SetMovieClipStatus("BTN_Get",true);
            FMC_Scene["BTN_Renew"].visible = true;
            FMC_Scene["BTN_Recharge"].visible = false;
            if(this.FPlatformPrerogative.YearPayIsGet == 0)
            {
               _loc6_.SetMovieClipStatus("BTN_Get",true);
               _loc6_.SetBtnText("BTN_Get",STRING_ACTIVITYINNER.STREING_CanReward);
            }
            else
            {
               _loc6_.SetMovieClipStatus("BTN_Get",false);
               _loc6_.SetBtnText("BTN_Get",STRING_ACTIVITYINNER.STREING_AlreadyReward);
            }
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         if(FInitialized && this.visible)
         {
            _loc1_ = 0;
            while(_loc1_ < 7)
            {
               (this.FLevelList[_loc1_] as TUIBaseBox).LogicsPerform();
               _loc1_++;
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.UpdateSlotUI();
      }
      
      protected function ProcessorShowDescOnClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToUrl(this.FPlatformPrerogative.MemberDescURL);
      }
      
      protected function ProcessorRenewOnClick(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToUrl(this.FPlatformPrerogative.YearMemberURL);
      }
      
      protected function ProcessorRechargeOnClick(param1:MouseEvent) : void
      {
         var _loc2_:TPrerogativeOnes = null;
         _loc2_ = SLogicsCore.PlatformPrerogative.PrerogativeOnes.GetPrerogativesByType(2);
         SExternalCore.NavigateToUrl(this.FPlatformPrerogative.BecomeMemberURL);
         SExternalCore.TotalClicks(1);
      }
      
      protected function ProcessorGetWelfareOnClick(param1:MouseEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         var _loc4_:TPrerogativeOnes = null;
         var _loc5_:TPrerogativeOne = null;
         _loc3_ = int(String(param1.currentTarget.parent.name).slice(9));
         _loc4_ = SLogicsCore.PlatformPrerogative.PrerogativeOnes.GetPrerogativesByType(2);
         _loc5_ = _loc4_.GetPrerogativeOneByIndex(_loc3_);
         if(_loc5_.Member == 1)
         {
            _loc5_.PrivilegeLevel = 7;
         }
         _loc2_ = _loc5_;
         if(FOnGetWelfare != null)
         {
            FOnGetWelfare(this,_loc2_);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:Object) : void
      {
         if(FOnInventoryOver != null)
         {
            FOnInventoryOver(param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:Object) : void
      {
         if(FOnInventoryOut != null)
         {
            FOnInventoryOut(param2);
         }
      }
   }
}

