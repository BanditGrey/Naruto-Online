package Processors.Game.Lobby.Exercise.Christmas.Compoents
{
   import Foundation.UI.TUIComponent;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIChristmasBase extends TUIComponent
   {
      
      protected var FMC_Scene:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FOnBoxOver:Function;
      
      protected var FOnBoxOut:Function;
      
      protected var FOnItemOver:Function;
      
      protected var FOnItemOut:Function;
      
      protected var FOnGetBox:Function;
      
      protected var FOnBuyBox:Function;
      
      protected var FOnCollectUp:Function;
      
      protected var FOnShowTip:Function;
      
      protected var FOnHideTip:Function;
      
      protected var FOnShowHeroTip:Function;
      
      protected var FOnHideHeroTip:Function;
      
      protected var FOnShowRecruit:Function;
      
      protected var FOnLoadRank:Function;
      
      protected var FOnShowDesc:Function;
      
      protected var FOnShowThreeStr:Function;
      
      protected var FOnHideThreeStr:Function;
      
      protected var FOnLoadLog:Function;
      
      public function TUIChristmasBase(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
      }
      
      protected function ProcessorOnCollectUp(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnGetBoxUp(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnBoxOver(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnBoxOut(param1:MouseEvent) : void
      {
      }
      
      public function get OnBoxOver() : Function
      {
         return this.FOnBoxOver;
      }
      
      public function set OnBoxOver(param1:Function) : void
      {
         this.FOnBoxOver = param1;
      }
      
      public function get OnBoxOut() : Function
      {
         return this.FOnBoxOut;
      }
      
      public function set OnBoxOut(param1:Function) : void
      {
         this.FOnBoxOut = param1;
      }
      
      public function get OnGetBox() : Function
      {
         return this.FOnGetBox;
      }
      
      public function set OnGetBox(param1:Function) : void
      {
         this.FOnGetBox = param1;
      }
      
      public function get OnCollectUp() : Function
      {
         return this.FOnCollectUp;
      }
      
      public function set OnCollectUp(param1:Function) : void
      {
         this.FOnCollectUp = param1;
      }
      
      public function get OnItemOver() : Function
      {
         return this.FOnItemOver;
      }
      
      public function set OnItemOver(param1:Function) : void
      {
         this.FOnItemOver = param1;
      }
      
      public function get OnItemOut() : Function
      {
         return this.FOnItemOut;
      }
      
      public function set OnItemOut(param1:Function) : void
      {
         this.FOnItemOut = param1;
      }
      
      public function get OnShowTip() : Function
      {
         return this.FOnShowTip;
      }
      
      public function set OnShowTip(param1:Function) : void
      {
         this.FOnShowTip = param1;
      }
      
      public function get OnHideTip() : Function
      {
         return this.FOnHideTip;
      }
      
      public function set OnHideTip(param1:Function) : void
      {
         this.FOnHideTip = param1;
      }
      
      public function get OnBuyBox() : Function
      {
         return this.FOnBuyBox;
      }
      
      public function set OnBuyBox(param1:Function) : void
      {
         this.FOnBuyBox = param1;
      }
      
      public function get OnLoadRank() : Function
      {
         return this.FOnLoadRank;
      }
      
      public function set OnLoadRank(param1:Function) : void
      {
         this.FOnLoadRank = param1;
      }
      
      public function get OnShowHeroTip() : Function
      {
         return this.FOnShowHeroTip;
      }
      
      public function set OnShowHeroTip(param1:Function) : void
      {
         this.FOnShowHeroTip = param1;
      }
      
      public function get OnHideHeroTip() : Function
      {
         return this.FOnHideHeroTip;
      }
      
      public function set OnHideHeroTip(param1:Function) : void
      {
         this.FOnHideHeroTip = param1;
      }
      
      public function get OnShowRecruit() : Function
      {
         return this.FOnShowRecruit;
      }
      
      public function set OnShowRecruit(param1:Function) : void
      {
         this.FOnShowRecruit = param1;
      }
      
      public function get OnShowDesc() : Function
      {
         return this.FOnShowDesc;
      }
      
      public function set OnShowDesc(param1:Function) : void
      {
         this.FOnShowDesc = param1;
      }
      
      public function get OnShowThreeStr() : Function
      {
         return this.FOnShowThreeStr;
      }
      
      public function set OnShowThreeStr(param1:Function) : void
      {
         this.FOnShowThreeStr = param1;
      }
      
      public function get OnHideThreeStr() : Function
      {
         return this.FOnHideThreeStr;
      }
      
      public function set OnHideThreeStr(param1:Function) : void
      {
         this.FOnHideThreeStr = param1;
      }
      
      public function get OnLoadLog() : Function
      {
         return this.FOnLoadLog;
      }
      
      public function set OnLoadLog(param1:Function) : void
      {
         this.FOnLoadLog = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
      }
      
      public function UpdateUI() : void
      {
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
   }
}

