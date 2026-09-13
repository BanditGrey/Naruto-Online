package Processors.Game.Lobby.Smithy.Online
{
   import flash.events.TextEvent;
   import flash.text.TextField;
   
   public class TextFieldLine
   {
      
      protected var FBackFunc:Function;
      
      protected var FThistf:TextField;
      
      public function TextFieldLine()
      {
         super();
      }
      
      public function CreationThisClass(param1:TextField, param2:String, param3:String) : void
      {
         this.FThistf = param1;
         this.FThistf.addEventListener(TextEvent.LINK,this.linkHandler);
         this.FThistf.htmlText = this.createLink(param2,param3);
      }
      
      protected function createLink(param1:String, param2:String) : String
      {
         var _loc3_:String = "";
         _loc3_ += "<font color=\'#00FF00\'>";
         _loc3_ += "<u>";
         _loc3_ += "<b>";
         _loc3_ += "<a href=\'event:" + param1 + "\'>" + param2 + "</a>";
         _loc3_ += "</b>";
         _loc3_ += "</u>";
         return _loc3_ + "</font>";
      }
      
      protected function linkHandler(param1:TextEvent) : void
      {
         if(this.FBackFunc != null)
         {
            this.FBackFunc(param1.text);
         }
      }
      
      public function set BackFunc(param1:Function) : void
      {
         this.FBackFunc = param1;
      }
      
      public function get Thistf() : TextField
      {
         return this.FThistf;
      }
   }
}

