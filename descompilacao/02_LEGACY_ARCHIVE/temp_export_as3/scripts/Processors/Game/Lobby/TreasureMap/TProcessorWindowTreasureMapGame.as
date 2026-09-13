package Processors.Game.Lobby.TreasureMap
{
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.UI.*;
   import Logics.DatebaseVO.VO.*;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import flash.display.*;
   import flash.events.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public class TProcessorWindowTreasureMapGame extends TUIComponent
   {
      
      protected static const EventComplete:String = "gameEnd";
      
      protected static const Min_Frame:uint = 45;
      
      protected static const Max_Frame:uint = 50;
      
      protected var FScene:MovieClip;
      
      protected var FIsStart:Boolean;
      
      protected var FIsPlayEnd:Boolean;
      
      protected var FIsWin:Boolean;
      
      protected var FGameWinTime:uint;
      
      protected var FOnEffectText:Function;
      
      protected var FStartMovie:Function;
      
      public function TProcessorWindowTreasureMapGame(param1:TUIComponent, param2:MovieClip)
      {
         var _loc3_:TConfigValue = null;
         super(param1);
         this.FScene = param2;
         this.FScene.gotoAndStop(1);
         this.FScene.addEventListener(EventComplete,this.OnMovieEnd);
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.OnStartDig);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TreasureMap_ColdTime) as TConfigValue;
         this.FGameWinTime = int(_loc3_.Value);
         this.FScene.mc_gameWinMovie.visible = false;
         this.FScene.mc_gameLoseMovie.visible = false;
      }
      
      protected function OnMovieEnd(param1:Event = null) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.FIsStart && !this.FIsPlayEnd)
         {
            if(this.FOnEffectText != null)
            {
               this.FOnEffectText(STRING_TREASUREMAP.STRING_GameLost);
            }
            this.FIsPlayEnd = true;
         }
         if(this.FIsWin)
         {
            this.FScene.mc_gameWinMovie.visible = true;
            this.FScene.mc_gameWinMovie.gotoAndPlay(1);
         }
         else
         {
            this.FScene.mc_gameLoseMovie.visible = true;
            this.FScene.mc_gameLoseMovie.gotoAndPlay(1);
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TreasureMap_StartReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeByte(this.FIsWin ? 1 : 0);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         setTimeout(this.OnClose,2000);
      }
      
      protected function OnStartDig(param1:KeyboardEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         var _loc4_:String = null;
         if(!this.Visible || param1.keyCode != Keyboard.SPACE)
         {
            return;
         }
         if(!this.FIsStart)
         {
            this.FIsStart = true;
            this.FScene.gotoAndPlay(1);
            return;
         }
         if(this.FIsPlayEnd)
         {
            return;
         }
         if(this.FScene.currentFrame >= Min_Frame && this.FScene.currentFrame <= Max_Frame)
         {
            this.FIsWin = true;
            _loc4_ = STRING_TREASUREMAP.STRING_GameWin;
            _loc4_ = _loc4_.split("%count%").join(this.FGameWinTime / 60);
         }
         else
         {
            this.FIsWin = false;
            _loc4_ = STRING_TREASUREMAP.STRING_GameLost;
         }
         if(this.FOnEffectText != null)
         {
            this.FOnEffectText(_loc4_);
         }
         this.FIsPlayEnd = true;
         this.FScene.stop();
         this.OnMovieEnd();
      }
      
      protected function OnClose() : void
      {
         this.Visible = false;
         this.FScene.mc_gameWinMovie.visible = false;
         this.FScene.mc_gameLoseMovie.visible = false;
         this.FScene.mc_tip.mc_space.stop();
         if(this.FStartMovie != null)
         {
            this.FStartMovie(this);
         }
      }
      
      override public function get Visible() : Boolean
      {
         if(this.FScene == null)
         {
            return false;
         }
         return this.FScene.visible;
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         if(this.FScene == null)
         {
            return;
         }
         this.FScene.visible = param1;
      }
      
      public function get OnEffectText() : Function
      {
         return this.FOnEffectText;
      }
      
      public function set OnEffectText(param1:Function) : void
      {
         this.FOnEffectText = param1;
      }
      
      public function get StartMovie() : Function
      {
         return this.FStartMovie;
      }
      
      public function set StartMovie(param1:Function) : void
      {
         this.FStartMovie = param1;
      }
      
      public function OpenGame() : void
      {
         this.Visible = true;
         this.FIsStart = false;
         this.FIsPlayEnd = false;
         this.FScene.mc_tip.mc_space.play();
         this.FScene.gotoAndStop(1);
      }
   }
}

