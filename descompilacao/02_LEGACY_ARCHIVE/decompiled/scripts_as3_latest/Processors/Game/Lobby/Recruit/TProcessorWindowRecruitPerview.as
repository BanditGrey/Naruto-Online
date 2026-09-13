package Processors.Game.Lobby.Recruit
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TDrawNinja;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Recruit.Component.TUIRecruitItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowRecruitPerview extends TProcessorLobbyWindow
   {
      
      protected static const PageSize:uint = 16;
      
      protected static const PaddingH:uint = 17;
      
      protected static const PaddingV:uint = 9;
      
      protected static const ColN:uint = 4;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FLargeIcon:Bitmap;
      
      protected var FRecruitItemList:Vector.<TUIRecruitItem>;
      
      protected var FPageIndex:int;
      
      protected var FBTN_prev:MovieClip;
      
      protected var FBTN_next:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FMCScene:MovieClip;
      
      protected var FCurRecruitItem:TUIRecruitItem;
      
      protected var FCurDrawNinja:TDrawNinja;
      
      protected var FFirstOpen:Boolean;
      
      protected var FDrawNinjaBins:TBins;
      
      public function TProcessorWindowRecruitPerview(param1:TUIComponent)
      {
         super(param1);
         this.FRecruitItemList = new Vector.<TUIRecruitItem>();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMCScene = TUtilityReflection.CreateDisplayObjectInstance("MC_RecruitPreview") as MovieClip;
         addChild(this.FMCScene);
         this.ConstructorRecruitItems();
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonNext.Substrate = this.FMCScene.BTN_Next;
         this.FUIPage.ButtonPrevious.Substrate = this.FMCScene.BTN_Prev;
         this.FUIPage.PageSize = PageSize;
         this.FUIPage.OnChangePage = this.OnChangePage;
         this.FUIPage.Init();
         this.FLargeIcon = new Bitmap();
         this.FMCScene.mc_spr.addChild(this.FLargeIcon);
         this.FBTN_Close = this.FMCScene.BTN_Close;
         this.FBTN_Help = this.FMCScene.BTN_Help;
         this.FDrawNinjaBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_DrawNinja);
         this.FMCScene.x = FUICore.StageWidth - this.FMCScene.width >> 1;
         this.FMCScene.y = FUICore.StageHeight - this.FMCScene.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function NotificationPerform_Show() : void
      {
         if(FIsResourcesLoadCompleted)
         {
            this.UpdateUI();
         }
         super.NotificationPerform_Show();
      }
      
      public function UpdateUI() : void
      {
         this.OnChangePage(null,this.FPageIndex);
      }
      
      protected function ConstructorRecruitItems() : void
      {
         var _loc1_:TUIRecruitItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < PageSize)
         {
            _loc1_ = new TUIRecruitItem();
            this.FRecruitItemList.push(_loc1_);
            this.FMCScene.mc_pos.addChild(_loc1_);
            _loc1_.addEventListener(MouseEvent.CLICK,this.onClickSelf);
            _loc1_.x = (_loc1_.width + PaddingH) * (_loc2_ % ColN);
            _loc1_.y = (_loc1_.height + PaddingV) * int(_loc2_ / ColN);
            _loc2_++;
         }
      }
      
      protected function UpdateRecruitList(param1:Vector.<TDrawNinja>) : void
      {
         var _loc2_:TUIRecruitItem = null;
         var _loc3_:int = 0;
         var _loc4_:TDrawNinja = null;
         _loc3_ = 0;
         while(_loc3_ < PageSize)
         {
            _loc2_ = this.FRecruitItemList[_loc3_];
            _loc4_ = param1[_loc3_];
            _loc2_.DrawNinja = _loc4_;
            if(!this.FFirstOpen)
            {
               _loc2_.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               this.FFirstOpen = true;
            }
            _loc3_++;
         }
      }
      
      protected function GetDrawNinjasByPageIndex() : Vector.<TDrawNinja>
      {
         var _loc1_:int = 0;
         var _loc2_:TDrawNinja = null;
         var _loc3_:Vector.<TDrawNinja> = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<TDrawNinja> = null;
         _loc6_ = this.GetDrawNinjasByType();
         this.FUIPage.TotalQuantity = _loc6_.length;
         this.FUIPage.Update();
         _loc3_ = new Vector.<TDrawNinja>();
         _loc4_ = this.FPageIndex * PageSize;
         _loc5_ = (this.FPageIndex + 1) * PageSize;
         _loc1_ = _loc4_;
         while(_loc1_ < _loc5_)
         {
            if(_loc1_ < _loc6_.length)
            {
               _loc2_ = _loc6_[_loc1_];
               _loc3_.push(_loc2_);
            }
            else
            {
               _loc3_.push(null);
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      protected function GetDrawNinjasByType() : Vector.<TDrawNinja>
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TDrawNinja = null;
         var _loc4_:Vector.<TDrawNinja> = null;
         _loc4_ = new Vector.<TDrawNinja>();
         _loc2_ = this.FDrawNinjaBins.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FDrawNinjaBins.GetDatebaseByIndex(_loc1_) as TDrawNinja;
            if(_loc3_.Type == TProcessorRecruit.RecruitType)
            {
               _loc4_.push(_loc3_);
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      protected function OnChangePage(param1:Object, param2:int) : void
      {
         var _loc3_:Vector.<TDrawNinja> = null;
         this.FPageIndex = param2;
         _loc3_ = this.GetDrawNinjasByPageIndex();
         this.UpdateRecruitList(_loc3_);
      }
      
      protected function onClickSelf(param1:MouseEvent) : void
      {
         var _loc2_:Array = null;
         var _loc4_:Array = null;
         var _loc3_:String = "";
         if(this.FCurRecruitItem)
         {
            this.FCurRecruitItem.AddGlowFilter(false);
         }
         this.FMCScene.TF_Attribute.text = "";
         this.FLargeIcon.bitmapData = null;
         this.FCurDrawNinja = null;
         this.FFirstOpen = false;
         if(param1 == null)
         {
            return;
         }
         this.FCurRecruitItem = param1.currentTarget as TUIRecruitItem;
         this.FCurDrawNinja = this.FCurRecruitItem.DrawNinja;
         if(Boolean(this.FCurDrawNinja) && Boolean(this.FCurDrawNinja.StarVec5))
         {
            _loc2_ = this.FCurDrawNinja.StarVec5;
            for each(_loc4_ in _loc2_)
            {
               _loc3_ += this.AttributeFormat(_loc4_[0],_loc4_[1]) + "\n";
            }
            this.FMCScene.TF_Attribute.text = _loc3_;
         }
         this.FCurRecruitItem.AddGlowFilter();
         this.FMCScene.MC_Assess.gotoAndStop(this.FCurDrawNinja.Assess);
         this.FMCScene.TF_Name.text = this.FCurDrawNinja.Name;
      }
      
      protected function AttributeFormat(param1:int, param2:Number) : String
      {
         var _loc3_:int = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1);
         var _loc4_:String = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc3_];
         if(param2 != 0)
         {
            if(param2 > 1)
            {
               return _loc4_ + " +" + param2;
            }
            return _loc4_ + " +" + (param2 * 100).toFixed(0) + "%";
         }
         return _loc4_;
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TUIRecruitItem = null;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted || !this.Visible)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < PageSize)
         {
            _loc1_ = this.FRecruitItemList[_loc2_];
            _loc1_.UpdateImage();
            _loc2_++;
         }
         if(this.FCurDrawNinja)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_Model,this.FLargeIcon,CONST_MODULES.MODULE_DrawNinaja,this.FCurDrawNinja.Ninjaid);
            this.FLargeIcon.x = -this.FLargeIcon.width / 2;
            this.FLargeIcon.y = -this.FLargeIcon.height / 2;
         }
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
         this.onClickSelf(null);
      }
   }
}

