package Processors.Game.Lobby.WorldMatch
{
   import Components.ScrollBar.TScrollBar;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Streamization.WorldMatch.TUnstreamizerWorldMatchStreak;
   import Logics.WorldMatch.TWorldMatchStreak;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.WorldMatch.Component.TUIWorldMatchStreak;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_WORLDMATCH;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class TProcessorWorldMatchStreak extends TProcessorLobbyWindows
   {
      
      protected static const GIFTS_NORMAL:int = 1;
      
      protected static const GIFTS_TOPUP:int = 2;
      
      protected var FScrollBar:TScrollBar;
      
      protected var FBTN_Close:MovieClip;
      
      protected var FMovieClip:MovieClip;
      
      protected var FUnstreamizerWorldMatchStreak:TUnstreamizerWorldMatchStreak;
      
      protected var FUIListGifts:Vector.<TUIWorldMatchStreak>;
      
      protected var FWorldMatchStreakDict:Dictionary;
      
      public var UpdateEffectGlowFilter:Function;
      
      public function TProcessorWorldMatchStreak(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerWorldMatchStreak = new TUnstreamizerWorldMatchStreak();
         this.FWorldMatchStreakDict = new Dictionary();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatchStreak_Info,this.PerformPacket_SC_WorldMatchStreak_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_WorldMatchStreak_Reward,this.PerformPacket_SC_WorldMatchStreak_Reward);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_WORLDMATCH.RESOURCESID_Swf_WorldMatchStreak);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMovieClip = TUtilityReflection.CreateDisplayObjectInstance(CONST_WORLDMATCH.RESOURCE_ClassName_WorldMatchStreak) as MovieClip;
         addChild(this.FMovieClip);
         this.FScrollBar = new TScrollBar(this.FMovieClip.MC_List,348,false,0);
         this.FMovieClip.x = FUICore.StageWidth - this.FMovieClip.width >> 1;
         this.FMovieClip.y = FUICore.StageHeight - this.FMovieClip.height >> 1;
         this.FMovieClip.MC_Close.addEventListener(MouseEvent.CLICK,this.OnCloseHandler,false,0,true);
         super.ResourcesPerform_UIDispatch();
      }
      
      protected function PerformPacket_SC_WorldMatchStreak_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerWorldMatchStreak.Unstreamize(_loc2_,this.FWorldMatchStreakDict,null);
         this.FlushWorldMatchStreakReward();
         if(FIsResourcesLoadCompleted)
         {
            this.ConstructScroolBar();
         }
      }
      
      protected function PerformPacket_CS_WorldMatchStreak_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatchStreak_Info);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_SC_WorldMatchStreak_Reward(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc6_:TWorldMatchStreak = null;
         var _loc7_:TUIWorldMatchStreak = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readInt();
         _loc6_ = this.FWorldMatchStreakDict[_loc5_];
         if(_loc4_ == GIFTS_NORMAL)
         {
            _loc6_.Reward = 1;
         }
         else if(_loc4_ == GIFTS_TOPUP)
         {
            _loc6_.TopReward = 1;
            --_loc6_.Count;
         }
         var _loc8_:int = 0;
         while(_loc8_ < this.FUIListGifts.length)
         {
            _loc7_ = this.FUIListGifts[_loc8_] as TUIWorldMatchStreak;
            if(_loc7_.WorldMatchStreak.Identifier == _loc5_)
            {
               _loc7_.SetDate(_loc6_);
               break;
            }
            _loc8_++;
         }
         this.FlushWorldMatchStreakReward();
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
      }
      
      protected function PerformPacket_CS_WorldMatchStreak_Reward(param1:int, param2:int) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_WorldMatchStreak_Reward);
         _loc3_.Data.writeInt(param2);
         _loc3_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:TUIWorldMatchStreak = null;
         var _loc2_:TWorldMatchStreak = null;
         var _loc3_:* = undefined;
         this.FScrollBar.Clear();
         this.FUIListGifts = new Vector.<TUIWorldMatchStreak>();
         for(_loc3_ in this.FWorldMatchStreakDict)
         {
            _loc1_ = new TUIWorldMatchStreak(this);
            _loc1_.OnRewardLevelGift = this.PerformPacket_CS_WorldMatchStreak_Reward;
            _loc1_.OnHintOver = UIComponentsHintOnOver;
            _loc1_.OnHintOut = UIComponentsHintOnOut;
            _loc2_ = this.FWorldMatchStreakDict[_loc3_] as TWorldMatchStreak;
            this.FScrollBar.AddItem(_loc1_);
            _loc1_.SetDate(_loc2_);
            this.FUIListGifts.push(_loc1_);
         }
      }
      
      protected function FlushWorldMatchStreakReward() : Boolean
      {
         var _loc1_:TWorldMatchStreak = null;
         var _loc2_:Boolean = false;
         if(this.FWorldMatchStreakDict)
         {
            for each(_loc1_ in this.FWorldMatchStreakDict)
            {
               if(_loc1_.Reward == 0 || _loc1_.TopReward == 0)
               {
                  _loc2_ = true;
                  break;
               }
            }
         }
         this.UpdateEffectGlowFilter(_loc2_);
         return _loc2_;
      }
      
      protected function OnCloseHandler(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.LogicsPerform();
         if(this.FUIListGifts)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FUIListGifts.length)
            {
               this.FUIListGifts[_loc1_].LogicsPerform();
               _loc1_++;
            }
         }
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_CS_WorldMatchStreak_Info();
      }
   }
}

