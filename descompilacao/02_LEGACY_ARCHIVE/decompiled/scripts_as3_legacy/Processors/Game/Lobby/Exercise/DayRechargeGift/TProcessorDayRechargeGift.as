package Processors.Game.Lobby.Exercise.DayRechargeGift
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.DayRechargeGift.TDayRechargeGift;
   import Logics.SLogicsCore;
   import Logics.Streamization.Exercise.TUnstreamizerDayRechargeGift;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SHORTCUTS;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TProcessorDayRechargeGift extends TProcessorLobbyWindows
   {
      
      protected static const ROUND_COUNT:uint = 4;
      
      protected static const DEGREE:uint = 360;
      
      protected static const EffectMulti_DelayTicks:int = 2000;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUnstreamizerDayRechargeGift:TUnstreamizerDayRechargeGift;
      
      protected var FDayRechargeGift:TDayRechargeGift;
      
      protected var FMC_Pointer:MovieClip;
      
      protected var FDayRechargeGiftList:Vector.<TUIDayRechargeGift>;
      
      protected var FEndTime:int;
      
      protected var FOnOpenActivity:Function;
      
      protected var FIsEndPushText:Boolean;
      
      protected var FEffectTexts:Vector.<String>;
      
      protected var FEffDelayReferenceTick:int;
      
      protected var FStringID:int;
      
      public function TProcessorDayRechargeGift(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FUnstreamizerDayRechargeGift = new TUnstreamizerDayRechargeGift();
         this.FDayRechargeGiftList = new Vector.<TUIDayRechargeGift>();
         this.FEffectTexts = new Vector.<String>();
         this.FDayRechargeGift = SLogicsCore.DayRechargeGift;
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DayRechargeGift_Info_Ret,this.PerformPacket_DayRechargeGift_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DayRechargeGift_Award_Ret,this.PerformPacket_DayRechargeGift_Award);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_DayRechargeGift_OpenActive_Ret,this.PerformPacket_SC_OpenActiveRet);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4076863490);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIDayRechargeGift = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_dayRecharge") as MovieClip;
         addChild(this.FMC_Scene);
         _loc2_ = 3;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = new TUIDayRechargeGift(this);
            this.FDayRechargeGiftList.push(_loc3_);
            _loc3_.UIDispatch(this.FMC_Scene["MC_Item_" + _loc1_]);
            _loc3_.reqAwardFun = this.PerformPacket_DayRechargeGift_Award_Req;
            _loc3_.OnOverlay = UIComponentsHintOnOver;
            _loc3_.OnOut = UIComponentsHintOnOut;
            _loc1_++;
         }
         this.FMC_Pointer = this.FMC_Scene.mc_pointer;
         this.FMC_Scene.x = FUICore.StageWidth - this.FMC_Scene.width >> 1;
         this.FMC_Scene.y = FUICore.StageHeight - this.FMC_Scene.height >> 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Scene.BTN_Close.addEventListener(MouseEvent.CLICK,this.OnBtnCloseHandle);
         super.ResourcesPerform_UILocations();
      }
      
      protected function PerformPacket_SC_OpenActiveRet(param1:TPacket = null) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:Boolean = _loc3_ == 0 ? false : true;
         this.FEndTime = _loc2_.readUnsignedInt();
         SLogicsCore.NewActivityModes.SetActivityStatus(CONST_SHORTCUTS.TYPE_NewActiveList_DayRechargeGift,_loc4_);
         if(!_loc4_ && this.visible)
         {
            ProcessorClose();
         }
         if(this.FOnOpenActivity != null)
         {
            this.FOnOpenActivity();
         }
      }
      
      protected function PerformPacket_DayRechargeGift_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerDayRechargeGift.Unstreamize(_loc2_,this.FDayRechargeGift,null);
         this.SetDayRechargeGift(this.FDayRechargeGift);
         ProcessorOnCheckIconStatus(CONST_SHORTCUTS.POSITION_NewActiveList,CONST_SHORTCUTS.TYPE_NewActiveList_DayRechargeGift,this.FDayRechargeGift.CheckStatus());
         this.FMC_Scene.TF_actTime.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_OnlyTime,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDayRechargeGift.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FDayRechargeGift.EndTime) * 1000)));
      }
      
      protected function PerformPacket_DayRechargeGift_Info_Req() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DayRechargeGift_Info_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_DayRechargeGift_Award(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         _loc2_ = param1.Data;
         _loc3_ = int(_loc2_.readUnsignedInt());
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = _loc2_.readUnsignedInt();
         this.StartRotate(_loc4_);
         _loc8_ = _loc2_.readShort();
         _loc10_ = "";
         _loc9_ = 0;
         while(_loc9_ < _loc8_)
         {
            _loc5_ = int(_loc2_.readUnsignedInt());
            _loc6_ = int(_loc2_.readUnsignedInt());
            _loc7_ = int(_loc2_.readUnsignedInt());
            _loc10_ = STRING_COMMON.GetItemNameByType(_loc5_,_loc6_) + "*" + _loc7_;
            this.FEffectTexts.push(_loc10_);
            _loc9_++;
         }
      }
      
      protected function PerformPacket_DayRechargeGift_Award_Req(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_DayRechargeGift_Award_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function SetDayRechargeGift(param1:TDayRechargeGift) : void
      {
         var Value:TDayRechargeGift = param1;
         this.FDayRechargeGiftList && this.FDayRechargeGiftList.forEach(function(param1:TUIDayRechargeGift, param2:int, param3:Vector.<TUIDayRechargeGift>):void
         {
            param1.UpData(Value.BoxList[param2]);
         });
      }
      
      protected function StartRotate(param1:uint) : void
      {
         var rotateDegree:int = 0;
         var Rate:uint = param1;
         rotateDegree = -DEGREE * ROUND_COUNT - (Rate - 1) * DEGREE / 6;
         TweenUtil.to(this.FMC_Pointer,1300,{
            "rotation":rotateDegree,
            "ease":Expo.easeInOut,
            "onComplete":function():void
            {
               FIsEndPushText = true;
            }
         });
      }
      
      protected function LogicsPerform_EffectText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         _loc6_ = "";
         _loc4_ = "";
         if(this.FIsEndPushText)
         {
            if(this.FEffectTexts.length == 0)
            {
               this.FIsEndPushText = false;
               return;
            }
            this.FStringID = CONST_SYSTEMLANGUAGE.BACKPACK_FORMAT_02;
            _loc2_ = int(this.FEffectTexts.length);
            _loc3_ = 10;
            _loc5_ = STimingCore.TickCount - this.FEffDelayReferenceTick;
            if(_loc5_ < EffectMulti_DelayTicks)
            {
               return;
            }
            _loc7_ = TUtilityString.GetText(this.FStringID);
            _loc6_ = _loc7_.split("\\n")[0] + "\n";
            _loc1_ = 0;
            while(_loc1_ < _loc3_)
            {
               if(_loc2_ <= _loc1_)
               {
                  break;
               }
               _loc4_ += this.FEffectTexts.shift();
               _loc4_ = _loc4_ + "\n";
               _loc1_++;
            }
            _loc6_ += _loc4_;
            this.FEffDelayReferenceTick = STimingCore.TickCount;
            EffectGenerateText(_loc6_);
         }
      }
      
      protected function OnBtnCloseHandle(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         this.FDayRechargeGiftList && this.FDayRechargeGiftList.forEach(function(param1:TUIDayRechargeGift, param2:int, param3:Vector.<TUIDayRechargeGift>):void
         {
            param1.LogicsPerform();
         });
         this.LogicsPerform_EffectText();
      }
      
      public function get OnOpenActivity() : Function
      {
         return this.FOnOpenActivity;
      }
      
      public function set OnOpenActivity(param1:Function) : void
      {
         this.FOnOpenActivity = param1;
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.PerformPacket_DayRechargeGift_Info_Req();
      }
      
      override public function Unmount() : void
      {
         this.FMC_Pointer.rotation = 0;
      }
   }
}

