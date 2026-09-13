package Processors.Game.Lobby.BloodFete.Panel
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.BloodFete.TBloodFeteData;
   import Logics.DatebaseVO.VO.TFollowBloodBoundExchange;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.BloodFete.cell.TBloodBoundExchange;
   import Processors.Game.TProcessorGame;
   import Rendering.Overlayers.FeteBlood.TExpDecTip;
   import Resources.Constants.CONST_BLOODFETE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowBloodFeteCell extends TProcessorGame
   {
      
      protected var MainPanel:Sprite = null;
      
      protected var FCloseFunction:Function = null;
      
      protected var FeteBins:TBins;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var FTF_BloodFete_CellCount:TextField = null;
      
      protected var Fmc_list:MovieClip = null;
      
      protected var FBackFunction:Function = null;
      
      protected var FTExpDecTip:TExpDecTip = null;
      
      protected var FBloodFeteData:TBloodFeteData = null;
      
      public function TProcessorWindowBloodFeteCell(param1:TUIComponent)
      {
         super(param1);
         this.FBloodFeteData = SLogicsCore.BloodFeteDatas;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BLOODFETE.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODFETE.MC_BloodFete_Cell) as Sprite;
         this.addChild(this.MainPanel);
         this.x = (FUICore.StageWidth - this.width) / 2;
         this.y = (FUICore.StageHeight - this.height) / 2;
         this.Fmc_list = this.MainPanel["mc_list"];
         this.FTF_BloodFete_CellCount = this.MainPanel["TF_BloodFete_CellCount"];
         this.FScrollBar = new TScrollBar(this.Fmc_list,278,true,0);
         this.FScrollBar.Clear();
         this.FTExpDecTip = new TExpDecTip(this.Parent);
         this.FTExpDecTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function AddEventlistener() : void
      {
         SimpleButton(this.MainPanel[CONST_BLOODFETE.MC_Close]).addEventListener(MouseEvent.CLICK,this.CloseBtn);
         super.LogicsPerform();
      }
      
      public function LogicPerform() : void
      {
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TFollowBloodBoundExchange = null;
         var _loc3_:TBloodBoundExchange = null;
         this.AddEventlistener();
         this.FeteBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_FollowBloodBoundExchange);
         _loc1_ = 0;
         while(_loc1_ < this.FeteBins.Count)
         {
            _loc2_ = this.FeteBins.GetDatebaseByIndex(_loc1_) as TFollowBloodBoundExchange;
            _loc3_ = new TBloodBoundExchange(_loc2_);
            _loc3_.BackFunction = this.ExchangeBackFunction;
            this.FScrollBar.AddItem(_loc3_);
            _loc3_.setIndex(_loc1_ % 2);
            _loc3_.MoMo = this.MoMo;
            _loc3_.OvMo = this.OvMo;
            _loc1_++;
         }
         this.FScrollBar.ScrollToUp();
         this.UpdateView();
         super.ResourcesPerform_UILocations();
      }
      
      public function UpdateScroll() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.FScrollBar.Count)
         {
            TBloodBoundExchange(this.FScrollBar.Items[_loc1_]).UpdateIsCanClick();
            _loc1_++;
         }
      }
      
      public function MoMo(param1:TFollowBloodBoundExchange) : void
      {
         this.FTExpDecTip.Context = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Function_Cost_count,param1.Cost);
         this.FTExpDecTip.Render(FUICore.MouseCoordinate);
         this.FTExpDecTip.Show();
      }
      
      public function OvMo(param1:TFollowBloodBoundExchange) : void
      {
         this.FTExpDecTip.Hide();
      }
      
      public function UpdateView() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FTF_BloodFete_CellCount.text = String(this.FBloodFeteData.DebrisNum);
         this.UpdateScroll();
      }
      
      public function ExchangeBackFunction(param1:int) : void
      {
         if(this.FBackFunction != null)
         {
            this.FBackFunction(param1);
         }
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      protected function CloseBtn(param1:MouseEvent) : void
      {
         if(this.FCloseFunction != null)
         {
            this.FCloseFunction(2);
         }
      }
      
      public function set CloseFunction(param1:Function) : void
      {
         this.FCloseFunction = param1;
      }
      
      public function get CloseFunction() : Function
      {
         return this.FCloseFunction;
      }
   }
}

