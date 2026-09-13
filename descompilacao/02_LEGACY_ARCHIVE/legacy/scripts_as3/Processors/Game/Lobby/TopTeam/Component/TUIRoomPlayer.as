package Processors.Game.Lobby.TopTeam.Component
{
   import Foundation.UI.TUIComponent;
   import Logics.GroupBattle.TRoomPlayer;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.GroupBattle.Component.TUIRoomPlayerInfo;
   import Resources.Strings.STRING_TOPTEAM;
   import flash.events.TextEvent;
   import flash.text.TextField;
   
   public class TUIRoomPlayer extends TUIRoomPlayerInfo
   {
      
      protected var FValue:Boolean;
      
      public function TUIRoomPlayer(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function UIDispatch() : void
      {
         super.UIDispatch();
         FAvatarGuideText.push(FResource["Guide5"]);
      }
      
      override protected function UILocations() : void
      {
         var _loc1_:TextField = null;
         super.UILocations();
         _loc1_ = FAvatarGuideText[FAvatarGuideText.length - 1];
         _loc1_.htmlText = STRING_TOPTEAM.AvaterInfor_Friend;
         _loc1_.addEventListener(TextEvent.LINK,GuideStringClick);
      }
      
      override protected function UpdateUI() : void
      {
         var _loc1_:TRoomPlayer = null;
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TextField = null;
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         super.UpdateUI();
         _loc6_ = uint(SLogicsCore.Character.Identifier0);
         _loc7_ = uint(SLogicsCore.Character.Identifier1);
         _loc1_ = FContext as TRoomPlayer;
         _loc5_ = _loc1_.Identifier0 == _loc6_ && _loc1_.Identifier1 == _loc7_;
         if(_loc1_ != null)
         {
            _loc3_ = FAvatarGuideText.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = FAvatarGuideText[_loc2_];
               if(_loc2_ == 2)
               {
                  if(this.FValue)
                  {
                     _loc4_.visible = !Boolean(_loc1_.IsCaptaian);
                  }
                  else
                  {
                     _loc4_.visible = false;
                  }
               }
               else if(_loc2_ == 3)
               {
                  if(_loc5_)
                  {
                     _loc4_.visible = !_loc5_;
                  }
                  else
                  {
                     if(this.FValue)
                     {
                        _loc4_.visible = !Boolean(_loc1_.IsCaptaian);
                     }
                     else
                     {
                        _loc4_.visible = Boolean(_loc1_.IsCaptaian);
                     }
                     _loc4_.htmlText = STRING_TOPTEAM.STRING_TransferCaptain[uint(this.FValue)];
                  }
               }
               else
               {
                  _loc4_.visible = !_loc5_;
               }
               _loc2_++;
            }
         }
      }
      
      public function get Value() : Boolean
      {
         return this.FValue;
      }
      
      public function set Value(param1:Boolean) : void
      {
         this.FValue = param1;
      }
   }
}

