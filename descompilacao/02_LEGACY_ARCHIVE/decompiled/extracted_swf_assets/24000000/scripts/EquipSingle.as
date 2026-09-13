package
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol587")]
   public dynamic class EquipSingle extends MovieClip
   {
      
      public var TF_EquipLevel:TextField;
      
      public var MC_NewTip:MovieClip;
      
      public var TF_EquipName:TextField;
      
      public var Equip_slot:MovieClip;
      
      public function EquipSingle()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

