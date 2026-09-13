package Processors.Game.Lobby.CityDefend
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Timing.*;
   import Foundation.UI.*;
   import Logics.*;
   import Logics.Characters.*;
   import Logics.DatebaseVO.VO.*;
   import Processors.Game.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   
   public class TProcessorWindowResurrection extends TProcessorGame
   {
      
      protected var Bg_Sp:Shape;
      
      protected var FScene:MovieClip;
      
      protected var FCountdown:uint;
      
      protected var FIsStart:Boolean;
      
      protected var FCharacter:TCharacter;
      
      protected var FCost:uint;
      
      protected var FTime:uint;
      
      protected var FHint:THint;
      
      public var FIsAutoGoldResurgence:Boolean = false;
      
      protected var FOnEffectText:Function;
      
      protected var FHintOnOver:Function;
      
      protected var FHintOnOut:Function;
      
      protected var FShowBack:Function;
      
      protected var FOnResurrection:Function;
      
      protected var FOnTimeOver:Function;
      
      protected var FGoldlack:Function;
      
      public function TProcessorWindowResurrection(param1:TUIComponent)
      {
         super(param1);
         this.FIsStart = false;
         this.Bg_Sp = new Shape();
         this.Bg_Sp.graphics.beginFill(0,0.1);
         this.Bg_Sp.graphics.drawRect(0,0,CONST_COMMON.STAGE_Max_Width,CONST_COMMON.STAGE_Max_Height);
         this.Bg_Sp.graphics.endFill();
         addChild(this.Bg_Sp);
         this.FCharacter = SLogicsCore.Character;
         this.FTime = 10;
         this.FHint = new THint();
      }
      
      public function ResurrectionClick() : void
      {
         this.OnResurrectionClick(null);
      }
      
      protected function OnResurrectionClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = this.FCountdown - STimingCore.GetServerTick();
         if(this.FCharacter.CreditGold + this.FCharacter.CreditGiftCertificate < this.FCost * int((_loc2_ - 1) / this.FTime) + this.FCost)
         {
            if(this.FIsAutoGoldResurgence && this.FOnResurrection != null)
            {
               if(this.FGoldlack != null)
               {
                  this.FGoldlack();
               }
            }
            else if(this.FOnEffectText != null)
            {
               this.FOnEffectText(STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         if(this.FOnResurrection != null)
         {
            this.FOnResurrection(this);
         }
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(Visible)
         {
            this.LogicsPerform_Countdown();
         }
      }
      
      protected function LogicsPerform_Countdown() : void
      {
         var _loc1_:int = 0;
         if(this.FScene == null)
         {
            return;
         }
         _loc1_ = this.FCountdown - STimingCore.GetServerTick();
         this.FScene.tf_time.text = _loc1_.toString();
         if(_loc1_ <= 0)
         {
            this.ResurrectionOk();
         }
      }
      
      protected function OnHintOnOver(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         _loc2_ = this.FCountdown - STimingCore.GetServerTick();
         _loc3_ = STRING_CITYDEFEND.CITYDEFEND_FastCostTip;
         _loc3_ = _loc3_.split("%count%").join(this.FCost * int((_loc2_ - 1) / this.FTime) + this.FCost);
         this.FHint.Caption = _loc3_;
         if(this.FHintOnOver != null)
         {
            this.FHintOnOver(param1,this.FHint);
         }
      }
      
      protected function OnHintOnOut(param1:MouseEvent) : void
      {
         if(this.FHintOnOut != null)
         {
            this.FHintOnOut(this);
         }
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function get HintOnOver() : Function
      {
         return this.FHintOnOver;
      }
      
      public function set HintOnOver(param1:Function) : void
      {
         this.FHintOnOver = param1;
      }
      
      public function get HintOnOut() : Function
      {
         return this.FHintOnOut;
      }
      
      public function set HintOnOut(param1:Function) : void
      {
         this.FHintOnOut = param1;
      }
      
      public function get ShowBack() : Function
      {
         return this.FShowBack;
      }
      
      public function set ShowBack(param1:Function) : void
      {
         this.FShowBack = param1;
      }
      
      public function get OnResurrection() : Function
      {
         return this.FOnResurrection;
      }
      
      public function set OnResurrection(param1:Function) : void
      {
         this.FOnResurrection = param1;
      }
      
      public function get OnTimeOver() : Function
      {
         return this.FOnTimeOver;
      }
      
      public function set OnTimeOver(param1:Function) : void
      {
         this.FOnTimeOver = param1;
      }
      
      public function set Goldlack(param1:Function) : void
      {
         this.FGoldlack = param1;
      }
      
      public function SetScene(param1:MovieClip, param2:Boolean = true) : void
      {
         this.FScene = param1;
         addChild(this.FScene);
         if(param2)
         {
            this.FScene.btn_resurrection.addEventListener(MouseEvent.CLICK,this.OnResurrectionClick);
            this.FScene.btn_resurrection.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHintOnOver);
            this.FScene.btn_resurrection.addEventListener(MouseEvent.ROLL_OUT,this.OnHintOnOut);
            this.FScene.btn_resurrection.visible = true;
         }
         else
         {
            this.FScene.btn_resurrection.visible = false;
         }
      }
      
      public function StartCountdown(param1:uint, param2:int) : void
      {
         if(param1 - STimingCore.GetServerTick() <= 0)
         {
            return;
         }
         this.FCountdown = param1;
         this.FCost = param2;
         this.FIsStart = true;
         Visible = true;
         if(this.FShowBack != null)
         {
            this.FShowBack(this,true);
         }
      }
      
      public function ResurrectionOk() : void
      {
         this.FIsStart = false;
         Visible = false;
         if(this.FShowBack != null)
         {
            this.FShowBack(this,false);
         }
         if(this.FOnTimeOver != null)
         {
            this.FOnTimeOver(this);
         }
      }
      
      public function getBoo() : Boolean
      {
         return this.FIsStart;
      }
      
      public function Stop() : void
      {
         this.FCountdown = 0;
         this.FIsStart = false;
         Visible = false;
      }
   }
}

