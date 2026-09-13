package Processors.Game.Lobby.BloodFete.cell
{
   import Foundation.Utilities.TUtilityString;
   import Logics.BloodFete.TBloodFeteSingle;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class TTextEffectMove extends Sprite
   {
      
      protected static const MAX_COUNT:uint = 40;
      
      protected var FTextField:TextField = null;
      
      protected var FBloodFeteSingle:TBloodFeteSingle = null;
      
      protected var FMoveCount:int;
      
      protected var FBackThis:Function = null;
      
      public function TTextEffectMove()
      {
         super();
         this.FTextField = new TextField();
         this.FTextField.autoSize = TextFieldAutoSize.LEFT;
         this.FTextField.defaultTextFormat = new TextFormat("",14,65331);
         addChild(this.FTextField);
         this.FMoveCount = 0;
      }
      
      public function set BackThis(param1:Function) : void
      {
         this.FBackThis = param1;
      }
      
      public function set Coent(param1:TBloodFeteSingle) : void
      {
         this.FBloodFeteSingle = param1;
      }
      
      public function SetPrice(param1:int) : void
      {
         this.FTextField.text = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Function_Get_Money,param1);
      }
      
      public function Updata() : Boolean
      {
         this.y -= 1.5;
         ++this.FMoveCount;
         if(this.FMoveCount >= MAX_COUNT)
         {
            this.FMoveCount = 0;
            if(this.FBackThis != null)
            {
               this.FBackThis(this);
               return false;
            }
         }
         return true;
      }
   }
}

