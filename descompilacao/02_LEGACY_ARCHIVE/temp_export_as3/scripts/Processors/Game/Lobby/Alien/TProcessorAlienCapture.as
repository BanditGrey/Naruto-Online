package Processors.Game.Lobby.Alien
{
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Alien.TAlien;
   import Processors.Game.Lobby.Alien.cell.AlienCell;
   import flash.display.MovieClip;
   
   public class TProcessorAlienCapture extends TUIComponent
   {
      
      private var FThisPanel:MovieClip;
      
      private var _CaptureIndex:uint;
      
      private var FClickFun:Function;
      
      private var FOverFun:Function;
      
      private var FOutFun:Function;
      
      private var alienCell:AlienCell;
      
      private var FAlienCellVec:Vector.<AlienCell>;
      
      public function TProcessorAlienCapture(param1:TUIComponent)
      {
         super(param1);
      }
      
      private function Initilization() : void
      {
         var _loc1_:int = 0;
         if(this.FAlienCellVec == null)
         {
            this.FAlienCellVec = new Vector.<AlienCell>();
            _loc1_ = 0;
            while(_loc1_ < this.FThisPanel.numChildren)
            {
               this.alienCell = new AlienCell();
               this.FAlienCellVec[_loc1_] = this.alienCell;
               this.alienCell.ClickFun = this.FClickFun;
               this.alienCell.OverFun = this.FOverFun;
               this.alienCell.OutFun = this.FOutFun;
               _loc1_++;
            }
         }
      }
      
      public function set CaptureIndex(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         this._CaptureIndex = param1;
         if(Boolean(this.FThisPanel) && Boolean(this.FThisPanel.parent))
         {
            this.FThisPanel.parent.removeChild(this.FThisPanel);
         }
         this.FThisPanel = TUtilityReflection.CreateDisplayObjectInstance("mc_alien_capture_" + param1) as MovieClip;
         addChild(this.FThisPanel);
         this.Initilization();
         _loc2_ = 0;
         while(_loc2_ < this.FThisPanel.numChildren)
         {
            _loc3_ = this.FThisPanel.getChildAt(_loc2_) as MovieClip;
            this.alienCell = this.FAlienCellVec[_loc2_] as AlienCell;
            this.alienCell.setPanel(_loc3_);
            _loc2_++;
         }
      }
      
      public function setAlienCatureInfo(param1:Vector.<TAlien>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            this.alienCell = this.FAlienCellVec[_loc2_] as AlienCell;
            this.alienCell.setCellInfo(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function set ClickFun(param1:Function) : void
      {
         this.FClickFun = param1;
      }
      
      public function set OverFun(param1:Function) : void
      {
         this.FOverFun = param1;
      }
      
      public function set OutFun(param1:Function) : void
      {
         this.FOutFun = param1;
      }
   }
}

