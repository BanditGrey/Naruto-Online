package Processors.Game.Lobby.Ramen
{
   import Foundation.Common.*;
   import Foundation.Network.*;
   import Foundation.Resources.*;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.*;
   import Foundation.Utilities.*;
   import Logics.Characters.TFriendDigest;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.DatebaseVO.VO.TTree;
   import Logics.Ramn.*;
   import Logics.SLogicsCore;
   import Logics.Streamization.Ramen.*;
   import Processors.Game.Lobby.Common.*;
   import Rendering.Overlayers.HelpTips.*;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.*;
   import Resources.Strings.*;
   import Utilities.UI.Overlayers.*;
   import flash.display.*;
   import flash.events.*;
   import flash.utils.*;
   
   public class TProcessorRamen extends TProcessorLobbyWindows
   {
      
      protected static const SIZE_WIDTH_Ramen:uint = 442;
      
      protected static const SIZE_HIGHT_Ramen:uint = 470;
      
      protected static const SIZE_WIDTH_GainRamen:uint = 752;
      
      protected static const SIZE_HIGHT_GainRamen:uint = 470;
      
      protected static const SIZE_WIDTH_UIGainRamen:uint = 356;
      
      protected static const SIZE_HIGHT_UIGainRamen:uint = 252;
      
      public static const KEY_MAKE_RAMEN:uint = CONST_COUNTER.KEY_MAKE_RAMEN;
      
      protected var FRamenScene:MovieClip;
      
      protected var FMC_FriendsOpenOrClose:MovieClip;
      
      protected var FMC_FriendsOpen:MovieClip;
      
      protected var FMC_FriendsClose:MovieClip;
      
      protected var FBT_Close:SimpleButton;
      
      protected var FBT_Help:SimpleButton;
      
      protected var FMC_SendGoods:MovieClip;
      
      protected var FMC_Left:MovieClip;
      
      protected var FMC_Right:MovieClip;
      
      protected var FMC_LeftBack:MovieClip;
      
      protected var FProcessorWindowRamen:TProcessorWindowRamen;
      
      protected var FProcessorWindowGainRamen:TProcessorWindowGainRamen;
      
      protected var FUIWindowGainRamen:TUIWindowGainRamen;
      
      protected var FBoundsRamen:TBounds;
      
      protected var FBoundsGainRamen:TBounds;
      
      protected var FBoundsUIGainRamen:TBounds;
      
      protected var FHelpHint:THint;
      
      protected var FRamenData:TRamenData;
      
      protected var FUnstreamizerRamen:TUnstreamizerRamen;
      
      protected var FShortcutHyperlinks:Function;
      
      protected var FOnEffectFree:Function;
      
      public function TProcessorRamen(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowRamen = new TProcessorWindowRamen(this);
         this.FProcessorWindowRamen.MakeRamen = this.MakeRamen;
         this.FProcessorWindowRamen.ReturnMyShop = this.ReturnMyShop;
         this.FProcessorWindowRamen.SendFriendGoods = this.SendFriendGoods;
         this.FProcessorWindowRamen.SendSelfGoods = this.SendGoods;
         this.FProcessorWindowRamen.ShowReceiveWindow = this.ShowReceiveWindow;
         this.FProcessorWindowRamen.OnEffectFree = this.OnShortcutEffectNotification;
         this.FProcessorWindowRamen.Visible = true;
         this.FBoundsRamen = new TBounds();
         this.FBoundsRamen.Width = SIZE_WIDTH_Ramen;
         this.FBoundsRamen.Height = SIZE_HIGHT_Ramen;
         ComponentBoundsCenter(this.FProcessorWindowRamen,this.FBoundsRamen);
         this.FProcessorWindowGainRamen = new TProcessorWindowGainRamen(this);
         this.FProcessorWindowGainRamen.SelectFriend = this.OnSelectFriend;
         this.FProcessorWindowGainRamen.BatchSend = this.OnBatchSend;
         this.FProcessorWindowGainRamen.OnHintOnOver = ProcessorTipOnOver;
         this.FProcessorWindowGainRamen.OnHintOnOut = ProcessorTipOnOut;
         this.FBoundsGainRamen = new TBounds();
         this.FBoundsGainRamen.Width = SIZE_WIDTH_GainRamen;
         this.FBoundsGainRamen.Height = SIZE_HIGHT_GainRamen;
         this.FUIWindowGainRamen = new TUIWindowGainRamen(this.Parent,param2);
         this.FUIWindowGainRamen.OnShortcutHyperlinks = this.OnShortcutHyperlinks;
         this.FUIWindowGainRamen.GetRewards = this.ReceiveAwards;
         this.FUIWindowGainRamen.Visible = false;
         this.FBoundsUIGainRamen = new TBounds();
         this.FBoundsUIGainRamen.Width = SIZE_WIDTH_UIGainRamen;
         this.FBoundsUIGainRamen.Height = SIZE_HIGHT_UIGainRamen;
         ComponentBoundsCenter(this.FUIWindowGainRamen,this.FBoundsUIGainRamen);
         this.FRamenData = SLogicsCore.RamenData;
         this.FUnstreamizerRamen = new TUnstreamizerRamen();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_RAMEN.RESOURCESID_RAMEN);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TSystemLanguage = null;
         this.FRamenScene = TUtilityReflection.CreateDisplayObjectInstance(CONST_RAMEN.RESOURCE_ClassName_RAMEN) as MovieClip;
         addChild(this.FRamenScene);
         this.FBT_Close = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_BT_Close];
         this.FBT_Help = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_BT_Help];
         this.FProcessorWindowRamen.ResourcesPerformDispatch(this.FRamenScene);
         this.FProcessorWindowGainRamen.ResourcesPerformDispatch(this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_SendGoods]);
         this.FUIWindowGainRamen.ResourcesPerformDispatch();
         this.FMC_FriendsOpenOrClose = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_FriendsOpenOrClose];
         this.FMC_FriendsOpen = this.FMC_FriendsOpenOrClose[CONST_RAMEN.RESOURCE_Link_MC_OpenFriend];
         this.FMC_FriendsClose = this.FMC_FriendsOpenOrClose[CONST_RAMEN.RESOURCE_Link_MC_CloseFriend];
         TGameUtil.setButtonMode(this.FMC_FriendsOpen,true);
         TGameUtil.setButtonMode(this.FMC_FriendsClose,true);
         this.FMC_FriendsOpen.addEventListener(MouseEvent.CLICK,this.OnOpenFriend);
         this.FMC_FriendsClose.addEventListener(MouseEvent.CLICK,this.OnCloseFriend);
         this.FMC_FriendsClose.visible = false;
         this.FMC_SendGoods = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_SendGoods];
         this.FMC_Left = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_Left];
         this.FMC_Right = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_Right];
         this.FMC_LeftBack = this.FRamenScene[CONST_RAMEN.RESOURCE_Link_MC_LeftBack];
         this.FHelpHint = new THint();
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_RAMYUNSHOP) as TSystemLanguage;
         this.FHelpHint.Content = _loc1_.Desc;
         FOverlayerHelpTips = new TOverlayerHelpTips(this.Parent);
         FOverlayerHelpTips.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHelpTips);
         FOverlayerHint = new TOverlayerHint(this.Parent);
         FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(FOverlayerHint);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FProcessorWindowGainRamen.OnEffectText = OnEffectText;
         this.FBT_Close.addEventListener(MouseEvent.CLICK,this.OnCloseRamen);
         this.FBT_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.UIHelpHintOnOver);
         this.FBT_Help.addEventListener(MouseEvent.ROLL_OUT,this.UIHelpHintOnOut);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Ramen_QueryInfoRet,this.PerformPacket_SC_Ramen_SetLiftView);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Ramen_SendMaterialRet,this.PerformPacket_SC_Ramen_SendGoods);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Ramen_MakeNooldeRet,this.PerformPacket_SC_Ramen_MakeRamen);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Ramen_GiveNoodleRet,this.PerformPacket_SC_Ramen_GainRamen);
      }
      
      protected function PerformPacket_SC_Ramen_SetLiftView(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         this.FUnstreamizerRamen.Unstreamize(_loc3_,this.FRamenData,null);
         this.FProcessorWindowRamen.BackMyShop();
         this.OnOpenFriend();
      }
      
      protected function PerformPacket_SC_Ramen_SendGoods(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:TTree = null;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:Boolean = false;
         var _loc16_:Vector.<uint> = null;
         var _loc17_:Vector.<uint> = null;
         var _loc18_:Vector.<uint> = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = uint(_loc3_.readByte());
         if(_loc4_ == 0)
         {
            _loc14_ = this.FRamenData.SelfRamenLevel;
            this.FUnstreamizerRamen.UnstreamizeSelfRamen(_loc3_,this.FRamenData,null);
            if(_loc14_ != this.FRamenData.SelfRamenLevel)
            {
               this.FRamenData.SelfRamenRewardCount += this.FRamenData.SelfRamenLevel - _loc14_;
            }
            _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Tree,this.FRamenData.SelfRamenLevel) as TTree;
            _loc13_ = _loc12_.Train;
            this.FRamenData.SelfRamenSendCD = STimingCore.GetServerTick();
            this.FProcessorWindowRamen.SelfSendGoodsOk();
         }
         else
         {
            this.FUnstreamizerRamen.UnstreamizeFriendRamen(_loc3_,this.FRamenData,null);
            this.FProcessorWindowRamen.Update();
            this.FProcessorWindowGainRamen.UpdataUI();
         }
         if(_loc4_ == 0)
         {
            _loc11_ = TUtilityString.Format(STRING_Ramen.STRING_SendSelfStr,_loc13_);
         }
         else
         {
            _loc11_ = STRING_Ramen.STRING_SendFriendStr;
         }
         _loc7_ = uint(_loc3_.readShort());
         if(_loc7_ > 0)
         {
            _loc16_ = new Vector.<uint>();
            _loc17_ = new Vector.<uint>();
            _loc18_ = new Vector.<uint>();
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc8_ = uint(_loc3_.readShort());
               _loc9_ = _loc3_.readUnsignedInt();
               _loc10_ = _loc3_.readUnsignedInt();
               _loc15_ = false;
               _loc6_ = 0;
               while(_loc6_ < _loc16_.length)
               {
                  if(_loc8_ == _loc16_[_loc6_] && _loc9_ == _loc17_[_loc6_])
                  {
                     _loc18_[_loc6_] += _loc10_;
                     _loc15_ = true;
                  }
                  _loc6_++;
               }
               if(!_loc15_)
               {
                  _loc16_.push(_loc8_);
                  _loc17_.push(_loc9_);
                  _loc18_.push(_loc10_);
               }
               _loc5_++;
            }
            _loc7_ = _loc16_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc7_)
            {
               _loc11_ += "\n\t";
               _loc8_ = _loc16_[_loc5_];
               _loc9_ = _loc17_[_loc5_];
               _loc10_ = _loc18_[_loc5_];
               _loc11_ += STRING_COMMON.GetItemNameByType(_loc8_,_loc9_) + " *" + _loc10_;
               _loc5_++;
            }
         }
         else if(_loc4_ != 0)
         {
            _loc11_ = STRING_Ramen.STRING_NoReward;
         }
         EffectGenerateText(_loc11_);
      }
      
      protected function PerformPacket_SC_Ramen_MakeRamen(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         _loc4_ = _loc3_.readUnsignedByte();
         _loc5_ = _loc3_.readUnsignedInt();
         _loc6_ = _loc3_.readUnsignedInt();
         if(_loc4_ == 0)
         {
            _loc7_ = TUtilityString.Format(STRING_Ramen.FORMAT_AddSliver,_loc5_);
         }
         else
         {
            _loc7_ = TUtilityString.Format(STRING_Ramen.FORMAT_BantchMake,_loc6_,_loc5_);
         }
         EffectGenerateText(_loc7_);
         this.MakeRamenNumReq();
      }
      
      protected function PerformPacket_SC_Ramen_GainRamen(param1:TPacket) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:ByteArray = null;
         _loc3_ = param1.Data;
         _loc2_ = _loc3_.readUnsignedInt();
         if(_loc2_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc2_);
            return;
         }
         --this.FRamenData.SelfRamenRewardCount;
         this.FProcessorWindowRamen.Update();
         EffectGenerateText(STRING_BASEACTIVITY.FORMAT_GET);
      }
      
      protected function NoodleShop_C2S_InfoReq() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Ramen_QueryInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function MakeRamen(param1:Object, param2:uint) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Ramen_MakeNooldeReq);
         _loc4_ = _loc3_.Data;
         _loc4_.writeByte(param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function SendGoods(param1:uint, param2:Vector.<uint> = null) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TPacket = null;
         var _loc6_:ByteArray = null;
         _loc5_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Ramen_SendMaterialReq);
         _loc6_ = _loc5_.Data;
         _loc6_.writeByte(param1);
         if(param1 != 0)
         {
            _loc4_ = param2.length / 2;
            _loc6_.writeShort(_loc4_);
            _loc3_ = 0;
            while(_loc3_ < param2.length)
            {
               _loc6_.writeUnsignedInt(param2[_loc3_]);
               _loc3_++;
            }
         }
         else
         {
            _loc6_.writeShort(0);
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc5_);
      }
      
      protected function ReceiveAwards(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Ramen_GiveNoodleReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ShowReceiveWindow(param1:Object) : void
      {
         this.FUIWindowGainRamen.Show();
      }
      
      protected function OnShortcutEffectNotification(param1:Boolean) : void
      {
         if(this.FOnEffectFree != null)
         {
            this.FOnEffectFree(CONST_SHORTCUTS.POSITION_Activity,CONST_SHORTCUTS.TYPE_Activity_Ramen,param1);
         }
      }
      
      protected function ReturnMyShop(param1:Object) : void
      {
         this.FProcessorWindowGainRamen.ReturnMyShop();
      }
      
      protected function SendFriendGoods(param1:Object) : void
      {
         this.FProcessorWindowGainRamen.SendFriendGoods();
      }
      
      protected function MakeRamenNumReq() : void
      {
         var _loc1_:Vector.<uint> = null;
         _loc1_ = new Vector.<uint>(1);
         _loc1_[0] = KEY_MAKE_RAMEN;
         SLogicsCore.SignalPost(CONST_SIGNAL.SIGNALDESTINATION_COUNTER_MakeRamen_Req,0,0,_loc1_);
      }
      
      override public function set OnEffectText(param1:Function) : void
      {
         FOnEffectText = param1;
         this.FProcessorWindowRamen.OnEffectText = param1;
      }
      
      protected function OnOpenFriend(param1:MouseEvent = null) : void
      {
         this.FMC_SendGoods.visible = true;
         ComponentBoundsCenter(this,this.FBoundsGainRamen);
         this.FMC_Right.visible = false;
         this.FMC_LeftBack.visible = false;
         this.FMC_FriendsOpen.visible = false;
         this.FMC_FriendsClose.visible = true;
         this.FProcessorWindowGainRamen.ResetFriend();
      }
      
      protected function OnCloseFriend(param1:MouseEvent = null) : void
      {
         this.FMC_SendGoods.visible = false;
         ComponentBoundsCenter(this,this.FBoundsRamen);
         this.FMC_Right.visible = true;
         this.FMC_LeftBack.visible = true;
         this.FMC_FriendsOpen.visible = true;
         this.FMC_FriendsClose.visible = false;
         this.FProcessorWindowRamen.BackMyShop();
      }
      
      protected function OnCloseRamen(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function UIHelpHintOnOver(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Context = this.FHelpHint;
         FOverlayerHelpTips.Render(FUICore.MouseCoordinate);
         FOverlayerHelpTips.Show();
      }
      
      protected function UIHelpHintOnOut(param1:MouseEvent) : void
      {
         FOverlayerHelpTips.Hide();
      }
      
      protected function OnSelectFriend(param1:Object, param2:TFriendRamenData) : void
      {
         this.FProcessorWindowRamen.VisitFriendShop(param2);
      }
      
      protected function OnBatchSend(param1:Object, param2:Vector.<uint>) : void
      {
         this.SendGoods(1,param2);
      }
      
      protected function OnShortcutHyperlinks(param1:Object, param2:uint, param3:uint, param4:int = 0, param5:Object = null) : void
      {
         if(this.FShortcutHyperlinks != null)
         {
            this.FShortcutHyperlinks(param1,param2,param3,param4,param5);
         }
      }
      
      public function get ProcessorWindowRamen() : TProcessorWindowRamen
      {
         return this.FProcessorWindowRamen;
      }
      
      public function get ShortcutHyperlinks() : Function
      {
         return this.FShortcutHyperlinks;
      }
      
      public function set ShortcutHyperlinks(param1:Function) : void
      {
         this.FShortcutHyperlinks = param1;
      }
      
      public function get OnEffectFree() : Function
      {
         return this.FOnEffectFree;
      }
      
      public function set OnEffectFree(param1:Function) : void
      {
         this.FOnEffectFree = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowRamen.Load();
            this.FProcessorWindowGainRamen.Load();
            return;
         }
         TutorialNextStep(2300);
         this.FMC_Left.play();
         this.FMC_Right.play();
         this.MakeRamenNumReq();
         this.NoodleShop_C2S_InfoReq();
         this.OnCloseFriend();
      }
      
      override public function Unmount() : void
      {
         TutorialNextStep(2302);
         this.FUIWindowGainRamen.Visible = false;
      }
      
      public function Test() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:ByteArray = null;
         var _loc3_:Array = null;
         var _loc4_:TFriendDigest = null;
         _loc4_ = new TFriendDigest(1,1);
         _loc4_.Name = "test1";
         _loc4_.Level = 20;
         _loc4_.Country = 1;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(1,2);
         _loc4_.Name = "test2";
         _loc4_.Level = 21;
         _loc4_.Country = 2;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(1,3);
         _loc4_.Name = "test3";
         _loc4_.Level = 22;
         _loc4_.Country = 3;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(1,4);
         _loc4_.Name = "test4";
         _loc4_.Level = 23;
         _loc4_.Country = 1;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(1,5);
         _loc4_.Name = "test5";
         _loc4_.Level = 24;
         _loc4_.Country = 2;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(1,6);
         _loc4_.Name = "test6";
         _loc4_.Level = 25;
         _loc4_.Country = 3;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(1,7);
         _loc4_.Name = "test7";
         _loc4_.Level = 26;
         _loc4_.Country = 1;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(1,8);
         _loc4_.Name = "test8";
         _loc4_.Level = 27;
         _loc4_.Country = 2;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(1,9);
         _loc4_.Name = "test9";
         _loc4_.Level = 28;
         _loc4_.Country = 3;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(2,1);
         _loc4_.Name = "test10";
         _loc4_.Level = 29;
         _loc4_.Country = 1;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(2,2);
         _loc4_.Name = "test11";
         _loc4_.Level = 30;
         _loc4_.Country = 2;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(2,3);
         _loc4_.Name = "test12";
         _loc4_.Level = 31;
         _loc4_.Country = 3;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(2,4);
         _loc4_.Name = "test13";
         _loc4_.Level = 32;
         _loc4_.Country = 1;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(2,5);
         _loc4_.Name = "test14";
         _loc4_.Level = 33;
         _loc4_.Country = 2;
         SLogicsCore.Friends.Add(_loc4_);
         _loc4_ = new TFriendDigest(2,6);
         _loc4_.Name = "test15";
         _loc4_.Level = 34;
         _loc4_.Country = 3;
         SLogicsCore.Friends.Add(_loc4_);
         _loc3_ = [{
            "id0":1,
            "id1":1,
            "SendCount":0,
            "level":10,
            "exp":10
         },{
            "id0":1,
            "id1":2,
            "SendCount":1,
            "level":20,
            "exp":20
         },{
            "id0":1,
            "id1":3,
            "SendCount":2,
            "level":30,
            "exp":30
         },{
            "id0":1,
            "id1":4,
            "SendCount":3,
            "level":40,
            "exp":40
         },{
            "id0":1,
            "id1":5,
            "SendCount":4,
            "level":50,
            "exp":50
         },{
            "id0":1,
            "id1":6,
            "SendCount":5,
            "level":60,
            "exp":60
         },{
            "id0":1,
            "id1":7,
            "SendCount":6,
            "level":70,
            "exp":70
         },{
            "id0":1,
            "id1":8,
            "SendCount":7,
            "level":80,
            "exp":80
         },{
            "id0":1,
            "id1":9,
            "SendCount":8,
            "level":90,
            "exp":90
         },{
            "id0":2,
            "id1":1,
            "SendCount":9,
            "level":80,
            "exp":80
         },{
            "id0":2,
            "id1":2,
            "SendCount":0,
            "level":70,
            "exp":70
         },{
            "id0":2,
            "id1":3,
            "SendCount":1,
            "level":60,
            "exp":60
         },{
            "id0":2,
            "id1":4,
            "SendCount":2,
            "level":50,
            "exp":50
         },{
            "id0":2,
            "id1":5,
            "SendCount":3,
            "level":40,
            "exp":40
         },{
            "id0":2,
            "id1":6,
            "SendCount":4,
            "level":30,
            "exp":30
         }];
         _loc2_ = new ByteArray();
         _loc2_.writeInt(50);
         _loc2_.writeInt(60);
         _loc2_.writeInt(2);
         _loc2_.writeInt(3);
         _loc2_.writeInt(STimingCore.GetServerTick() - 250);
         _loc2_.writeShort(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_.writeInt(_loc3_[_loc1_].id0);
            _loc2_.writeInt(_loc3_[_loc1_].id1);
            _loc2_.writeInt(_loc3_[_loc1_].SendCount);
            _loc2_.writeInt(_loc3_[_loc1_].level);
            _loc2_.writeInt(_loc3_[_loc1_].exp);
            _loc1_++;
         }
         _loc2_.writeShort(3);
         _loc2_.writeByte(4);
         _loc2_.writeByte(5);
         _loc2_.writeByte(6);
         _loc2_.position = 0;
         this.FUnstreamizerRamen.Unstreamize(_loc2_,this.FRamenData,null);
      }
   }
}

