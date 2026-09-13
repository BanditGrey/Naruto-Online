package subclass
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class FlutterWord extends Sprite
   {
      
      public function FlutterWord()
      {
         super();
         var FTextField:TextField = new TextField();
         FTextField.text = "+10";
         var format:TextFormat = new TextFormat();
         format.font = "Verdana";
         format.color = 16763904;
         format.size = 20;
         FTextField.setTextFormat(format);
         addChild(FTextField);
      }
      
      public function Start() : void
      {
         this.addEventListener(Event.ENTER_FRAME,this.HearBegin);
      }
      
      public function HearBegin(e:Event) : void
      {
         this.y -= 1;
         this.alpha -= 0.02;
         if(this.alpha <= 0)
         {
            this.removeEventListener(Event.ENTER_FRAME,this.HearBegin);
            this.parent.removeChild(this);
         }
      }
   }
}

