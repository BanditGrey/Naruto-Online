package Processors.Game.Lobby.OhtsutsukiKaguya.PanelMc
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TNightPowerPrivilege;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.OhtsutsukiKaguya.CellMc.TPSixOne;
   import Processors.Game.Lobby.OhtsutsukiKaguya.Data.OhtsutsukiKaguyaData;
   import Processors.Game.Lobby.TongLing.ToolS.Tools_Help;
   import Rendering.Overlayers.OhtsutsukiKaguya.TOverOhtsutsukiKaguya;
   import Resources.Constants.CONST_OhtsutsukiKaguya;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_OhtsutsukiKaguya;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorPanelOne extends TProcessorLobbyWindow
   {
      
      public static const Six:int = 8;
      
      protected var FMC_ROOT:MovieClip = null;
      
      protected var Fcost_fream:MovieClip = null;
      
      protected var Ffree_fream:MovieClip = null;
      
      protected var FTPFreeCell:TPFreeCell = null;
      
      protected var FTPCostCell:TPCostCell = null;
      
      protected var FMC_EffectRight:MovieClip = null;
      
      protected var FMC_EffectLeft:MovieClip = null;
      
      protected var MC_ButtonPage:MovieClip = null;
      
      protected var FTF_Gold:TextField = null;
      
      protected var TF_Page:TextField = null;
      
      protected var FMC_PropPage:MovieClip = null;
      
      protected var FPropPage:TUIPage = null;
      
      protected var FPropPageIndex:int;
      
      protected var FPropTabIndex:int;
      
      protected var FPSixOne:Vector.<TPSixOne> = null;
      
      protected var FOverOhtsutsukiKaguya:TOverOhtsutsukiKaguya;
      
      protected var FOKData:OhtsutsukiKaguyaData = null;
      
      protected var FFreeBackFun:Function;
      
      protected var FCostBackFun:Function;
      
      public function TProcessorPanelOne(param1:TUIComponent)
      {
         super(param1);
         this.FPropPage = new TUIPage(this);
         this.FPropPageIndex = 0;
         this.FPropTabIndex = 0;
         this.FTPFreeCell = new TPFreeCell();
         this.FTPFreeCell.BackFun = this.FeBackFun;
         this.FTPCostCell = new TPCostCell();
         this.FTPCostCell.BackGetVipFun = this.BackGetVipFun;
         this.FPSixOne = new Vector.<TPSixOne>();
         this.FOverOhtsutsukiKaguya = new TOverOhtsutsukiKaguya(param1.Parent);
         this.FOverOhtsutsukiKaguya.visible = false;
         this.FOKData = SLogicsCore.KaguyaData;
      }
      
      protected function BackGetVipFun(param1:int) : void
      {
         if(this.FCostBackFun != null)
         {
            this.FCostBackFun(param1);
         }
      }
      
      protected function FeBackFun() : void
      {
         if(this.FFreeBackFun != null)
         {
            this.FFreeBackFun();
         }
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_OhtsutsukiKaguya.This_Resource_Id);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TPSixOne = null;
         this.FMC_ROOT = TUtilityReflection.CreateDisplayObjectInstance(CONST_OhtsutsukiKaguya.This_Panel_MC_MC_Mall) as MovieClip;
         addChild(this.FMC_ROOT);
         this.FMC_ROOT.x = (FUICore.StageWidth - this.FMC_ROOT.width) / 2;
         this.FMC_ROOT.y = (FUICore.StageHeight - this.FMC_ROOT.height) / 2;
         this.Fcost_fream = this.FMC_ROOT["cost_fream"];
         this.Ffree_fream = this.FMC_ROOT["free_fream"];
         this.FTPFreeCell.SetPanel(this.Ffree_fream);
         this.FTPCostCell.SetPanel(this.Fcost_fream);
         this.FMC_EffectRight = this.FMC_ROOT["MC_EffectRight"];
         this.FMC_EffectLeft = this.FMC_ROOT["MC_EffectLeft"];
         this.FTF_Gold = this.FMC_ROOT["TF_Gold"];
         this.FMC_PropPage = this.FMC_ROOT["MC_Page"];
         this.MC_ButtonPage = this.FMC_PropPage["MC_PageLeft"];
         this.FPropPage.ButtonPrevious.Substrate = this.MC_ButtonPage;
         this.MC_ButtonPage = this.FMC_PropPage["MC_PageRight"];
         this.FPropPage.ButtonNext.Substrate = this.MC_ButtonPage;
         this.TF_Page = this.FMC_PropPage["TF_Page"];
         this.FPropPage.LabelPage = this.TF_Page;
         this.TF_Page.text = "0/0";
         this.FPropPage.PageSize = Six;
         this.FPropPage.Init();
         this.FMC_PropPage.visible = true;
         var _loc2_:int = 0;
         while(_loc2_ < Six)
         {
            _loc1_ = new TPSixOne();
            _loc1_.SetThisPanel(this.FMC_ROOT["MC_MallItem_" + _loc2_]);
            _loc1_.Thispanel.addEventListener(MouseEvent.MOUSE_OVER,this.SixOver);
            _loc1_.Thispanel.addEventListener(MouseEvent.MOUSE_OUT,this.SixOut);
            _loc1_.Thispanel.addEventListener(MouseEvent.MOUSE_MOVE,this.SixMove);
            this.FPSixOne.push(_loc1_);
            _loc2_++;
         }
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverOhtsutsukiKaguya);
         new Tools_Help(this,this.FMC_ROOT["BTN_Help"],CONST_SYSTEMLANGUAGE.HELPTIPS_Kaguya_help,FUICore);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function SixOver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         if(this.FPSixOne[_loc3_].CurDate.IsHold)
         {
            return;
         }
         this.FOverOhtsutsukiKaguya.Context = this.FPSixOne[_loc3_].CurDate;
         this.FOverOhtsutsukiKaguya.Render(FUICore.MouseCoordinate);
         this.FOverOhtsutsukiKaguya.Show();
      }
      
      protected function SixOut(param1:MouseEvent) : void
      {
         this.FOverOhtsutsukiKaguya.Hide();
      }
      
      protected function SixMove(param1:MouseEvent) : void
      {
         this.FOverOhtsutsukiKaguya.Render(FUICore.MouseCoordinate);
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.addEventFunction();
         super.ResourcesPerform_UILocations();
      }
      
      protected function addEventFunction() : void
      {
         SimpleButton(this.FMC_ROOT["BTN_Close"]).addEventListener(MouseEvent.CLICK,this.CloseCopy);
         this.FPropPage.OnChangePage = this.HeroPageOnChange;
      }
      
      protected function CloseCopy(param1:MouseEvent) : void
      {
         Close();
      }
      
      override protected function ProcessorWindowClose() : void
      {
         if(FOnClose != null)
         {
            FOnClose(this);
         }
         this.visible = false;
      }
      
      public function SetState(param1:int) : void
      {
         this.Ffree_fream.visible = false;
         this.Fcost_fream.visible = false;
         switch(param1)
         {
            case 0:
               this.Ffree_fream.visible = true;
               this.FTPFreeCell.Update();
               break;
            case 1:
               this.Fcost_fream.visible = true;
               this.FTPCostCell.Update();
         }
         this.SetFTF_GoldValue(param1);
         this.OpenThisPanel();
      }
      
      protected function SetFTF_GoldValue(param1:int) : void
      {
         if(this.FOKData.OpenState == 0)
         {
            this.FTF_Gold.text = STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_01;
         }
         else
         {
            this.FTF_Gold.text = TUtilityString.Format(STRING_OhtsutsukiKaguya.OnePanel_Up_Dec_02,this.FOKData.CurLevel,this.FOKData.CurLevelAllExp_,this.FOKData.NextLevelAllExp,this.FOKData.CurPoint);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(!this)
         {
            return;
         }
         if(!this.visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FPSixOne.length)
         {
            this.FPSixOne[_loc1_].UpdateImage();
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FPropPageIndex = param2;
         this.FPropTabIndex = 0;
         this.FPropTabIndex += this.FPropPageIndex * Six;
         this.UpdateSixData();
      }
      
      protected function UpdatePage() : void
      {
         this.FPropPageIndex = 0;
         this.FPropTabIndex = 0;
         this.FPropPage.TotalQuantity = SLogicsCore.KaguyaData.NPowerPrivilege.Count;
         this.FPropPage.PageIndex = this.FPropPageIndex;
         this.FPropPage.Update();
      }
      
      protected function UpdateSixData() : void
      {
         var _loc4_:TNightPowerPrivilege = null;
         var _loc1_:int = 0;
         var _loc2_:TBins = SLogicsCore.KaguyaData.NPowerPrivilege;
         var _loc3_:int = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < Six)
         {
            if(this.FPropTabIndex + _loc1_ >= _loc3_)
            {
               this.FPSixOne[_loc1_].setVisible(false);
            }
            else
            {
               _loc4_ = _loc2_.GetDatebaseByIndex(this.FPropTabIndex + _loc1_) as TNightPowerPrivilege;
               this.FPSixOne[_loc1_].CurDate = _loc4_;
               this.FPSixOne[_loc1_].setVisible(true);
            }
            _loc1_++;
         }
      }
      
      public function OpenThisPanel() : void
      {
         this.FPropPageIndex = 0;
         this.FPropTabIndex = 0;
         this.UpdatePage();
         this.PlayerEffect();
         this.UpdateSixData();
      }
      
      protected function PlayerEffect() : void
      {
         this.FMC_EffectRight.play();
         this.FMC_EffectLeft.play();
      }
      
      public function set CostBackFun(param1:Function) : void
      {
         this.FCostBackFun = param1;
      }
      
      public function set FreeBackFun(param1:Function) : void
      {
         this.FFreeBackFun = param1;
      }
   }
}

