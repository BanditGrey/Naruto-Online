package Processors.Game.Lobby.Homeland
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TMarryClass;
   import Logics.DatebaseVO.VO.TRingValue;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Married.TMarriedModel;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import flash.utils.ByteArray;
   
   public class THomelandModel
   {
      
      protected static var FConfigValue:TBins;
      
      protected static var FMarryClass:TBins;
      
      protected static var FRingValue:TBins;
      
      public static var Identifier0:Number = 0;
      
      public static var Identifier1:Number = 0;
      
      public static var homeLand:TProcessorHomeland = null;
      
      public static var selfHome:Object = {};
      
      public static var selfLand:Array = [];
      
      public static var selectedTime:Array = [];
      
      public static var friendInfos:Vector.<Object> = new Vector.<Object>();
      
      public static var ProcessorWindowsSwitch:Function = null;
      
      public static var PopupMenuOnClick:Function = null;
      
      public static var UpdateRingUI:Function = null;
      
      public static var UpdateUI:Function = null;
      
      public static var ProcessorOnInfoRet:Function = null;
      
      public static var ProcessorOnRingChangeRet:Function = null;
      
      public static var ProcessorOnChangeNameRet:Function = null;
      
      public static var ProcessorOnPickRoseRet:Function = null;
      
      public static var ProcessorOnFriendRet:Function = null;
      
      public static var ProcessorOnBuyLandRet:Function = null;
      
      public static var UpdateShortcuts:Function = null;
      
      protected static var FRoseTime:Vector.<uint> = null;
      
      public function THomelandModel()
      {
         super();
      }
      
      public static function PerformPacket_CS_InfoReq() : void
      {
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Married_InfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      public static function getExtendLand() : int
      {
         var _loc1_:TMarryClass = THomelandModel.getMarryVOByExp(THomelandModel.selfHome.charm);
         return selfLand.length - _loc1_.LandNum;
      }
      
      public static function getPickRose() : int
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = int(selfLand.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = TMarriedModel.CurrentServerTime - selfLand[_loc3_].time;
            if(_loc4_ >= RoseTime[3])
            {
               _loc1_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      public static function goHomeland(param1:Number, param2:Number) : void
      {
         if(Identifier0 == param1 && Identifier1 == param2)
         {
            return;
         }
         Identifier0 = param1;
         Identifier1 = param2;
         UpdateUI();
      }
      
      public static function readString(param1:ByteArray) : String
      {
         var _loc2_:int = param1.readInt();
         return param1.readMultiByte(_loc2_,"utf-8");
      }
      
      public static function readLandInfo(param1:ByteArray) : Array
      {
         var _loc5_:Object = null;
         var _loc2_:Array = [];
         var _loc3_:int = param1.readShort();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = {};
            _loc5_.index = param1.readInt();
            _loc5_.time = param1.readInt();
            _loc5_.friendid_0 = param1.readUnsignedInt();
            _loc5_.friendid_1 = param1.readUnsignedInt();
            _loc2_.push(_loc5_);
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function readSelectedTime(param1:ByteArray) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = param1.readShort();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_.push(param1.readInt());
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function vector2array(param1:*) : Array
      {
         var _loc2_:Array = [];
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_.push(param1[_loc3_]);
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function copyByteArray(param1:ByteArray) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeBytes(param1,param1.position,param1.bytesAvailable);
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function getNextMarry(param1:TMarryClass) : TMarryClass
      {
         var _loc4_:TMarryClass = null;
         var _loc2_:int = THomelandModel.MarryClass.Count;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = MarryClass.GetDatebaseByIndex(_loc3_) as TMarryClass;
            if(_loc4_.Identifier == param1.Identifier)
            {
               if(_loc3_ < _loc2_ - 1)
               {
                  return MarryClass.GetDatebaseByIndex(_loc3_ + 1) as TMarryClass;
               }
               return _loc4_;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public static function getMarryVOByLevel(param1:int) : TMarryClass
      {
         var _loc4_:TMarryClass = null;
         var _loc2_:int = THomelandModel.MarryClass.Count;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = MarryClass.GetDatebaseByIndex(_loc3_) as TMarryClass;
            if(param1 == _loc4_.Stars)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return _loc4_;
      }
      
      public static function getMarryVOByExp(param1:int) : TMarryClass
      {
         var _loc4_:TMarryClass = null;
         var _loc2_:int = THomelandModel.MarryClass.Count;
         var _loc3_:* = int(_loc2_ - 1);
         while(_loc3_ >= 0)
         {
            _loc4_ = MarryClass.GetDatebaseByIndex(_loc3_) as TMarryClass;
            if(param1 >= _loc4_.AllCharm)
            {
               return _loc4_;
            }
            _loc3_--;
         }
         return null;
      }
      
      public static function getRingVOByLevel(param1:int, param2:int) : TRingValue
      {
         var _loc5_:TRingValue = null;
         var _loc3_:int = THomelandModel.RingValue.Count;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = RingValue.GetDatebaseByIndex(_loc4_) as TRingValue;
            if(_loc5_.RingId == param1 && _loc5_.BuildLevel == param2)
            {
               return _loc5_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function getRingVOByExp(param1:int, param2:int) : TRingValue
      {
         var _loc5_:TRingValue = null;
         if(param1 == 0)
         {
            param1 = 14211709;
         }
         var _loc3_:int = THomelandModel.RingValue.Count;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = RingValue.GetDatebaseByIndex(_loc4_) as TRingValue;
            if(_loc5_.RingId == param1)
            {
               if(param2 < _loc5_.Exp)
               {
                  return _loc5_;
               }
               param2 -= _loc5_.Exp;
            }
            _loc4_++;
         }
         return null;
      }
      
      public static function getRingTotalExp(param1:TRingValue) : int
      {
         var _loc5_:TRingValue = null;
         var _loc2_:int = 0;
         var _loc3_:int = THomelandModel.RingValue.Count;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = RingValue.GetDatebaseByIndex(_loc4_) as TRingValue;
            if(_loc5_.RingId == param1.RingId && _loc5_.Identifier < param1.Identifier)
            {
               _loc2_ += _loc5_.Exp;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function get Status() : int
      {
         return Identifier0 == 0 || Identifier1 == 0 || Identifier0 == SLogicsCore.Character.Identifier0 && Identifier1 == SLogicsCore.Character.Identifier1 ? 0 : 1;
      }
      
      public static function get currentHome() : Object
      {
         var _loc1_:int = 0;
         if(Status == 1)
         {
            _loc1_ = 0;
            while(_loc1_ < friendInfos.length)
            {
               if(friendInfos[_loc1_].Identifier0 == Identifier0 && friendInfos[_loc1_].Identifier1 == Identifier1)
               {
                  return friendInfos[_loc1_];
               }
               _loc1_++;
            }
         }
         return selfHome;
      }
      
      public static function get currentLand() : Array
      {
         var _loc1_:int = 0;
         if(Status == 1)
         {
            _loc1_ = 0;
            while(_loc1_ < friendInfos.length)
            {
               if(friendInfos[_loc1_].Identifier0 == Identifier0 && friendInfos[_loc1_].Identifier1 == Identifier1)
               {
                  return friendInfos[_loc1_].landInfo;
               }
               _loc1_++;
            }
         }
         return selfLand;
      }
      
      public static function get ConfigValue() : TBins
      {
         if(FConfigValue == null)
         {
            FConfigValue = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ConfigValue);
         }
         return FConfigValue;
      }
      
      public static function get MarryClass() : TBins
      {
         if(FMarryClass == null)
         {
            FMarryClass = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_MarryClass);
         }
         return FMarryClass;
      }
      
      public static function get RingValue() : TBins
      {
         if(FRingValue == null)
         {
            FRingValue = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_RingValue);
         }
         return FRingValue;
      }
      
      public static function get RoseTime() : Vector.<uint>
      {
         var _loc1_:TConfigValue = null;
         if(FRoseTime == null)
         {
            _loc1_ = ConfigValue.GetDatebaseByIdentifier(91100015) as TConfigValue;
            FRoseTime = _loc1_["Value"];
         }
         return FRoseTime;
      }
   }
}

