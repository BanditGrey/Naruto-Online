package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol64")]
   public dynamic class NewNPC_Dialog extends MovieClip
   {
      
      public var BtnClose:SimpleButton;
      
      public var cutOffLine:MovieClip;
      
      public var NpcPic:MovieClip;
      
      public var TalkContent:TextField;
      
      public var MC_ShowReport:MovieClip;
      
      public var ShortcutBack:MovieClip;
      
      public var NpcName:MovieClip;
      
      public function NewNPC_Dialog()
      {
         super();
      }
   }
}

