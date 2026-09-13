package Processors.Game.Lobby.Homeland.Panel
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Homeland.THomelandModel;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import Processors.Game.Lobby.Married.TMarriedModel;
   import Resources.Constants.CONST_NETWORK;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUILandInfo
   {
      
      protected var FPx:int = 0;
      
      protected var FDrag:Boolean = false;
      
      protected var FMC_Scene:MovieClip;
      
      protected var Countdowns:Array;
      
      public var EffectGenerateTextByErrorCode:Function;
      
      public function TUILandInfo(param1:MovieClip)
      {
         var _loc3_:MovieClip = null;
         super();
         this.FMC_Scene = param1;
         this.FMC_Scene.addEventListener(MouseEvent.MOUSE_MOVE,this.onLandMove);
         this.FMC_Scene.addEventListener(MouseEvent.MOUSE_OUT,this.onLandUP);
         this.FMC_Scene.addEventListener(MouseEvent.MOUSE_UP,this.onLandUP);
         this.FMC_Scene.MC_PickTips.alpha = 0;
         var _loc2_:int = 0;
         while(_loc2_ < 30)
         {
            _loc3_ = this.FMC_Scene["MC_Land_" + _loc2_];
            if(_loc3_ != null)
            {
               _loc3_.addEventListener(MouseEvent.CLICK,this.onLandClick);
               _loc3_.addEventListener(MouseEvent.MOUSE_DOWN,this.onLandDown);
            }
            _loc2_++;
         }
         this.Countdowns = [];
      }
      
      public function UpdateUI() : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:int = 0;
         if(THomelandModel.selfLand.length == 0)
         {
            return;
         }
         var _loc1_:Array = null;
         if(THomelandModel.Status == 0)
         {
            _loc1_ = THomelandModel.selfLand;
         }
         else
         {
            _loc1_ = THomelandModel.currentLand;
         }
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < 30)
         {
            _loc3_ = this.FMC_Scene["MC_Land_" + _loc2_];
            if(_loc3_ != null)
            {
               if(_loc1_.length > _loc2_)
               {
                  _loc3_.gotoAndStop(2);
                  _loc4_ = TMarriedModel.CurrentServerTime - _loc1_[_loc2_].time;
                  if(_loc4_ < THomelandModel.RoseTime[1])
                  {
                     _loc3_.MC_Rose.gotoAndStop(1);
                  }
                  else if(_loc4_ < THomelandModel.RoseTime[3])
                  {
                     _loc3_.MC_Rose.gotoAndStop(2);
                  }
                  else
                  {
                     _loc3_.MC_Rose.gotoAndStop(3);
                  }
                  if(this.Countdowns[_loc2_] == null)
                  {
                     this.Countdowns[_loc2_] = _loc3_.Text_Countdown;
                  }
               }
               else
               {
                  _loc3_.gotoAndStop(1);
                  _loc3_.MC_Extend.visible = THomelandModel.Status == 0 && _loc2_ == _loc1_.length && THomelandModel.getExtendLand() < 8;
               }
            }
            _loc2_++;
         }
      }
      
      public function LogicsPerform() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:Array = null;
         if(THomelandModel.Status == 0)
         {
            _loc1_ = THomelandModel.selfLand;
         }
         else
         {
            _loc1_ = THomelandModel.currentLand;
         }
         if(_loc1_ == null)
         {
            return;
         }
         if(this.Countdowns != null && this.Countdowns.length > 0)
         {
            _loc2_ = int(_loc1_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = TMarriedModel.CurrentServerTime - _loc1_[_loc3_].time;
               if(_loc4_ < THomelandModel.RoseTime[0])
               {
                  this.Countdowns[_loc3_].text = TIllustratedModel.TextFormat(70480034,this.hhmmss(THomelandModel.RoseTime[0] - _loc4_));
               }
               else if(_loc4_ < THomelandModel.RoseTime[1])
               {
                  this.Countdowns[_loc3_].text = TIllustratedModel.TextFormat(70480035,this.hhmmss(THomelandModel.RoseTime[1] - _loc4_));
               }
               else if(_loc4_ < THomelandModel.RoseTime[2])
               {
                  this.Countdowns[_loc3_].text = TIllustratedModel.TextFormat(70480036,this.hhmmss(THomelandModel.RoseTime[2] - _loc4_));
               }
               else if(_loc4_ < THomelandModel.RoseTime[3])
               {
                  this.Countdowns[_loc3_].text = TIllustratedModel.TextFormat(70480037,this.hhmmss(THomelandModel.RoseTime[3] - _loc4_));
               }
               else
               {
                  this.Countdowns[_loc3_].text = "可采摘";
               }
               _loc3_++;
            }
         }
      }
      
      public function pickTips(param1:int, param2:int) : void
      {
         TweenUtil.removeTween(this.FMC_Scene.MC_PickTips);
         this.FMC_Scene.MC_PickTips.alpha = 1;
         this.FMC_Scene.MC_PickTips.x = this.FMC_Scene["MC_Land_" + param1].x + 20;
         this.FMC_Scene.MC_PickTips.y = this.FMC_Scene["MC_Land_" + param1].y + 20;
         this.FMC_Scene.MC_PickTips.TF_PickNumber.text = "+" + param2;
         TweenUtil.to(this.FMC_Scene.MC_PickTips,1500,{
            "y":this.FMC_Scene.MC_PickTips.y - 100,
            "alpha":0
         });
      }
      
      public function pickAllRose() : void
      {
         var _loc2_:MovieClip = null;
         if(!this.canPickRose())
         {
            this.EffectGenerateTextByErrorCode && this.EffectGenerateTextByErrorCode(1402);
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < 30)
         {
            _loc2_ = this.FMC_Scene["MC_Land_" + _loc1_];
            if(_loc2_ != null)
            {
               if(_loc2_.currentFrame != 1)
               {
                  if(_loc2_.MC_Rose.currentFrame == 3)
                  {
                     this.pickRose(_loc1_);
                  }
               }
            }
            _loc1_++;
         }
      }
      
      private function canPickRose() : Boolean
      {
         var _loc3_:MovieClip = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < 30)
         {
            _loc3_ = this.FMC_Scene["MC_Land_" + _loc2_];
            if(_loc3_.currentFrame == 2 && _loc3_.MC_Rose.currentFrame == 3)
            {
               _loc1_ = true;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function pickRose(param1:int) : void
      {
         var _loc2_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_PickRoseReq);
         if(THomelandModel.Status == 0)
         {
            _loc2_.Data.writeUnsignedInt(SLogicsCore.Character.Identifier0);
            _loc2_.Data.writeUnsignedInt(SLogicsCore.Character.Identifier1);
            _loc2_.Data.writeInt(param1);
         }
         else
         {
            _loc2_.Data.writeUnsignedInt(THomelandModel.Identifier0);
            _loc2_.Data.writeUnsignedInt(THomelandModel.Identifier1);
            _loc2_.Data.writeInt(param1);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      private function onLandMove(param1:MouseEvent) : void
      {
         if(this.FDrag == false)
         {
            return;
         }
         var _loc2_:int = this.FMC_Scene.stage.mouseX - this.FPx;
         if(this.FMC_Scene.x + _loc2_ > 337)
         {
            this.FMC_Scene.x = 337;
         }
         else if(this.FMC_Scene.x + _loc2_ < -627)
         {
            this.FMC_Scene.x = -627;
         }
         else
         {
            this.FMC_Scene.x += _loc2_;
         }
         this.FPx = this.FMC_Scene.stage.mouseX;
      }
      
      private function onLandClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:int = int(_loc2_.name.split("MC_Land_")[1]);
         if(_loc2_.currentFrame == 1)
         {
            if(Boolean(_loc2_.MC_Extend) && Boolean(_loc2_.MC_Extend.visible))
            {
               THomelandModel.homeLand.FExtendLand.visible = true;
            }
         }
         else if(_loc2_.MC_Rose.currentFrame == 3)
         {
            this.pickRose(_loc3_);
         }
      }
      
      private function onLandDown(param1:MouseEvent) : void
      {
         this.FPx = this.FMC_Scene.stage.mouseX;
         this.FDrag = true;
      }
      
      private function onLandUP(param1:MouseEvent) : void
      {
         this.FPx = 0;
         this.FDrag = false;
      }
      
      private function hhmmss(param1:int) : String
      {
         var _loc2_:int = param1 / 3600;
         param1 -= _loc2_ * 3600;
         var _loc3_:int = param1 / 60;
         param1 -= _loc3_ * 60;
         var _loc4_:int = param1;
         return this.textformat(_loc2_) + ":" + this.textformat(_loc3_) + ":" + this.textformat(_loc4_);
      }
      
      private function textformat(param1:int) : String
      {
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return param1.toString();
      }
   }
}

