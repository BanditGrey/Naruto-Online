package Processors.Game.Battle
{
   import Foundation.UI.TUIComponent;
   
   public class TPoolBattleStages
   {
      
      protected var FPoolBattleStage:Vector.<TBattleStage>;
      
      public function TPoolBattleStages()
      {
         super();
         this.InitTPoolBattleStages();
      }
      
      protected function InitTPoolBattleStages() : void
      {
         this.FPoolBattleStage = new Vector.<TBattleStage>();
      }
      
      public function GetBattleStage(param1:TUIComponent) : TBattleStage
      {
         var _loc2_:TBattleStage = null;
         if(this.FPoolBattleStage.length > 0)
         {
            _loc2_ = this.FPoolBattleStage.pop();
         }
         if(_loc2_ == null)
         {
            _loc2_ = new TBattleStage(param1);
         }
         if(param1 != null)
         {
            param1.addChild(_loc2_);
         }
         return _loc2_;
      }
      
      public function SaveBattleStage(param1:TBattleStage) : void
      {
         if(param1 != null)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
            param1.Reset();
            this.FPoolBattleStage.push(param1);
         }
      }
   }
}

