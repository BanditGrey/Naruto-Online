package Processors.Game.Lobby.Exercise.BaseActivity.Compoents
{
   import Foundation.UI.TUIComponent;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIBaseBar extends TUIComponent
   {
      
      protected static const BOX_COUNT:int = 10;
      
      protected static const INIT_ARROW_X:int = 47;
      
      public static const OPPOSITE_DIRECTION:int = 1;
      
      public static const NORMAL_DIRECTION:int = 0;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_Bar:MovieClip;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FMC_Arrow:MovieClip;
      
      protected var FMC_Effect:MovieClip;
      
      protected var FTF_CurValue:TextField;
      
      protected var FInitialized:Boolean;
      
      protected var FMaxNum:int;
      
      protected var FMinNum:int;
      
      protected var FProgress:int;
      
      protected var FArrowInitX:int;
      
      protected var FArrowText:String = "";
      
      protected var FBarDirection:int;
      
      public function TUIBaseBar(param1:TUIComponent)
      {
         super(param1);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         this.FMC_Bar = this.FMC_Scene["MC_Bar"];
         this.FMC_Arrow = this.FMC_Scene["MC_Arrow"];
         this.FTF_CurValue = this.FMC_Scene["TF_CurValue"];
         this.FMC_Effect = this.FMC_Scene["MC_Effect"];
         if(this.FMC_Effect)
         {
            this.FMC_Effect.visible = false;
         }
         this.FMC_Mask = this.FMC_Bar["MC_Mask"];
         if(this.FMC_Mask)
         {
            this.FBarMaxWidth = this.FMC_Mask.width;
         }
      }
      
      protected function UpdateBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = Number(this.FProgress / (this.FMaxNum - this.FMinNum)) * this.FBarMaxWidth;
         _loc2_ = Math.min(_loc1_,this.FBarMaxWidth);
         this.FMC_Mask.width = this.FBarMaxWidth;
         TweenUtil.to(this.FMC_Mask,1000,{"width":_loc2_});
         if(this.FMC_Arrow)
         {
            if(this.FBarDirection == NORMAL_DIRECTION)
            {
               this.FMC_Arrow.x = this.FArrowInitX + this.FMC_Mask.width;
            }
            else
            {
               this.FMC_Arrow.x = this.FArrowInitX;
               TweenUtil.to(this.FMC_Arrow,1000,{"x":this.FBarMaxWidth - _loc2_});
            }
            this.FMC_Arrow.TF_Text.text = this.FArrowText;
         }
         if(this.FMC_Scene.TF_MinValue)
         {
            this.FMC_Scene.TF_MinValue.text = this.FMinNum.toString();
         }
         if(this.FMC_Scene.TF_MaxValue)
         {
            this.FMC_Scene.TF_MaxValue.text = this.FMaxNum.toString();
         }
      }
      
      public function Perform_UIDispatch(param1:MovieClip, param2:int = 0) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
         this.FBarDirection = param2;
      }
      
      public function UpdateUI(param1:int, param2:int, param3:int) : void
      {
         this.FProgress = param1;
         this.FMinNum = param2;
         this.FMaxNum = param3;
         this.UpdateBar();
      }
      
      public function UpdateCurValue(param1:String) : void
      {
         if(this.FTF_CurValue)
         {
            this.FTF_CurValue.text = param1;
         }
      }
      
      public function IsEffectPlay(param1:Boolean) : void
      {
         if(this.FMC_Effect)
         {
            this.FMC_Effect.visible = param1;
            if(param1)
            {
               this.FMC_Effect.play();
            }
            else
            {
               this.FMC_Effect.stop();
            }
         }
      }
      
      public function SetFArrowText(param1:String) : void
      {
         this.FArrowText = param1;
         if(this.FMC_Arrow)
         {
            this.FArrowText = this.FArrowText.split("%n").join("\n");
            this.FMC_Arrow.TF_Text.text = this.FArrowText;
         }
      }
      
      public function SetArrowVisible(param1:Boolean) : void
      {
         if(this.FMC_Arrow)
         {
            this.FMC_Arrow.visible = param1;
         }
      }
      
      public function SetVisible(param1:Boolean) : void
      {
         this.FMC_Scene.visible = param1;
      }
      
      public function get BarDirection() : int
      {
         return this.FBarDirection;
      }
      
      public function set BarDirection(param1:int) : void
      {
         this.FBarDirection = param1;
      }
   }
}

