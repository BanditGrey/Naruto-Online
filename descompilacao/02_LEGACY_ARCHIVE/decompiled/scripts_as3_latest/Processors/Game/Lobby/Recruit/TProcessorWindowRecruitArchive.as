package Processors.Game.Lobby.Recruit
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Recruit.TRecruit;
   import Logics.Recruit.TRecruitData;
   import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Recruit.Component.TUIRecruitItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class TProcessorWindowRecruitArchive extends TProcessorLobbyWindow
   {
      
      protected static const PageSize:uint = 16;
      
      protected static const PaddingH:uint = 17;
      
      protected static const PaddingV:uint = 9;
      
      protected static const ColN:uint = 4;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FHeroIcon:Bitmap;
      
      protected var FLargeIcon:Bitmap;
      
      protected var FRecruitItemList:Vector.<TUIRecruitItem>;
      
      protected var FPageIndex:int;
      
      protected var FRecruitData:TRecruitData;
      
      protected var FCurRecruit:TRecruit;
      
      protected var FCurRecruitItem:TUIRecruitItem;
      
      protected var FBTN_prev:MovieClip;
      
      protected var FBTN_next:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FMCScene:MovieClip;
      
      protected var FBTN_Activate:MovieClip;
      
      protected var FBTN_Upstar:MovieClip;
      
      protected var FBTN_LevelGift:MovieClip;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FConfigValue:TConfigValue;
      
      protected var FEffectGlow:TEffectBaseGlow;
      
      public var OnUpstarReq:Function;
      
      public var OnActivateReq:Function;
      
      public var OnOpenLevelGifts:Function;
      
      public function TProcessorWindowRecruitArchive(param1:TUIComponent)
      {
         super(param1);
         this.FRecruitItemList = new Vector.<TUIRecruitItem>();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMCScene = TUtilityReflection.CreateDisplayObjectInstance("MC_RecruitArchive") as MovieClip;
         addChild(this.FMCScene);
         this.FConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DrawNinja) as TConfigValue;
         this.ConstructorRecruitItems();
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonNext.Substrate = this.FMCScene.BTN_Next;
         this.FUIPage.ButtonPrevious.Substrate = this.FMCScene.BTN_Prev;
         this.FUIPage.PageSize = PageSize;
         this.FUIPage.OnChangePage = this.OnChangePage;
         this.FUIPage.Init();
         this.FUITab = new TUITab(this);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_A"],0);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_S"],1);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_SR"],2);
         this.FUITab.SetTabByIndex(this.FMCScene["mc_tab_SSR"],3);
         this.FUITab.OnSwitch = this.OnTabSwitch;
         this.FUITab.Init();
         this.FHeroIcon = new Bitmap();
         this.FMCScene.mc_head.addChild(this.FHeroIcon);
         this.FLargeIcon = new Bitmap();
         this.FMCScene.mc_spr.addChild(this.FLargeIcon);
         this.FBTN_Activate = this.FMCScene.BTN_Activate;
         TGameUtil.setButtonMode(this.FBTN_Activate,true);
         this.FBTN_Upstar = this.FMCScene.BTN_upstar;
         TGameUtil.setButtonMode(this.FBTN_Upstar,true);
         this.FBTN_LevelGift = this.FMCScene.BTN_LevelGift;
         TGameUtil.setButtonMode(this.FBTN_LevelGift,true);
         this.FBTN_Close = this.FMCScene.BTN_Close;
         this.FBTN_Help = this.FMCScene.BTN_Help;
         if(this.FEffectGlow == null)
         {
            this.FEffectGlow = new TEffectBaseGlow();
            this.FEffectGlow.SetParameters(this.FBTN_LevelGift,15911245,1);
         }
         this.FMCScene.x = FUICore.StageWidth - this.FMCScene.width >> 1;
         this.FMCScene.y = FUICore.StageHeight - this.FMCScene.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Upstar.addEventListener(MouseEvent.CLICK,this.ProcessorOnUpStar);
         this.FBTN_Activate.addEventListener(MouseEvent.CLICK,this.ProcessorOnActivate);
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FBTN_LevelGift.addEventListener(MouseEvent.CLICK,this.OnBtnLevelGiftClick);
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateUI(param1:TRecruitData) : void
      {
         this.FRecruitData = param1;
         this.OnChangePage(null,this.FPageIndex);
         this.AddActivationTotalAttribute();
         this.UpdateCurrentRecruitInfo(this.FCurRecruit,this.FCurRecruitItem);
         this.FMCScene.TF_score.text = this.FRecruitData.Score;
         this.FMCScene.TF_point.text = this.FRecruitData.Point;
      }
      
      public function UpdateEffectGlow(param1:Boolean) : void
      {
         if(param1)
         {
            this.FEffectGlow.Run();
         }
         else
         {
            this.FEffectGlow.Stop();
         }
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
            _loc1_.OnItemSelect = this.UpdateCurrentRecruitInfo;
            _loc1_.ConfigValue = this.FConfigValue;
            _loc1_.x = (_loc1_.width + PaddingH) * (_loc2_ % ColN);
            _loc1_.y = (_loc1_.height + PaddingV) * int(_loc2_ / ColN);
            _loc2_++;
         }
      }
      
      protected function UpdateRecruitList(param1:Vector.<TRecruit>) : void
      {
         var _loc2_:TUIRecruitItem = null;
         var _loc3_:int = 0;
         var _loc4_:TRecruit = null;
         _loc3_ = 0;
         while(_loc3_ < PageSize)
         {
            _loc2_ = this.FRecruitItemList[_loc3_];
            _loc4_ = param1[_loc3_];
            _loc2_.Update(_loc4_);
            if(!this.FCurRecruit)
            {
               this.FCurRecruit = _loc4_;
               this.FCurRecruitItem = _loc2_;
            }
            _loc3_++;
         }
      }
      
      protected function GetRecruitsByTabIndex() : Vector.<TRecruit>
      {
         var _loc1_:int = 0;
         var _loc2_:TRecruit = null;
         var _loc3_:Vector.<TRecruit> = null;
         var _loc4_:MovieClip = null;
         _loc3_ = new Vector.<TRecruit>();
         _loc4_ = this.FUITab.GetTabByIndex(this.FTabIndex);
         _loc1_ = 0;
         while(_loc1_ < this.FRecruitData.Size)
         {
            _loc2_ = this.FRecruitData.Recruits[_loc1_];
            if(_loc2_.DrawNinjaArchive.Assess == _loc4_.name.split("_")[2])
            {
               _loc3_.push(_loc2_);
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      protected function GetRecruitsByPageIndex() : Vector.<TRecruit>
      {
         var _loc1_:int = 0;
         var _loc2_:TRecruit = null;
         var _loc3_:Vector.<TRecruit> = null;
         var _loc4_:Vector.<TRecruit> = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = new Vector.<TRecruit>();
         _loc3_ = this.GetRecruitsByTabIndex();
         this.FUIPage.TotalQuantity = _loc3_.length;
         this.FUIPage.Update();
         _loc5_ = this.FPageIndex * PageSize;
         _loc6_ = (this.FPageIndex + 1) * PageSize;
         _loc4_ = new Vector.<TRecruit>();
         _loc1_ = _loc5_;
         while(_loc1_ < _loc6_)
         {
            if(_loc1_ < _loc3_.length)
            {
               _loc2_ = _loc3_[_loc1_];
               _loc4_.push(_loc2_);
            }
            else
            {
               _loc4_.push(null);
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      protected function AddActivationTotalAttribute() : void
      {
         var _loc1_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:Array = null;
         var _loc2_:Array = [];
         _loc1_ = this.ActivationTotalAttribute();
         _loc2_ = [];
         _loc3_ = int(_loc1_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc1_[_loc4_];
            _loc2_ = this.MergeAddAttribute(_loc2_,_loc6_);
            _loc4_++;
         }
         var _loc5_:Array = [16,17,20,21,11,101];
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            this.FMCScene["TF_Attribute_" + _loc4_].text = this.AttributeFormat(0,0);
            for each(_loc6_ in _loc2_)
            {
               if(_loc6_[0] == _loc5_[_loc4_])
               {
                  this.FMCScene["TF_Attribute_" + _loc4_].text = this.AttributeFormat(0,_loc6_[1]);
                  break;
               }
            }
            _loc4_++;
         }
      }
      
      protected function UpdateCurrentRecruitInfo(param1:TRecruit, param2:TUIRecruitItem) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc6_:Array = null;
         this.FCurRecruit = param1;
         if(this.FCurRecruit == null)
         {
            return;
         }
         if(this.FCurRecruitItem)
         {
            this.FCurRecruitItem.AddGlowFilter(false);
         }
         this.FCurRecruitItem = param2;
         this.FCurRecruitItem.AddGlowFilter();
         this.FMCScene.TF_Name.text = this.FCurRecruit.name;
         _loc3_ = param1.starNum;
         if(_loc3_ >= this.FConfigValue.Value.length)
         {
            _loc3_--;
         }
         this.FMCScene.TF_Count.text = param1.activate == 1 ? param1.count + "/" + this.FConfigValue.Value[_loc3_] : param1.count + "/1";
         var _loc5_:String = "";
         _loc4_ = param1.DrawNinjaArchive.AddAttributeVector[0];
         this.FMCScene.TF_Attribute.text = this.AttributeFormat(_loc4_[0],_loc4_[1]);
         this.FMCScene.TF_AttributeCopy.text = "";
         _loc3_ = param1.starNum;
         if(Boolean(param1.DrawNinja) && "StarVec" + _loc3_ in param1.DrawNinja)
         {
            _loc4_ = param1.DrawNinja["StarVec" + _loc3_];
            for each(_loc6_ in _loc4_)
            {
               _loc5_ += this.AttributeFormat(_loc6_[0],_loc6_[1]) + "\n";
            }
            this.FMCScene.TF_AttributeCopy.text = _loc5_;
         }
         this.FMCScene.MC_Assess.gotoAndStop(param1.DrawNinjaArchive.Assess);
         if(param1.activate == 1)
         {
            this.FBTN_Activate.visible = false;
            this.FBTN_Upstar.visible = true;
         }
         else
         {
            this.FBTN_Activate.visible = true;
            this.FBTN_Upstar.visible = false;
         }
      }
      
      protected function OnTabSwitch(param1:int) : void
      {
         this.FTabIndex = param1;
         this.OnChangePage(null,0);
         this.FUIPage.Reset();
      }
      
      protected function OnChangePage(param1:Object, param2:int) : void
      {
         var _loc3_:Vector.<TRecruit> = null;
         this.FPageIndex = param2;
         _loc3_ = this.GetRecruitsByPageIndex();
         this.UpdateRecruitList(_loc3_);
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
            _loc1_.LogicsPerform();
            _loc2_++;
         }
         if(this.FCurRecruit)
         {
            TGameUtil.ShowImageByID(TGameUtil.Type_HeadIcon,this.FHeroIcon,CONST_MODULES.MODULE_DrawNinaja,this.FCurRecruit.heroId);
            TGameUtil.ShowImageByID(TGameUtil.Type_Model,this.FLargeIcon,CONST_MODULES.MODULE_DrawNinaja,this.FCurRecruit.heroId);
            this.FLargeIcon.x = -this.FLargeIcon.width / 2;
            this.FLargeIcon.y = -this.FLargeIcon.height / 2;
         }
         if(Boolean(this.FEffectGlow) && this.FEffectGlow.IsRunOver)
         {
            this.FEffectGlow.Run();
         }
      }
      
      protected function ProcessorOnUpStar(param1:MouseEvent) : void
      {
         if(this.OnUpstarReq != null && Boolean(this.FCurRecruit))
         {
            this.OnUpstarReq(this.FCurRecruit.heroId);
         }
      }
      
      protected function ProcessorOnActivate(param1:MouseEvent) : void
      {
         if(this.OnActivateReq != null && Boolean(this.FCurRecruit))
         {
            this.OnActivateReq(this.FCurRecruit.heroId);
         }
      }
      
      protected function ActivationTotalAttribute() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TRecruit = null;
         var _loc1_:Array = [];
         _loc3_ = uint(this.FRecruitData.Size);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.FRecruitData.Recruits[_loc2_];
            if(_loc4_.activate == 1)
            {
               _loc1_.push(_loc4_.DrawNinjaArchive.AddAttributeVector[0]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      protected function AttributeFormat(param1:int, param2:Number) : String
      {
         var _loc3_:int = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1);
         var _loc4_:String = "";
         if(_loc3_ != -1)
         {
            _loc4_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc3_];
         }
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
      
      protected function MergeAddAttribute(param1:Array, param2:Array) : Array
      {
         var _loc3_:Array = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_[0] == param2[0])
            {
               _loc3_[1] += param2[1];
               return param1;
            }
         }
         param1.push([param2[0],param2[1]]);
         return param1;
      }
      
      protected function OnBtnLevelGiftClick(param1:MouseEvent) : void
      {
         if(this.OnOpenLevelGifts != null)
         {
            this.OnOpenLevelGifts();
         }
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
   }
}

