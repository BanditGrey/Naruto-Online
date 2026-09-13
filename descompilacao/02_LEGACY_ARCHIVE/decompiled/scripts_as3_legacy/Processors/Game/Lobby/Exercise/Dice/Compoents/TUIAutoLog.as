package Processors.Game.Lobby.Exercise.Dice.Compoents
{
   import Foundation.Common.Stubs.TStubReferences;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Dice.TDice;
   import Logics.SLogicsCore;
   import flash.display.MovieClip;
   
   public class TUIAutoLog extends TUIComponent
   {
      
      protected var FMC_Result:MovieClip;
      
      protected var FDiceResult:Object;
      
      protected var FDice:TDice;
      
      protected var FStubReferences:TStubReferences;
      
      public function TUIAutoLog(param1:TUIComponent)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
         this.FDice = SLogicsCore.Dice;
         this.Initialization();
      }
      
      protected function Initialization() : void
      {
         this.FMC_Result = TUtilityReflection.CreateDisplayObjectInstance("MC_DiceLog") as MovieClip;
         addChild(this.FMC_Result);
         this.UILocations();
      }
      
      protected function UILocations() : void
      {
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get DiceResult() : Object
      {
         return this.FDiceResult;
      }
      
      public function set DiceResult(param1:Object) : void
      {
         this.FDiceResult = param1;
      }
      
      public function Update() : void
      {
         var _loc1_:String = null;
         _loc1_ = TUtilityString.Format(this.FDice.DescListNew[1],this.FDiceResult.Turn);
         _loc1_ += this.FDiceResult.Result == 1 ? this.FDice.DescListNew[2] : this.FDice.DescListNew[3];
         this.FMC_Result.TF_Result.text = _loc1_;
         _loc1_ = this.FDiceResult.BeginGold > 0 ? this.FDice.DescListNew[4] : "";
         _loc1_ += this.FDiceResult.WrongGold > 0 ? this.FDice.DescListNew[5] : "";
      }
      
      public function Release() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

