package Processors.Game.Lobby.Heros
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.TCoordinate;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.Json.TAddValue;
   import Logics.SLogicsCore;
   import Logics.Streamization.Title.TUnstreamizerTitle;
   import Logics.Title.TTitle;
   import Logics.Title.TTitles;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Heros.Components.TUITitleItem;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_TITLE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_TITLE;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowTitle extends TProcessorLobbyWindow
   {
      
      protected const CAPACITY_Tabs:uint = 2;
      
      protected const CAPACITY_TitleItems:uint = 8;
      
      protected const OFFSET:uint = 5;
      
      protected const POS_Y_Init:Number = 69;
      
      protected const UIITEM_Height:uint = 35;
      
      protected const TIME_Text_POS_X:uint = 245;
      
      protected var FBTN_Close:SimpleButton;
      
      protected var FUITab:TUITab;
      
      protected var FMC_TitleNameOuter:MovieClip;
      
      protected var FMC_TitleNameInner:MovieClip;
      
      protected var FMC_Background:MovieClip;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_GetDetail:TextField;
      
      protected var FTF_PropertyDetail:TextField;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_Equip:MovieClip;
      
      protected var FMC_Select:MovieClip;
      
      protected var FMC_TitleEffect:Sprite;
      
      protected var FUITitleItems:Vector.<TUITitleItem>;
      
      protected var FPageIndex:int;
      
      protected var FTabIndex:int;
      
      protected var FTitles:TTitles;
      
      protected var FAllTitles:TTitles;
      
      protected var FCurTitles:TTitles;
      
      protected var FTitleBmp:Bitmap;
      
      protected var FTitleAnimationID:uint;
      
      protected var FUnstreamizerTitle:TUnstreamizerTitle;
      
      protected var FEndTime:uint;
      
      protected var FTitleID:uint;
      
      protected var FModuleId:uint;
      
      protected var FOnEquipTitle:Function;
      
      public function TProcessorWindowTitle(param1:TUIComponent, param2:uint)
      {
         super(param1);
         this.FModuleId = param2;
         this.FUITab = new TUITab(this);
         this.FUITitleItems = new Vector.<TUITitleItem>();
         this.FUIPage = new TUIPage(this);
         this.FTitles = SLogicsCore.Titles;
         this.FAllTitles = new TTitles();
         this.FUnstreamizerTitle = new TUnstreamizerTitle();
         this.FTitleBmp = new Bitmap();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TITLE.RESOURCESID_Swf_Account);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:Sprite = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TUITitleItem = null;
         var _loc6_:MovieClip = null;
         var _loc7_:TextField = null;
         TGameUtil.AddWindowMask(this);
         _loc3_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_TITLE.RESOURCE_ClassName_MC_Title) as Sprite;
         addChild(_loc3_);
         _loc3_.x = CONST_COMMON.STAGE_Width - _loc3_.width >> 1;
         _loc3_.y = CONST_COMMON.STAGE_Height - _loc3_.height >> 1;
         this.FBTN_Close = _loc3_["BTN_Close"];
         this.FTF_Time = _loc3_["TF_Time"];
         this.FTF_GetDetail = _loc3_["TF_GetDetail"];
         this.FTF_PropertyDetail = _loc3_["TF_PropertyDetail"];
         this.FMC_Select = _loc3_["MC_Select"];
         this.FMC_TitleEffect = _loc3_["MC_TitleEffect"];
         this.FMC_TitleEffect.addChild(this.FTitleBmp);
         this.FMC_Equip = _loc3_["MC_Equip"];
         TGameUtil.setButtonMode(this.FMC_Equip,true);
         _loc2_ = this.CAPACITY_Tabs;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc4_ = _loc3_["MC_Tab_" + _loc1_];
            this.FUITab.SetTabByIndex(_loc4_,_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         _loc2_ = this.CAPACITY_TitleItems;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = new TUITitleItem(this);
            _loc5_.Resource = _loc3_["MC_Title_" + _loc1_];
            _loc5_.Tag = _loc1_;
            _loc5_.SelectOnClick = this.ProcessorSelectOnClick;
            _loc5_.Init();
            this.FUITitleItems[_loc1_] = _loc5_;
            _loc1_++;
         }
         _loc6_ = _loc3_["MC_PageLeft"];
         this.FUIPage.ButtonPrevious.Substrate = _loc6_;
         _loc6_ = _loc3_["MC_PageRight"];
         this.FUIPage.ButtonNext.Substrate = _loc6_;
         _loc7_ = _loc3_["TF_Page"];
         this.FUIPage.LabelPage = _loc7_;
         this.FUIPage.PageSize = this.CAPACITY_TitleItems;
         this.FUIPage.Init();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Close.addEventListener(MouseEvent.CLICK,this.ButtonCloseOnClick,false,0,true);
         this.FMC_Equip.addEventListener(MouseEvent.CLICK,this.ButtonEquipOnClick,false,0,true);
         this.FUIPage.OnChangePage = this.PageOnChange;
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateAllTitles() : void
      {
         this.FUnstreamizerTitle.UnstreamizeTitleByDatabase(null,this.FAllTitles,null);
      }
      
      override protected function LogicsPerform() : void
      {
         if(!this.Visible)
         {
            return;
         }
         if(this.FEndTime != 0)
         {
            this.FTF_Time.text = TUtilityString.Format(STRING_TITLE.FORMAT_RestTime,TGameUtil.fomatTime(this.FEndTime - STimingCore.GetServerTick()));
         }
         this.UpdateTitleEffect();
         super.LogicsPerform();
      }
      
      protected function UpdatePageInfo() : void
      {
         this.FPageIndex = 0;
         this.FUIPage.TotalQuantity = this.FCurTitles.Count;
         this.FUIPage.PageIndex = this.FPageIndex;
         this.FUIPage.Update();
      }
      
      protected function UpdateUITitleItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:TTitle = null;
         var _loc5_:TUITitleItem = null;
         _loc2_ = this.CAPACITY_TitleItems;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FUITitleItems[_loc1_];
            _loc5_.Resource.visible = false;
            _loc1_++;
         }
         _loc2_ = this.CAPACITY_TitleItems;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_ + this.FPageIndex * this.CAPACITY_TitleItems;
            if(_loc3_ >= this.FCurTitles.Count)
            {
               break;
            }
            _loc4_ = this.FCurTitles.GetTitleByIndex(_loc3_);
            _loc5_ = this.FUITitleItems[_loc1_];
            _loc5_.Resource.visible = true;
            _loc5_.Context = _loc4_;
            _loc5_.Update();
            _loc1_++;
         }
      }
      
      protected function UpdateTitleEffect() : void
      {
         var _loc1_:TCoordinate = null;
         if(this.FTitleAnimationID != 0)
         {
            _loc1_ = TGameUtil.ShowAnimationByID(TGameUtil.Type_UserTitle,this.FTitleBmp,this.FModuleId,this.FTitleAnimationID);
            this.FMC_TitleEffect.x = 184 + (212 - this.FMC_TitleEffect.width) / 2;
         }
         else
         {
            this.FTitleBmp.bitmapData = null;
         }
      }
      
      protected function UpdateRightInfo() : void
      {
         this.FTF_GetDetail.text = "";
         this.FTF_PropertyDetail.text = "";
         this.FTitleAnimationID = 0;
         this.FTF_Time.text = "";
         this.FMC_Equip.visible = false;
         this.FEndTime = 0;
      }
      
      protected function ButtonCloseOnClick(param1:MouseEvent) : void
      {
         ProcessorWindowClose();
      }
      
      protected function ButtonEquipOnClick(param1:MouseEvent) : void
      {
         if(this.FOnEquipTitle != null)
         {
            this.FOnEquipTitle(this,this.FTitleID);
         }
      }
      
      protected function PageOnChange(param1:Object, param2:int) : void
      {
         if(param2 == this.FPageIndex)
         {
            return;
         }
         this.FPageIndex = param2;
         this.FMC_Select.visible = false;
         this.UpdateUITitleItem();
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FTabIndex = param1 as int;
         this.FMC_Select.visible = false;
         this.FCurTitles = this.FTabIndex == 0 ? this.FTitles : this.FAllTitles;
         this.UpdateRightInfo();
         this.UpdatePageInfo();
         this.UpdateUITitleItem();
      }
      
      protected function ProcessorSelectOnClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TTitle = null;
         var _loc4_:Vector.<uint> = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc8_:TAddValue = null;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         if(param2 is TTitle)
         {
            _loc3_ = param2 as TTitle;
            this.FMC_Select.y = this.POS_Y_Init + this.UIITEM_Height * param1.Tag - this.OFFSET;
            this.FMC_Select.visible = true;
            _loc5_ = "";
            _loc7_ = _loc3_.AddValues.length;
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc3_.AddValues[_loc6_];
               _loc9_ = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc8_.AddType);
               if(_loc9_ > -1)
               {
                  if(_loc8_.AddValue >= 1)
                  {
                     _loc5_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc9_] + "+" + _loc8_.AddValue + "\n";
                  }
                  else
                  {
                     _loc5_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc9_] + "+" + _loc8_.AddValue * 100 + "%\n";
                  }
               }
               _loc6_++;
            }
            _loc10_ = _loc3_.TitleSource;
            _loc10_ = _loc10_.split("%n").join("\n");
            this.FTF_GetDetail.text = _loc10_;
            if(_loc5_ == "")
            {
               this.FTF_PropertyDetail.text = STRING_TITLE.STRING_Nothing;
            }
            else
            {
               this.FTF_PropertyDetail.text = _loc5_;
            }
            this.FTitleAnimationID = _loc3_.Identifier;
            this.FEndTime = _loc3_.EndTime;
            this.FTitleID = _loc3_.Identifier;
            _loc4_ = _loc3_.LastTime;
            if(this.FEndTime != 0)
            {
               this.FTF_Time.visible = true;
            }
            else
            {
               this.FTF_Time.visible = _loc3_.Type != 0;
               if(_loc3_.Type == 1)
               {
                  this.FTF_Time.text = TUtilityString.Format(STRING_TITLE.FORMAT_TitleLastTime,_loc4_[0],_loc4_[1]);
               }
               else if(_loc3_.Type == 2)
               {
                  this.FTF_Time.text = STRING_TITLE.STRING_Forever;
               }
               else if(_loc3_.Type == 3)
               {
                  this.FTF_Time.text = TUtilityString.Format(STRING_TITLE.FORMAT_EndTime,_loc4_[0],_loc4_[1],_loc4_[2]);
               }
            }
            if(this.FTabIndex == 0)
            {
               if(_loc3_.IsEquiped != 0)
               {
                  this.FMC_Equip.visible = false;
               }
               else
               {
                  this.FMC_Equip.visible = true;
               }
            }
            else
            {
               this.FMC_Equip.visible = false;
            }
         }
      }
      
      public function get OnEquipTitle() : Function
      {
         return this.FOnEquipTitle;
      }
      
      public function set OnEquipTitle(param1:Function) : void
      {
         this.FOnEquipTitle = param1;
      }
      
      public function Update() : void
      {
         this.FTitles.Sort();
         this.FUITab.TabIndex = 0;
         this.TabOnSwitch(0);
         this.FTitles.HasNewTitle = false;
      }
   }
}

