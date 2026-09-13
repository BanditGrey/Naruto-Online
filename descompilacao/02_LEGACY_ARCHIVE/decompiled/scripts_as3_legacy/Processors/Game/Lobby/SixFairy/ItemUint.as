package Processors.Game.Lobby.SixFairy
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class ItemUint extends Sprite
   {
      
      protected var FThisTextField:TextField;
      
      public function ItemUint()
      {
         super();
         this.FThisTextField = new TextField();
         this.FThisTextField.width = 400;
         this.FThisTextField.height = 22;
         this.FThisTextField.textColor = 10079283;
         this.addChild(this.FThisTextField);
      }
      
      public function SetString(param1:String, param2:String, param3:int = 0) : void
      {
         var _loc4_:String = "";
         if(param2 == "0" && param3 == 0)
         {
            _loc4_ = param1;
         }
         else if(!param3)
         {
            _loc4_ = _loc4_ + param1 + " " + param2;
         }
         else
         {
            _loc4_ = _loc4_ + param1 + " " + param2 + " *" + param3;
         }
         if(_loc4_ == "")
         {
            _loc4_ = "出问题了····";
         }
         this.FThisTextField.text = _loc4_;
      }
   }
}

