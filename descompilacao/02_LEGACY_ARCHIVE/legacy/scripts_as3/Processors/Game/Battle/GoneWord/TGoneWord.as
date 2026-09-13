package Processors.Game.Battle.GoneWord
{
   import Foundation.Common.*;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Rendering.Texts.*;
   import Resources.Constants.*;
   import flash.display.*;
   import flash.filters.*;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import ghostcat.util.easing.*;
   
   public class TGoneWord extends TUIComponent
   {
      
      public static const TYPE_NORMAL:int = 1;
      
      public static const TYPE_MASKBG:int = 2;
      
      protected var FScene:MovieClip;
      
      protected var FTextEffect:TextField;
      
      protected var FMoveStampX:Number;
      
      protected var FMoveStampY:Number;
      
      protected var FBrightness:Number;
      
      protected var FMaskFireBg:MovieClip;
      
      protected var FMaskYellowBg:MovieClip;
      
      protected var FType:int;
      
      public function TGoneWord(param1:TUIComponent)
      {
         super(param1);
         this.FScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_Text) as MovieClip;
         this.FTextEffect = this.FScene.tf_text;
         addChild(this.FTextEffect);
         this.FMaskFireBg = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_GoneWordBg) as MovieClip;
         this.FMaskYellowBg = TUtilityReflection.CreateDisplayObjectInstance(CONST_BATTLE.RESOURCE_ClassName_GoneWordYellowBg) as MovieClip;
         this.FMaskFireBg.cacheAsBitmap = true;
         this.FMaskYellowBg.cacheAsBitmap = true;
         addChild(this.FMaskFireBg);
         addChild(this.FMaskYellowBg);
         this.FMaskFireBg.visible = false;
         this.FMaskYellowBg.visible = false;
         this.FMoveStampX = 0;
         this.FMoveStampY = 0;
      }
      
      protected function BigToNormal() : void
      {
         scaleX = 3;
         scaleY = 3;
         TweenUtil.to(this,250,{
            "x":this.x + this.FMoveStampX,
            "y":this.y + this.FMoveStampY,
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.BeginMove
         });
      }
      
      protected function BeginMove() : void
      {
         TweenUtil.to(this,600,{
            "x":this.x + this.FMoveStampX,
            "y":this.y + this.FMoveStampY,
            "onComplete":this.GoneWhite
         });
      }
      
      protected function GoneWhite() : void
      {
         TweenUtil.to(this,100,{
            "Brightness":100,
            "onComplete":this.EndGone
         });
      }
      
      protected function SmallToBig() : void
      {
         scaleX = 0.1;
         scaleY = 0.1;
         TweenUtil.to(this,250,{
            "x":this.x + this.FMoveStampX,
            "y":this.y + this.FMoveStampY,
            "scaleX":1,
            "scaleY":1,
            "onComplete":this.BeginStand,
            "ease":Back.easeOut
         });
      }
      
      protected function BeginStand() : void
      {
         TweenUtil.to(this,600,{"onComplete":this.AlphaHide});
      }
      
      protected function AlphaHide() : void
      {
         TweenUtil.to(this,100,{
            "alpha":0,
            "onComplete":this.EndGone
         });
      }
      
      protected function ShowWaitUp() : void
      {
         TweenUtil.to(this,1000,{"onComplete":this.AlphaUpHide});
      }
      
      protected function AlphaUpHide() : void
      {
         TweenUtil.to(this,200,{
            "alpha":0,
            "y":this.y - 50,
            "onComplete":this.EndGone
         });
      }
      
      protected function ShowWaitDown() : void
      {
         TweenUtil.to(this,1000,{"onComplete":this.AlphaDownHide});
      }
      
      protected function AlphaDownHide() : void
      {
         TweenUtil.to(this,200,{
            "alpha":0,
            "y":this.y + 50,
            "onComplete":this.EndGone
         });
      }
      
      protected function EndGone() : void
      {
         if(this.FType == TYPE_NORMAL)
         {
            TPoolEffectGoneWord.SaveGoneWord(this);
         }
         else if(this.FType == TYPE_MASKBG)
         {
            TPoolEffectGoneWord.SaveGoneWordWithBg(this);
         }
         else
         {
            TPoolEffectGoneWord.SaveGoneWord(this);
         }
      }
      
      public function get EffectWidth() : int
      {
         return this.FTextEffect.textWidth;
      }
      
      public function get EffectHeight() : int
      {
         return this.FTextEffect.textHeight;
      }
      
      public function set Brightness(param1:Number) : void
      {
         this.FBrightness = param1;
         TGameUtil.SetBrightness(this,param1);
      }
      
      public function get Brightness() : Number
      {
         return this.FBrightness;
      }
      
      public function ResetGoneWord() : void
      {
         x = 0;
         y = 0;
         scaleX = 1;
         scaleY = 1;
         this.FMoveStampX = 0;
         this.FMoveStampY = 0;
         this.Brightness = 0;
         alpha = 1;
         TweenUtil.removeTween(this);
      }
      
      public function SetGoneWord(param1:Number, param2:Number, param3:String, param4:Number = 0, param5:Number = 0, param6:uint = 20, param7:uint = 16777215, param8:uint = 0) : void
      {
         var _loc9_:TextFormat = null;
         x = param1;
         y = Math.max(param2,70);
         this.FBrightness = 0;
         this.FMoveStampX = param4;
         this.FMoveStampY = param5;
         _loc9_ = this.FTextEffect.getTextFormat();
         _loc9_.size = param6;
         _loc9_.color = param7;
         this.FTextEffect.filters = [new GlowFilter(param8,1,6,6,5)];
         this.FTextEffect.text = param3;
         this.FTextEffect.setTextFormat(_loc9_);
         this.FType = TYPE_NORMAL;
      }
      
      public function SetGoneWordWithBg(param1:Number, param2:Number, param3:String, param4:Number = 0, param5:Number = 0, param6:uint = 60) : void
      {
         var _loc7_:TextFormat = null;
         x = param1;
         y = param2;
         this.FMoveStampX = param4;
         this.FMoveStampY = param5;
         _loc7_ = this.FTextEffect.getTextFormat();
         _loc7_.size = param6;
         this.FTextEffect.text = param3;
         this.FTextEffect.cacheAsBitmap = true;
         this.FTextEffect.setTextFormat(_loc7_);
         this.FMaskFireBg.mask = this.FTextEffect;
         filters = [new GlowFilter(2887438,1,5,5,20)];
         this.FType = TYPE_MASKBG;
         this.FMaskFireBg.visible = true;
      }
      
      public function SetGoneWordWithYellowBg(param1:Number, param2:Number, param3:String, param4:uint = 40) : void
      {
         var _loc5_:TextFormat = null;
         x = param1;
         y = param2;
         _loc5_ = this.FTextEffect.getTextFormat();
         _loc5_.size = param4;
         this.FTextEffect.text = param3;
         this.FTextEffect.cacheAsBitmap = true;
         this.FTextEffect.setTextFormat(_loc5_);
         this.FMaskYellowBg.mask = this.FTextEffect;
         filters = [new GlowFilter(2887438,1,5,5,20)];
         this.FType = TYPE_MASKBG;
         this.FMaskYellowBg.visible = true;
      }
      
      public function StartFloat() : void
      {
         this.BigToNormal();
      }
      
      public function StartStand() : void
      {
         this.SmallToBig();
      }
      
      public function StartUp() : void
      {
         this.ShowWaitUp();
      }
      
      public function StartDown() : void
      {
         this.ShowWaitDown();
      }
      
      public function SaveSelf() : void
      {
         this.EndGone();
      }
   }
}

