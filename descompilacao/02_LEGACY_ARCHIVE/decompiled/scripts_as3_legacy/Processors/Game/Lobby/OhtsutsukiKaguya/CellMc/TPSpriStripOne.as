package Processors.Game.Lobby.OhtsutsukiKaguya.CellMc
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TNightPowerPrivilege;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_OhtsutsukiKaguya;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class TPSpriStripOne extends Sprite
   {
      
      public static const Three:int = 6;
      
      protected var ThisPanel:MovieClip = null;
      
      protected var FPFourOne:Vector.<TPSixOne> = null;
      
      protected var CurIndex:int;
      
      protected var FIsOver:Boolean;
      
      protected var FSixOver:Function = null;
      
      protected var FSixOut:Function = null;
      
      protected var FSixMove:Function = null;
      
      protected var FSixClick:Function = null;
      
      public function TPSpriStripOne(param1:int)
      {
         super();
         this.CurIndex = param1;
         this.FPFourOne = new Vector.<TPSixOne>(Three);
         this.LoadPrimary();
         this.LoadFla();
      }
      
      protected function LoadPrimary() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_OhtsutsukiKaguya.This_Resource_Id);
      }
      
      protected function LoadFla() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TPSixOne = null;
         this.ThisPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_OhtsutsukiKaguya.This_panel_Mc_middle_wait) as MovieClip;
         this.addChild(this.ThisPanel);
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            _loc2_ = new TPSixOne();
            _loc2_.SetThisPanel(this.ThisPanel["MC_MallItem_" + _loc1_]);
            _loc2_.Thispanel.addEventListener(MouseEvent.MOUSE_OVER,this.Over);
            _loc2_.Thispanel.addEventListener(MouseEvent.MOUSE_OUT,this.Out);
            _loc2_.Thispanel.addEventListener(MouseEvent.MOUSE_MOVE,this.Move);
            _loc2_.Thispanel.addEventListener(MouseEvent.CLICK,this.Click);
            this.FPFourOne[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function UpdateImage() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FPFourOne.length)
         {
            if(this.FPFourOne[_loc1_].Thispanel.visible)
            {
               this.FPFourOne[_loc1_].UpdateImage();
            }
            _loc1_++;
         }
      }
      
      public function UpdateFourData() : void
      {
         var _loc4_:TNightPowerPrivilege = null;
         var _loc1_:int = 0;
         var _loc2_:TBins = SLogicsCore.KaguyaData.NPowerPrivilege;
         var _loc3_:int = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < Three)
         {
            if(this.CurIndex * Three + _loc1_ + 1 >= _loc3_)
            {
               this.FIsOver = true;
            }
            if(this.CurIndex * Three + _loc1_ >= _loc3_)
            {
               this.FPFourOne[_loc1_].setVisible(false);
            }
            else
            {
               _loc4_ = _loc2_.GetDatebaseByIndex(this.CurIndex * Three + _loc1_) as TNightPowerPrivilege;
               this.FPFourOne[_loc1_].CurDate = _loc4_;
               this.FPFourOne[_loc1_].setVisible(true);
            }
            _loc1_++;
         }
      }
      
      public function get IsOver() : Boolean
      {
         return this.FIsOver;
      }
      
      protected function Over(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         this.FSixOver(this.CurIndex * Three + _loc3_,this);
      }
      
      protected function Out(param1:MouseEvent) : void
      {
         this.FSixOut();
      }
      
      protected function Move(param1:MouseEvent) : void
      {
         this.FSixMove();
      }
      
      protected function Click(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(_loc2_.length - 1));
         this.FSixClick(this.CurIndex * Three + _loc3_);
      }
      
      public function set SixClick(param1:Function) : void
      {
         this.FSixClick = param1;
      }
      
      public function set SixOver(param1:Function) : void
      {
         this.FSixOver = param1;
      }
      
      public function set SixOut(param1:Function) : void
      {
         this.FSixOut = param1;
      }
      
      public function set SixMove(param1:Function) : void
      {
         this.FSixMove = param1;
      }
   }
}

