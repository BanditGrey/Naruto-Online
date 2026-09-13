package Processors.Game.Lobby.MasterRoad
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Logics.DatebaseVO.VO.TMasterRoadVenue;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.MasterRoad.TMasterRoad;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Rendering.Overlayers.MasterRoad.TOverlayerMasterRoadPalace;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIMasterRoadMain extends TUIBaseWindow
   {
      
      public static const TAB_COUNT:int = 9;
      
      protected var FMasterRoad:TMasterRoad;
      
      protected var FBarMaxWidth:int;
      
      protected var FOverlayerMasterRoadPalace:TOverlayerMasterRoadPalace;
      
      protected var FHelpTips:THint;
      
      public function TUIMasterRoadMain(param1:TUIComponent)
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
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         FMC_Scene = param1;
         _loc2_ = 0;
         while(_loc2_ < TAB_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Tab" + _loc2_];
            TGameUtil.setButtonMode(_loc4_,true);
            _loc4_.addEventListener(MouseEvent.CLICK,this.ProcessorOnTabUp);
            _loc4_.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTabOver);
            _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnTabOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Shop,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Achievement,true);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Temple,true);
         FMC_Scene.BTN_Shop.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowWindow);
         FMC_Scene.BTN_Achievement.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowWindow);
         FMC_Scene.BTN_Temple.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowWindow);
         FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.MC_Close.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnCloseMain);
         FMC_Scene.MC_Close.BTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.ButtonHelpOnOver);
         FMC_Scene.MC_Close.BTN_Help.addEventListener(MouseEvent.ROLL_OUT,this.ButtonHelpOnOut);
         _loc5_ = FMC_Scene.MC_Tab0.MC_Bar.MC_Bar.MC_Mask;
         this.FBarMaxWidth = _loc5_.width;
         this.FOverlayerMasterRoadPalace = new TOverlayerMasterRoadPalace(this.Parent);
         this.FOverlayerMasterRoadPalace.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerMasterRoadPalace);
      }
      
      protected function UpdateBtn() : void
      {
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
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170100) as TSystemLanguage;
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
      
      protected function ProcessorOnTabUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(FOnShowWindow != null)
         {
            FOnShowWindow(1,_loc2_);
         }
      }
      
      protected function ProcessorOnShowWindow(param1:MouseEvent) : void
      {
         switch(param1.currentTarget.name)
         {
            case "BTN_Temple":
               FOnShowWindow(TProcessorMasterRoad.UI_TYPE_TEMPLE);
               break;
            case "BTN_Achievement":
               FOnShowWindow(TProcessorMasterRoad.UI_TYPE_ACHIEVEMENT);
               break;
            case "BTN_Shop":
               FOnShowWindow(TProcessorMasterRoad.UI_TYPE_SHOP);
         }
      }
      
      protected function ProcessorOnTabOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(6));
         if(Boolean(this.FMasterRoad) && _loc2_ < this.FMasterRoad.VenuesData.length)
         {
            this.FOverlayerMasterRoadPalace.Context = this.FMasterRoad.VenuesData[_loc2_];
            this.FOverlayerMasterRoadPalace.Render(FUICore.MouseCoordinate);
            this.FOverlayerMasterRoadPalace.Show();
         }
      }
      
      protected function ProcessorOnTabOut(param1:MouseEvent) : void
      {
         this.FOverlayerMasterRoadPalace.Hide();
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible && FMC_Scene.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TMasterRoadVenue = null;
         var _loc6_:int = 0;
         FMC_Scene.TF_Count.text = this.FMasterRoad.MyScore.toString();
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc5_ = this.FMasterRoad.VenuesData[_loc1_];
            _loc4_ = FMC_Scene["MC_Tab" + _loc1_].MC_Bar.MC_Bar;
            _loc6_ = _loc5_.CurPoint * 100 / _loc5_.allAchievePoint;
            _loc4_.TF_Count.text = _loc6_ + "%";
            _loc2_ = Number(_loc5_.CurPoint / _loc5_.allAchievePoint) * this.FBarMaxWidth;
            _loc3_ = Math.min(_loc2_,this.FBarMaxWidth);
            _loc4_.MC_Mask.width = _loc3_;
            if(_loc6_ < 20)
            {
               FMC_Scene["MC_Tab" + _loc1_].MC_Star0.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star1.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star2.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star3.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star4.gotoAndStop(2);
            }
            else if(_loc6_ < 40)
            {
               FMC_Scene["MC_Tab" + _loc1_].MC_Star0.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star1.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star2.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star3.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star4.gotoAndStop(2);
            }
            else if(_loc6_ < 60)
            {
               FMC_Scene["MC_Tab" + _loc1_].MC_Star0.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star1.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star2.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star3.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star4.gotoAndStop(2);
            }
            else if(_loc6_ < 80)
            {
               FMC_Scene["MC_Tab" + _loc1_].MC_Star0.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star1.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star2.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star3.gotoAndStop(2);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star4.gotoAndStop(2);
            }
            else if(_loc6_ < 100)
            {
               FMC_Scene["MC_Tab" + _loc1_].MC_Star0.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star1.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star2.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star3.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star4.gotoAndStop(2);
            }
            else
            {
               FMC_Scene["MC_Tab" + _loc1_].MC_Star0.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star1.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star2.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star3.gotoAndStop(1);
               FMC_Scene["MC_Tab" + _loc1_].MC_Star4.gotoAndStop(1);
            }
            _loc1_++;
         }
      }
      
      override public function Unmount() : void
      {
      }
   }
}

