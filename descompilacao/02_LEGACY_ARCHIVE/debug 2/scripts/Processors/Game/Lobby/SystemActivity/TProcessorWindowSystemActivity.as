package Processors.Game.Lobby.SystemActivity
{
   import Components.Slots.TUISlot;
   import Foundation.Common.THint;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.SystemActivity.TSystemActivity;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.SystemActivity.Components.TUIDateList;
   import Processors.Game.Lobby.SystemActivity.Components.TUINormalList;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_POPTIPS;
   import Resources.Constants.CONST_SYSTEMACTIVITY;
   import Resources.Strings.STRING_SYSTEMACTIVITY;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowSystemActivity extends TProcessorLobbyWindow
   {
      
      public static const REWARD_COUNT:int = 6;
      
      public static const ACTIVITY_FIGHT_PET:int = 0;
      
      public static const ACTIVITY_FIRST_ORGANIZATION:int = 1;
      
      public static const ACTIVITY_MUYE_WAR:int = 2;
      
      public static const ACTIVITY_CITY_DEFEND:int = 3;
      
      public static const INIT_X:int = 194;
      
      public static const INIT_Y:int = 300;
      
      public static const TYPE_NORMAL:int = TSystemActivity.TYPE_NORMAL;
      
      public static const TYPE_HURT:int = TSystemActivity.TYPE_HURT;
      
      public static const TYPE_POINT:int = TSystemActivity.TYPE_POINT;
      
      public static const TYPE_STATUS:int = TSystemActivity.TYPE_STATUS;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_Title:MovieClip;
      
      protected var FTF_Title:TextField;
      
      protected var FMC_Background:MovieClip;
      
      protected var FMC_Context:Sprite;
      
      protected var FMC_Text:MovieClip;
      
      protected var FMC_Detail:MovieClip;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Desc:TextField;
      
      protected var FTF_Time:TextField;
      
      protected var FBTN_Goto:SimpleButton;
      
      protected var FSlotList:Vector.<TUISlot>;
      
      protected var FInitialized:Boolean;
      
      protected var FChangeTabIndex:int;
      
      protected var FUINormalList:TUINormalList;
      
      protected var FUIDateList:TUIDateList;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnGoto:Function;
      
      public function TProcessorWindowSystemActivity(param1:TUIComponent)
      {
         super(param1);
         this.FSlotList = new Vector.<TUISlot>();
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.Resources_UIDispatchWindow();
         this.Resources_UIDispatchSlot();
      }
      
      private function Resources_UIDispatchWindow() : void
      {
         this.FMC_Title = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_TITLE];
         this.FTF_Title = this.FMC_Title[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_TITLE];
         this.FMC_Background = this.FMC_Title[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_Background];
         this.FMC_Context = this.FMC_Scene[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_Context];
         this.FMC_Text = this.FMC_Context[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_TEXT];
         this.FTF_Date = this.FMC_Text[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_DATE];
         this.FTF_Desc = this.FMC_Text[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_DESC];
         this.FTF_Time = this.FMC_Text[CONST_SYSTEMACTIVITY.RESOURCE_LINK_TF_TIME];
         this.FBTN_Goto = this.FMC_Text[CONST_SYSTEMACTIVITY.RESOURCE_LINK_BTN_GOTO];
         this.FMC_Detail = this.FMC_Context[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_Detail];
         this.FUINormalList = new TUINormalList(this);
         this.FUINormalList.Perform_UIDispatch(this.FMC_Detail[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_NormalList]);
         this.FUINormalList.X = INIT_X;
         this.FUINormalList.Y = INIT_Y;
         this.FUINormalList.Visible = false;
         this.FUIDateList = new TUIDateList(this);
         this.FUIDateList.Perform_UIDispatch(this.FMC_Detail[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_DateList]);
         this.FUIDateList.X = INIT_X;
         this.FUIDateList.Y = INIT_Y;
         this.FUIDateList.Visible = false;
      }
      
      private function Resources_UIDispatchSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUISlot = null;
         _loc1_ = 0;
         while(_loc1_ < REWARD_COUNT)
         {
            _loc3_ = new TUISlot(this);
            _loc3_.Resource = this.FMC_Detail[CONST_SYSTEMACTIVITY.RESOURCE_LINK_MC_Slot + _loc1_] as Sprite;
            _loc3_.Resource.visible = false;
            _loc3_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc3_.OnOverlay = this.SlotsOnOver;
            _loc3_.OnOut = this.SlotsOnOut;
            _loc3_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc3_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc3_.Init();
            this.FSlotList[_loc1_] = _loc3_;
            _loc1_++;
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TSystemActivity = null;
         if(this.Visible)
         {
            _loc2_ = this.FSlotList.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               if(this.FSlotList[_loc1_] != null)
               {
                  this.FSlotList[_loc1_].Update();
               }
               _loc1_++;
            }
            _loc3_ = SLogicsCore.SystemActivities.GetSystemActivityByIndex(this.FChangeTabIndex);
            this.FTF_Time.text = TGameUtil.fomatTime(_loc3_.EndTime - STimingCore.GetServerTick());
         }
         super.LogicsPerform();
      }
      
      protected function UpdateTitle() : void
      {
         var _loc1_:TSystemActivity = null;
         _loc1_ = SLogicsCore.SystemActivities.GetSystemActivityByIndex(this.FChangeTabIndex);
         if(!_loc1_)
         {
            return;
         }
         this.FTF_Title.text = _loc1_.ActivityName;
         this.FMC_Background.gotoAndStop(this.FChangeTabIndex + 1);
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:TSystemActivity = null;
         _loc1_ = SLogicsCore.SystemActivities.GetSystemActivityByIndex(this.FChangeTabIndex);
         this.FTF_Date.text = TUtilityString.Format(STRING_SYSTEMACTIVITY.FormatString_TimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc1_.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc1_.EndTime - 1) * 1000)));
         this.FTF_Desc.htmlText = _loc1_.ActivityDesc;
      }
      
      protected function UpdateSlot() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TInventory = null;
         var _loc4_:TInventories = SLogicsCore.SystemActivities.GetSystemActivityByIndex(this.FChangeTabIndex).Inventories;
         _loc2_ = this.FSlotList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(_loc1_ < _loc4_.Count)
            {
               _loc3_ = _loc4_.GetInventoryByIndex(_loc1_);
               this.FSlotList[_loc1_].Context = _loc3_;
               this.FSlotList[_loc1_].Resource.visible = true;
            }
            else
            {
               this.FSlotList[_loc1_].Resource.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateDetail() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Sprite = null;
         var _loc3_:TSystemActivity = SLogicsCore.SystemActivities.GetSystemActivityByIndex(this.FChangeTabIndex);
         if(_loc3_.ActivityType == TYPE_NORMAL)
         {
            this.FUINormalList.Visible = true;
            this.FUINormalList.Index = this.FChangeTabIndex;
            this.FUIDateList.Visible = false;
            this.FMC_Detail.TF_No1.visible = true;
            this.FMC_Detail.TF_No2.visible = true;
         }
         else
         {
            this.FUINormalList.Visible = false;
            this.FUIDateList.Visible = true;
            this.FUIDateList.Index = this.FChangeTabIndex;
            this.FMC_Detail.TF_No1.visible = false;
            this.FMC_Detail.TF_No2.visible = false;
         }
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         if(this.FBTN_Goto)
         {
            this.FBTN_Goto.addEventListener(MouseEvent.CLICK,this.ButtonGotoOnClick,false,0,true);
         }
         super.ResourcesPerform_UILocations();
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
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
      
      protected function SlotsOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1,param2);
         }
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(param1);
         }
      }
      
      protected function ButtonGotoOnClick(param1:MouseEvent) : void
      {
         if(this.FOnGoto != null)
         {
            this.FOnGoto(this,CONST_POPTIPS.POPTIP_Goto_OrganiZation);
         }
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function get OnGoto() : Function
      {
         return this.FOnGoto;
      }
      
      public function set OnGoto(param1:Function) : void
      {
         this.FOnGoto = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function ChangeTabOnSwitch(param1:int) : void
      {
         if(param1 == this.FChangeTabIndex)
         {
            return;
         }
         this.Visible = true;
         this.FChangeTabIndex = param1;
         this.UpdateUI();
      }
      
      public function UpdateUI() : void
      {
         this.UpdateTitle();
         this.UpdateText();
         this.UpdateSlot();
         this.UpdateDetail();
      }
   }
}

