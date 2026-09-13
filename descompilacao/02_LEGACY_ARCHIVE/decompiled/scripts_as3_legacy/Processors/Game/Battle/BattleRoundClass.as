package Processors.Game.Battle
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   public class BattleRoundClass
   {
      
      protected var FRootPanel:MovieClip;
      
      protected var FNumber1:MovieClip;
      
      protected var FNumber2:MovieClip;
      
      protected var FNumber3:MovieClip;
      
      protected var FNumber4:MovieClip;
      
      protected var FQuestionMark:SimpleButton;
      
      public function BattleRoundClass(param1:MovieClip)
      {
         super();
         this.FRootPanel = param1;
      }
      
      public function initilization(param1:int = 20) : void
      {
         if(this.FRootPanel == null)
         {
            return;
         }
         this.FNumber1 = this.FRootPanel["MC_Number_0"];
         this.FNumber2 = this.FRootPanel["MC_Number_1"];
         this.FNumber3 = this.FRootPanel["MC_Number_2"];
         this.FNumber4 = this.FRootPanel["MC_Number_3"];
         this.FQuestionMark = this.FRootPanel["BTN_Help"] as SimpleButton;
         this.Reset(param1);
      }
      
      public function Reset(param1:int = 20) : void
      {
         this.SetNumber(1,param1);
      }
      
      public function get QuestionMark() : SimpleButton
      {
         return this.FQuestionMark;
      }
      
      public function SetNumber(param1:int, param2:int = 20) : void
      {
         this.FNumber3.visible = true;
         this.FNumber4.visible = true;
         this.FNumber2.visible = true;
         if(param2 == 20)
         {
            this.FNumber3.gotoAndStop(3);
            this.FNumber4.gotoAndStop(1);
         }
         else if(param2 < 10)
         {
            this.FNumber3.gotoAndStop(param2 + 1);
            this.FNumber4.visible = false;
         }
         else
         {
            this.FNumber3.gotoAndStop(int(param2 / 10) + 1);
            this.FNumber4.gotoAndStop(int(param2 % 10) + 1);
         }
         if(!param1)
         {
            param1 = 1;
         }
         if(param1 < 10)
         {
            this.FNumber1.visible = false;
            this.FNumber2.gotoAndStop(param1 + 1);
         }
         else
         {
            this.FNumber1.gotoAndStop(int(param1 / 10) + 1);
            this.FNumber2.gotoAndStop(int(param1 % 10) + 1);
            this.FNumber1.visible = true;
         }
      }
   }
}

