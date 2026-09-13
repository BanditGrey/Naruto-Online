package Processors.Game.Lobby.OhtsutsukiKaguya.PanelMc
{
   import Processors.Game.Lobby.OhtsutsukiKaguya.CellMc.TPThreeSell;
   import flash.display.MovieClip;
   
   public class TPCostCell
   {
      
      protected static const three:int = 3;
      
      protected var ThisPanel:MovieClip = null;
      
      protected var TPThreeSellVec:Vector.<TPThreeSell>;
      
      protected var FBackGetVipFun:Function;
      
      public function TPCostCell()
      {
         super();
         this.TPThreeSellVec = new Vector.<TPThreeSell>(three);
      }
      
      public function SetPanel(param1:MovieClip) : void
      {
         this.ThisPanel = param1;
         this.initilization();
      }
      
      public function initilization() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TPThreeSell = null;
         _loc1_ = 0;
         while(_loc1_ < three)
         {
            _loc2_ = new TPThreeSell();
            _loc2_.SetThisPanel(this.ThisPanel["childer_" + _loc1_],_loc1_);
            _loc2_.BackOpen = this.BackOpen;
            this.TPThreeSellVec[_loc1_] = _loc2_;
            _loc1_++;
         }
      }
      
      public function Update() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < three)
         {
            this.TPThreeSellVec[_loc1_].Update();
            _loc1_++;
         }
      }
      
      public function set BackGetVipFun(param1:Function) : void
      {
         this.FBackGetVipFun = param1;
      }
      
      public function get BackGetVipFun() : Function
      {
         return this.FBackGetVipFun;
      }
      
      protected function BackOpen(param1:int) : void
      {
         if(this.FBackGetVipFun != null)
         {
            this.FBackGetVipFun(param1);
         }
      }
      
      public function getThisPanel() : MovieClip
      {
         return this.ThisPanel;
      }
   }
}

