package Processors.Game.Lobby.TheWorldTree.LittlePanel
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Common.THint;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TGodtreeDrop;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TheWorldTree.BigPanel.TPViewLittlePanel;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.FeteBlood.TGoldCallBtn;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_THEWORLDTREE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TPressorWindowDrowUotReward extends TProcessorLobbyWindow
   {
      
      protected var FThisPanel:Sprite;
      
      protected var FMC_Close:SimpleButton = null;
      
      protected var FScrollBar:TScrollBar = null;
      
      protected var FTGoldCallBtn:TGoldCallBtn = null;
      
      protected var ThiNT:THint;
      
      protected var FSlotBackOverFunc:Function;
      
      protected var FSlotBackOutFunc:Function;
      
      protected var FRewardBackFun:Function;
      
      public function TPressorWindowDrowUotReward(param1:TUIComponent)
      {
         super(param1);
         this.graphics.beginFill(0,0.3);
         this.graphics.drawRect(-(FUICore.StageWidth / 2),-(FUICore.StageHeight / 2),FUICore.StageWidth * 2,FUICore.StageHeight * 2);
         this.graphics.endFill();
         this.ThiNT = new THint();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("TheWorldTree_DrowUotReward") as Sprite;
         addChild(this.FThisPanel);
         this.FThisPanel.x = (FUICore.StageWidth - this.FThisPanel.width) / 2;
         this.FThisPanel.y = (FUICore.StageHeight - this.FThisPanel.height) / 2;
         this.FMC_Close = this.FThisPanel["MC_Close"];
         this.FScrollBar = new TScrollBar(this.FThisPanel["MC_List"],270,true,0);
         this.FScrollBar.Clear();
         this.FTGoldCallBtn = new TGoldCallBtn(this.Parent);
         this.FTGoldCallBtn.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTGoldCallBtn);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:TBins = null;
         var _loc2_:int = 0;
         var _loc3_:TPViewLittlePanel = null;
         var _loc4_:TGodtreeDrop = null;
         this.FMC_Close.addEventListener(MouseEvent.CLICK,this.CloseClick);
         _loc1_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_GodtreeDro);
         _loc2_ = 0;
         while(_loc2_ < _loc1_.Count)
         {
            _loc4_ = _loc1_.GetDatebaseByIndex(_loc2_) as TGodtreeDrop;
            _loc3_ = new TPViewLittlePanel(this.Parent);
            _loc3_.SetDate(_loc4_,_loc2_);
            _loc3_.SlotBackOver = this.SlotBackOver;
            _loc3_.SlotBackOut = this.SlotBackOut;
            _loc3_.GetRewardBackFun = this.GetRewardBackFun;
            _loc3_.BackBoxPicOver = this.BackBoxPicOver;
            _loc3_.BackBoxPicOut = this.BackBoxPicOut;
            _loc3_.BackBoxPicMove = this.BackBoxPicMove;
            this.FScrollBar.AddItem(_loc3_);
            _loc2_++;
         }
         this.FScrollBar.ScrollToUp();
         super.ResourcesPerform_UILocations();
      }
      
      protected function BackBoxPicOver(param1:TGodtreeDrop) : void
      {
         var _loc3_:TArticle = null;
         var _loc4_:int = 0;
         var _loc2_:String = "";
         _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str27).DescribeString,param1.GodtreeLevel);
         _loc4_ = 0;
         while(_loc4_ < param1.GiftsFixedAward.length)
         {
            _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1.GiftsFixedAward[_loc4_].Code) as TArticle;
            if(_loc3_)
            {
               _loc2_ += TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str28).DescribeString,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc3_.Quality],_loc3_.Name,param1.GiftsFixedAward[_loc4_].Amount);
            }
            else
            {
               _loc2_ += TUtilityString.Format(new ConsumeFrameCopy(STRING_THEWORLDTREE.str28).DescribeString,CONST_COMMON.QUALITYCOLOR_INDEX_1[0],STRING_COMMON.GetItemNameByType(param1.GiftsFixedAward[_loc4_].Type,param1.GiftsFixedAward[_loc4_].Code),param1.GiftsFixedAward[_loc4_].Amount);
            }
            _loc4_++;
         }
         this.ThiNT.Content = _loc2_;
         this.FTGoldCallBtn.Context = this.ThiNT;
         this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
         this.FTGoldCallBtn.Show();
      }
      
      public function BackBoxPicOut() : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Hide();
         }
      }
      
      public function BackBoxPicMove() : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
         }
      }
      
      public function CloseClick(param1:MouseEvent) : void
      {
         this.visible = false;
      }
      
      protected function GetRewardBackFun(param1:TGodtreeDrop) : void
      {
         if(this.FRewardBackFun != null)
         {
            this.FRewardBackFun(param1);
         }
      }
      
      protected function SlotBackOver(param1:Object, param2:Object) : void
      {
         if(this.FSlotBackOverFunc != null)
         {
            this.FSlotBackOverFunc(param1,param2);
         }
      }
      
      protected function SlotBackOut(param1:Object, param2:Object) : void
      {
         if(this.FSlotBackOutFunc != null)
         {
            this.FSlotBackOutFunc(param1,param2);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TPViewLittlePanel = null;
         if(!this)
         {
            return;
         }
         if(!this.visible)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FScrollBar.Count)
         {
            _loc2_ = this.FScrollBar.Items[_loc1_] as TPViewLittlePanel;
            _loc2_.UpdateImage();
            _loc1_++;
         }
         super.LogicsPerform();
      }
      
      public function OpenThisPanel() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TPViewLittlePanel = null;
         _loc1_ = 0;
         while(_loc1_ < this.FScrollBar.Count)
         {
            _loc2_ = this.FScrollBar.Items[_loc1_] as TPViewLittlePanel;
            _loc2_.UpdateView();
            _loc1_++;
         }
      }
      
      public function set SlotBackOverFunc(param1:Function) : void
      {
         this.FSlotBackOverFunc = param1;
      }
      
      public function set SlotBackOutFunc(param1:Function) : void
      {
         this.FSlotBackOutFunc = param1;
      }
      
      public function set RewardBackFun(param1:Function) : void
      {
         this.FRewardBackFun = param1;
      }
   }
}

