package Processors.Game.Lobby.Prerogative.Compnent
{
   import Components.Slots.TUISlot;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventory;
   import Logics.Prerogative.TPlatformPrerogative;
   import Logics.Prerogative.TPrerogativeOne;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorUIResourceTemplate;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_PREROGATIVE;
   import Resources.Strings.STRING_ACTIVITYINNER;
   import Resources.Strings.STRING_PREROGATIVE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUIVIPWelfare extends TProcessorUIResourceTemplate
   {
      
      protected var FTF_Name:TextField;
      
      protected var FMC_Get:MovieClip;
      
      protected var FMC_BecomeVIP:MovieClip;
      
      protected var FUISlots:Vector.<TUISlot>;
      
      protected var FPlatformPrerogative:TPlatformPrerogative;
      
      protected var FGetWelfareOnClick:Function;
      
      protected var FRechargeOnClick:Function;
      
      protected var FOnInventoryOver:Function;
      
      protected var FOnInventoryOut:Function;
      
      public function TUIVIPWelfare(param1:TUIComponent)
      {
         super(param1);
         this.FUISlots = new Vector.<TUISlot>(CONST_PREROGATIVE.CAPACITY_Slots);
         this.FPlatformPrerogative = SLogicsCore.PlatformPrerogative;
      }
      
      override protected function UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         this.FTF_Name = FResource["TF_Name"];
         this.FMC_Get = FResource["MC_Get"];
         this.FMC_BecomeVIP = FResource["MC_BecomeVIP"];
         _loc2_ = CONST_PREROGATIVE.CAPACITY_Slots;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = FResource["MC_Slot_" + _loc1_] as Sprite;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.Tag = _loc1_;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnOverlay = this.SlotsOnMove;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.Init();
            this.FUISlots[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      override protected function UILocations() : void
      {
         this.FMC_Get.addEventListener(MouseEvent.CLICK,this.MCGetWelfare,false,0,true);
         this.FMC_BecomeVIP.addEventListener(MouseEvent.CLICK,this.MCRechargeOnClick,false,0,true);
         super.UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(!Visible && !this.Parent.Visible)
         {
            return;
         }
         _loc2_ = CONST_PREROGATIVE.CAPACITY_Slots;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TUISlot = null;
         var _loc4_:TPrerogativeOne = null;
         var _loc5_:TInventory = null;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         if(FContext == null)
         {
            return;
         }
         _loc4_ = FContext as TPrerogativeOne;
         _loc2_ = CONST_PREROGATIVE.CAPACITY_Slots;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FUISlots[_loc1_];
            if(_loc1_ >= _loc4_.Inventories.Count)
            {
               break;
            }
            _loc5_ = _loc4_.Inventories.GetInventoryByIndex(_loc1_);
            _loc3_.Context = _loc5_;
            _loc1_++;
         }
         this.FTF_Name.text = STRING_PREROGATIVE.STRING_WelfareNames[FTag];
         _loc6_ = Boolean(this.FPlatformPrerogative.MemberLevel);
         _loc7_ = Boolean(this.FPlatformPrerogative.YearStatus);
         if(!_loc6_)
         {
            this.SetMovieClipStatus(this.FMC_Get,_loc6_);
            this.SetMovieClipStatus(this.FMC_BecomeVIP,!_loc6_);
         }
         else if(!_loc7_)
         {
            if(_loc4_.Member == 0)
            {
               _loc6_ = this.FPlatformPrerogative.CommonPayIsGet;
               this.SetMovieClipStatus(this.FMC_Get,!_loc6_);
               this.SetMovieClipStatus(this.FMC_BecomeVIP,false);
               if(_loc6_ == 0)
               {
                  this.FMC_Get["TF_Name"].text = STRING_ACTIVITYINNER.STREING_CanReward;
               }
               else
               {
                  this.FMC_Get["TF_Name"].text = STRING_ACTIVITYINNER.STREING_AlreadyReward;
               }
            }
            else if(_loc4_.Member == 1)
            {
               this.SetMovieClipStatus(this.FMC_Get,_loc7_);
               this.SetMovieClipStatus(this.FMC_BecomeVIP,true);
               if(_loc7_ == 0)
               {
                  this.FMC_Get["TF_Name"].text = STRING_ACTIVITYINNER.STREING_CanReward;
               }
               else
               {
                  this.FMC_Get["TF_Name"].text = STRING_ACTIVITYINNER.STREING_AlreadyReward;
               }
            }
         }
         else
         {
            if(_loc4_.Member == 0)
            {
               _loc6_ = this.FPlatformPrerogative.CommonPayIsGet;
            }
            else if(_loc4_.Member == 1)
            {
               _loc6_ = this.FPlatformPrerogative.YearPayIsGet;
            }
            this.SetMovieClipStatus(this.FMC_Get,!_loc6_);
            this.SetMovieClipStatus(this.FMC_BecomeVIP,false);
            if(_loc6_ == 0)
            {
               this.FMC_Get["TF_Name"].text = STRING_ACTIVITYINNER.STREING_CanReward;
            }
            else
            {
               this.FMC_Get["TF_Name"].text = STRING_ACTIVITYINNER.STREING_AlreadyReward;
            }
         }
      }
      
      protected function SetMovieClipStatus(param1:MovieClip, param2:Boolean) : void
      {
         TGameUtil.setButtonMode(param1,param2);
         param1.mouseEnabled = param2;
      }
      
      protected function MCGetWelfare(param1:MouseEvent) : void
      {
         if(this.FGetWelfareOnClick != null)
         {
            this.FGetWelfareOnClick(this,FContext);
         }
      }
      
      protected function MCRechargeOnClick(param1:MouseEvent) : void
      {
         if(this.FRechargeOnClick != null)
         {
            this.FRechargeOnClick(this);
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_Prerogative);
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      protected function SlotsOnMove(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOver != null)
         {
            this.FOnInventoryOver(param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnInventoryOut != null)
         {
            this.FOnInventoryOut(param2);
         }
      }
      
      public function set GetWelfareOnClick(param1:Function) : void
      {
         this.FGetWelfareOnClick = param1;
      }
      
      public function set RechargeOnClick(param1:Function) : void
      {
         this.FRechargeOnClick = param1;
      }
      
      public function set OnInventoryOver(param1:Function) : void
      {
         this.FOnInventoryOver = param1;
      }
      
      public function set OnInventoryOut(param1:Function) : void
      {
         this.FOnInventoryOut = param1;
      }
      
      public function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         if(!Visible && !this.Parent.Visible)
         {
            return;
         }
         _loc2_ = CONST_PREROGATIVE.CAPACITY_Slots;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FUISlots[_loc1_].Update();
            _loc1_++;
         }
      }
   }
}