import Foundation.UI.TUIComponent;
import Foundation.Utilities.TGameUtil;
import Foundation.Utilities.TUtilityString;
import Logics.Exercise.TBaseBox;
import Processors.Game.Common.Effects.Display.TEffectBaseGlow;
import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
import flash.display.MovieClip;
import flash.events.MouseEvent;

class TUIDayRechargeGift extends TUIComponent
{
   
   protected var MC_Resource:MovieClip;
   
   protected var FUIShowItem:TUIShowItem;
   
   protected var FBTN_turn:MovieClip;
   
   protected var FBTN_recharge:MovieClip;
   
   protected var FBaseBox:TBaseBox;
   
   protected var FEffectGlow:TEffectBaseGlow;
   
   public var OnOverlay:Function;
   
   public var OnOut:Function;
   
   public var reqAwardFun:Function;
   
   public function TUIDayRechargeGift(param1:TUIComponent)
   {
      super(param1);
   }
   
   public function UIDispatch(param1:MovieClip) : void
   {
      this.MC_Resource = param1;
      this.FUIShowItem = new TUIShowItem(this,3);
      this.FUIShowItem.Perform_UIDispatch(param1["MC_Award"]);
      this.FUIShowItem.OnOverlay = this.PerformOnOverlay;
      this.FUIShowItem.OnOut = this.PerformOnOut;
      this.FBTN_turn = param1.BTN_turn;
      TGameUtil.setButtonMode(this.FBTN_turn,true);
      this.FBTN_turn.addEventListener(MouseEvent.CLICK,this.onClickTurn);
      if(this.FEffectGlow == null)
      {
         this.FEffectGlow = new TEffectBaseGlow();
         this.FEffectGlow.SetParameters(this.FBTN_turn,15911245,1);
      }
      this.FBTN_recharge = param1.BTN_recharge;
      TGameUtil.setButtonMode(this.FBTN_recharge,true);
      this.FBTN_recharge.addEventListener(MouseEvent.CLICK,this.onRecharge);
   }
   
