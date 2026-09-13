package Processors.Game.Lobby.MasterRoad
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Inventories.TInventories;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.MasterRoad.Components.TUIMasterRoadPalaceFight;
   import Processors.Game.Lobby.MasterRoad.Components.TUIMasterRoadPalaceInfo;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIMasterRoadPalace extends TUIBaseWindow
   {
      
      public static const TAB_COUNT:int = 2;
      
      protected var FMasterRoad:TMasterRoad;
      
      protected var FPalaceIndex:int;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIMasterRoadPalaceInfo,TUIMasterRoadPalaceFight]);
      
      protected var FHelpTips:THint;
      
      public function TUIMasterRoadPalace(param1:TUIComponent)
      {
         super(param1);
         this.FMasterRoad = SLogicsCore.MasterRoad;
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(TAB_COUNT);
         this.FUITab = new TUITab(this);
         this.FHelpTips = new THint();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:Class = null;
         super.Resources_UIDispatch(param1);
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRect(0,0,CONST_COMMON.STAGE_Width,CONST_COMMON.STAGE_Height);
         this.graphics.endFill();
         FMC_Scene = param1;
         addChild(FMC_Scene);
         FMC_Scene.x = (FUICore.StageWidth - FMC_Scene.width) / 2;
         FMC_Scene.y = (FUICore.StageHeight - FMC_Scene.height) / 2;
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            _loc5_ = this.ACTIVITY_REFERENCE[_loc2_];
            this.FUIWindowVect[_loc2_] = new _loc5_(this);
            this.FUIWindowVect[_loc2_].Perform_UIDispatch(FMC_Scene["MC_Main" + _loc2_]);
            this.FUIWindowVect[_loc2_].OnGetBox = this.ProcessorOnGetBoxClick;
            this.FUIWindowVect[_loc2_].OnBuyBox = this.ProcessorOnBuyBoxClick;
            this.FUIWindowVect[_loc2_].OnNewBoxOver = this.ProcessorOnNewBoxOver;
            this.FUIWindowVect[_loc2_].OnNewBoxOut = ProcessorOnNewBoxOut;
            this.FUIWindowVect[_loc2_].OnShowHtmlTip = this.ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc2_].OnHideHtmlTip = this.ProcessorOnHideHtmlText;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(FMC_Scene["BTN_Tab" + _loc2_],_loc2_);
            _loc2_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.btn_help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.btn_help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FChangeTabIndex = param1 as int;
         this.UpdateWindow(this.FPalaceIndex);
         if(this.FChangeTabIndex == 0)
         {
            this.FUIWindowVect[1].Unmount();
         }
         else
         {
            this.FUIWindowVect[0].Unmount();
         }
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
            this.FUIWindowVect[0].Unmount();
            this.FUIWindowVect[1].Unmount();
         }
      }
      
      protected function ProcessorOnGetBoxClick(param1:int, param2:int = 0, param3:int = 0) : void
      {
         if(FOnGetBox != null)
         {
            FOnGetBox(param1,param2,param3);
         }
      }
      
      protected function ProcessorOnBuyBoxClick(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:String = "", param6:int = 0, param7:int = 0, param8:int = 0) : void
      {
         if(FOnBuyBox != null)
         {
            FOnBuyBox(param1,param2,param3,param4,param5,param6,param7,param8);
         }
      }
      
      protected function ProcessorOnNewBoxOver(param1:TInventories, param2:String = "") : void
      {
         if(FOnNewBoxOver != null)
         {
            FOnNewBoxOver(param1);
         }
      }
      
      protected function ProcessorOnShowHtmlText(param1:String) : void
      {
         if(FOnShowHtmlTip != null)
         {
            FOnShowHtmlTip(param1);
         }
      }
      
      protected function ProcessorOnHideHtmlText() : void
      {
         if(FOnHideHtmlTip != null)
         {
            FOnHideHtmlTip();
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(OnHelpOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170098) as TSystemLanguage;
            this.FHelpTips.Content = _loc2_.Desc;
            OnHelpOver(this,this.FHelpTips);
         }
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         if(OnHelpOut != null)
         {
            OnHelpOut(this);
         }
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
         }
      }
      
      public function UpdateWindow(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         FMC_Scene.TF_Score.text = this.FMasterRoad.VenuesData[param1].CurPoint.toString();
         FMC_Scene.TF_VenueName.text = this.FMasterRoad.VenuesData[param1].name;
         this.FPalaceIndex = param1;
         if(this.FChangeTabIndex == 0)
         {
            this.FUIWindowVect[0].SetVisible(true);
            this.FUIWindowVect[1].SetVisible(false);
            (this.FUIWindowVect[0] as TUIMasterRoadPalaceInfo).UpdateWindow(this.FPalaceIndex);
         }
         else
         {
            this.FUIWindowVect[0].SetVisible(false);
            this.FUIWindowVect[1].SetVisible(true);
            (this.FUIWindowVect[1] as TUIMasterRoadPalaceFight).UpdateWindow(this.FPalaceIndex);
         }
      }
      
      override public function Unmount() : void
      {
         this.FUIWindowVect[this.FChangeTabIndex].Unmount();
      }
   }
}

