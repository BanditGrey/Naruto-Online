package Processors.Game.Lobby.MasterRoad.Components
{
   import Components.ScrollBar.TScrollBar;
   import Components.Standard.TUITab;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TMasterRoadEvent;
   import Logics.DatebaseVO.VO.TMasterRoadVenue;
   import Logics.Exercise.TBaseActivity;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.MasterRoad.TProcessorMasterRoad;
   import Resources.Constants.CONST_COMMON;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_OVERLAYEREQUIPMENT;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.data.Json;
   
   public class TUIMasterRoadPalaceInfo extends TUIBaseWindow
   {
      
      public static const TAB_COUNT:int = 8;
      
      protected static const MIN_SCROLL_HEIGHT:Number = 361;
      
      protected static const ITEM_STAMP:Number = 0;
      
      protected static const SINGLE_ITEM_STAMP:Number = 74;
      
      protected static const ITEM_HEIGHT:Number = 74;
      
      protected static const STRINGS_BASEATTRIBUTENAMES:Vector.<String> = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES;
      
      protected static const BASEATTRIBUTENAMES:Vector.<uint> = CONST_COMMON.BASEATTRIBUTENAMES;
      
      protected var FMasterRoad:TMasterRoad;
      
      protected var FPalaceIndex:int;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FUIPalaceInfoList:Vector.<TUIPalaceInfo>;
      
      public function TUIMasterRoadPalaceInfo(param1:TUIComponent)
      {
         super(param1);
         this.FMasterRoad = SLogicsCore.MasterRoad;
         this.FUITab = new TUITab(this);
         this.FUIPalaceInfoList = new Vector.<TUIPalaceInfo>();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["MC_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FScrollBar = new TScrollBar(FMC_Scene["MC_List"],MIN_SCROLL_HEIGHT,false,ITEM_STAMP,SINGLE_ITEM_STAMP);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Active,true);
         FMC_Scene.BTN_Active.addEventListener(MouseEvent.CLICK,this.ProcessorOnActiveUp);
      }
      
      protected function UpdatePalace() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TMasterRoadVenue = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         _loc3_ = this.FMasterRoad.VenuesData[this.FPalaceIndex];
         FMC_Scene.MC_Pic.gotoAndStop(this.FPalaceIndex + 1);
         FMC_Scene.TF_Count.text = _loc3_.CurPoint + "/" + _loc3_.allAchievePoint;
         _loc4_ = (_loc3_.CurPoint * 100 / _loc3_.allAchievePoint).toFixed(2);
         FMC_Scene.TF_Percent.text = _loc4_ + "%";
         _loc5_ = "";
         _loc6_ = _loc3_.MedalAttribute;
         _loc1_ = 0;
         while(_loc1_ < _loc6_.length)
         {
            _loc2_ = BASEATTRIBUTENAMES.indexOf(_loc6_[_loc1_][0]);
            if(_loc6_[_loc1_][2] == 0)
            {
               _loc5_ += TUtilityString.Format(STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributes,STRINGS_BASEATTRIBUTENAMES[_loc2_],_loc6_[_loc1_][1]);
            }
            else
            {
               _loc5_ += TUtilityString.Format(STRING_OVERLAYEREQUIPMENT.FORMAT_AppendAttributesPercentage,STRINGS_BASEATTRIBUTENAMES[_loc2_],int(_loc6_[_loc1_][1] * 100).toFixed(0));
            }
            _loc1_++;
         }
         FMC_Scene.TF_AddAttribute.text = _loc5_;
         FMC_Scene.MC_Icon.gotoAndStop(this.FPalaceIndex + 1);
         if(_loc3_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.BTN_Active.visible = false;
            FMC_Scene.MC_Got.visible = true;
         }
         else if(_loc3_.CurPoint >= _loc3_.allAchievePoint)
         {
            FMC_Scene.BTN_Active.visible = true;
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Active,true);
         }
         else
         {
            FMC_Scene.BTN_Active.visible = true;
            FMC_Scene.MC_Got.visible = false;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Active,false);
         }
         this.UpdateList();
      }
      
      protected function UpdateList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TMasterRoadVenue = null;
         var _loc3_:TMasterRoadEvent = null;
         var _loc4_:TUIPalaceInfo = null;
         var _loc5_:Array = null;
         _loc2_ = this.FMasterRoad.VenuesData[this.FPalaceIndex];
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            if(_loc1_ < _loc2_.TotalType)
            {
               _loc5_ = Json.decode(_loc2_.includeFunction);
               FMC_Scene["MC_Tab" + _loc1_].visible = true;
               FMC_Scene["MC_Tab" + _loc1_].TF_Caption.text = _loc5_[_loc1_][1];
            }
            else
            {
               FMC_Scene["MC_Tab" + _loc1_].visible = false;
            }
            _loc1_++;
         }
         this.FScrollBar.Clear();
         this.FUIPalaceInfoList.length = 0;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.EventList.length)
         {
            _loc3_ = _loc2_.EventList[_loc1_];
            if(_loc3_.theFunction == this.FChangeTabIndex + 1)
            {
               _loc4_ = new TUIPalaceInfo(this);
               _loc4_.Init(_loc3_);
               _loc4_.y = _loc1_ * ITEM_HEIGHT;
               this.FUIPalaceInfoList.push(_loc4_);
               this.FScrollBar.AddItem(_loc4_);
            }
            _loc1_++;
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FChangeTabIndex = param1 as int;
         this.UpdateList();
      }
      
      protected function ProcessorOnActiveUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(FOnGetBox != null)
         {
            FOnGetBox(TProcessorMasterRoad.REQ_TYPE_ACTIVE_BADGE,this.FMasterRoad.VenuesData[this.FPalaceIndex].Identifier);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
         }
      }
      
      public function UpdateWindow(param1:int) : void
      {
         this.FPalaceIndex = param1;
         this.FChangeTabIndex = 0;
         this.FUITab.Reset();
         this.UpdatePalace();
      }
      
      override public function Unmount() : void
      {
         this.FChangeTabIndex = 0;
         this.FUITab.Reset();
      }
   }
}

