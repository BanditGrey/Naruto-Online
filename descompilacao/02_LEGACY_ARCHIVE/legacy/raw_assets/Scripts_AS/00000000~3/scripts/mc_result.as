package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol430")]
   public dynamic class mc_result extends MovieClip
   {
      
      public var btn_right:MovieClip;
      
      public var tf_exp:TextField;
      
      public var btn_ok:MovieClip;
      
      public var mc_title:MovieClip;
      
      public var btn_copy:SimpleButton;
      
      public var btn_left:MovieClip;
      
      public var MC_UpgradeAbility_1:MovieClip;
      
      public var btn_replay:SimpleButton;
      
      public var MC_UpgradeAbility_0:MovieClip;
      
      public var MC_UpgradeAbility_2:MovieClip;
      
      public var tf_soul:TextField;
      
      public var tf_exp_Copy:TextField;
      
      public var tf_money:TextField;
      
      public function mc_result()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      internal function frame1() : *
      {
         this.btn_ok.y = 216;
         this.btn_copy.y = 220;
         this.btn_replay.y = 220;
         this.btn_left.visible = true;
         this.btn_right.visible = true;
         this.MC_UpgradeAbility_0.visible = true;
         this.MC_UpgradeAbility_1.visible = true;
         this.MC_UpgradeAbility_2.visible = true;
      }
      
      internal function frame2() : *
      {
         this.btn_ok.y = 102;
         this.btn_copy.y = 107;
         this.btn_replay.y = 107;
         this.btn_left.visible = false;
         this.btn_right.visible = false;
         this.MC_UpgradeAbility_0.visible = false;
         this.MC_UpgradeAbility_1.visible = false;
         this.MC_UpgradeAbility_2.visible = false;
      }
   }
}

