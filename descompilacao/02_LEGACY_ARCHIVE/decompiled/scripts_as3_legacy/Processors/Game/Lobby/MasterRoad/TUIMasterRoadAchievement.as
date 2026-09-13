package Processors.Game.Lobby.MasterRoad
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TMasterRoadVenue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.TBaseActivity;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_MASTERROAD;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIMasterRoadAchievement extends TUIBaseWindow
   {
      
      public static const TAB_COUNT:int = 9;
      
      protected var FMasterRoad:TMasterRoad;
      
      protected var FHelpTips:THint;
      
      public function TUIMasterRoadAchievement(param1:TUIComponent)
      {
         super(param1);
         this.FMasterRoad = SLogicsCore.MasterRoad;
         this.FHelpTips = new THint();
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
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
            _loc4_ = FMC_Scene["MC_Box" + _loc2_];
            _loc4_.MC_Icon.gotoAndStop(_loc2_ + 1);
            _loc2_++;
         }
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
      }
      
      protected function UpdateBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TMasterRoadVenue = null;
         var _loc5_:String = null;
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc3_ = FMC_Scene["MC_Box" + _loc1_];
            _loc4_ = this.FMasterRoad.VenuesData[_loc1_];
            _loc3_.TF_Medal.text = _loc4_.medal;
            _loc3_.TF_Name.text = _loc4_.name;
            _loc3_.TF_Point.text = _loc4_.CurPoint + "/" + _loc4_.allAchievePoint;
            _loc5_ = (_loc4_.CurPoint * 100 / _loc4_.allAchievePoint).toFixed(2);
            _loc3_.TF_Complete.text = _loc5_ + "%";
            if(_loc4_.ActiveTime == 0)
            {
               _loc3_.TF_Time.text = "";
            }
            else
            {
               _loc3_.TF_Time.text = TUtilityString.Format(new ConsumeFrameCopy(STRING_MASTERROAD.STRING_004).DescribeString,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(_loc4_.ActiveTime) * 1000)));
            }
            if(_loc4_.Status != TBaseActivity.STATUS_GETED)
            {
               _loc3_.filters = [TGameUtil.GaryColorFilters];
               _loc3_.MC_Got.visible = false;
            }
            else
            {
               _loc3_.filters = [];
               _loc3_.MC_Got.visible = true;
            }
            _loc1_++;
         }
      }
      
      protected function OnCloseMain(param1:MouseEvent) : void
      {
         if(FOnCloseWindow != null)
         {
            FOnCloseWindow(this);
         }
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         if(OnHelpOver != null)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170099) as TSystemLanguage;
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
         }
      }
      
      public function UpdateWindow() : void
      {
         this.UpdateBox();
      }
      
      override public function Unmount() : void
      {
      }
   }
}