   public function UpData(param1:TBaseBox) : void
   {
      this.FBaseBox = param1;
      this.FUIShowItem.UpdateUI(this.FBaseBox.Inventories);
      if(this.FBaseBox.Status == -1 || this.FBaseBox.Status == 1)
      {
         TGameUtil.setButtonMode(this.FBTN_turn,false);
         this.FBTN_turn.mouseEnabled = false;
         this.FEffectGlow.Stop();
      }
      else
      {
         TGameUtil.setButtonMode(this.FBTN_turn,true);
         this.FBTN_turn.mouseEnabled = true;
         this.FEffectGlow.Run();
      }
      this.MC_Resource.TF_chongzhi.text = TUtilityString.Format(TUtilityString.GetText(80002383),this.FBaseBox.Level);
   }
   
   public function LogicsPerform() : void
   {
      if(this.FUIShowItem)
      {
         this.FUIShowItem.LogicsPerform();
      }
      if(this.FEffectGlow.IsRunOver)
      {
         this.FEffectGlow.Run();
      }
   }
   
   protected function onClickTurn(param1:MouseEvent) : void
   {
      if(this.reqAwardFun != null && this.FBaseBox != null)
      {
         this.reqAwardFun(this.FBaseBox.Level);
      }
   }
   
   protected function onRecharge(param1:MouseEvent) : void
   {
   }
   
   protected function PerformOnOverlay(param1:Object, param2:Object) : void
   {
      if(this.OnOverlay != null)
      {
         this.OnOverlay(param1,param2);
      }
   }
   
   protected function PerformOnOut(param1:Object, param2:Object) : void
   {
      if(this.OnOut != null)
      {
         this.OnOut(param1,param2);
      }
   }
}
