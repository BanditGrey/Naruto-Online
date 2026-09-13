package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TMazeconfig extends TDatebaseVO
   {
      
      protected var FEventName:String;
      
      protected var FEventType:uint;
      
      protected var FIsChange:uint;
      
      protected var FIsSkip:uint;
      
      protected var FWinRate:uint;
      
      protected var FFightNpc:uint;
      
      protected var FAddAction:int;
      
      protected var FEventDescribe:String;
      
      protected var FIcon:uint;
      
      public function TMazeconfig()
      {
         super();
      }
      
      public function get EventName() : String
      {
         return this.FEventName;
      }
      
      public function get EventType() : uint
      {
         return this.FEventType;
      }
      
      public function get IsChange() : uint
      {
         return this.FIsChange;
      }
      
      public function get IsSkip() : uint
      {
         return this.FIsSkip;
      }
      
      public function get FightNpc() : uint
      {
         return this.FFightNpc;
      }
      
      public function get AddAction() : int
      {
         return this.FAddAction;
      }
      
      public function get EventDescribe() : String
      {
         return this.FEventDescribe;
      }
      
      public function get Icon() : uint
      {
         return this.FIcon;
      }
      
      public function get WinRate() : uint
      {
         return this.FWinRate;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FEventName);
         param1.writeUnsignedInt(this.FEventType);
         param1.writeUnsignedInt(this.FIsChange);
         param1.writeUnsignedInt(this.FIsSkip);
         param1.writeUnsignedInt(this.FFightNpc);
         param1.writeInt(this.FAddAction);
         TUtilityString.FlushUTF(param1,this.FEventDescribe);
         param1.writeInt(this.FIcon);
         param1.writeInt(this.FWinRate);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FEventName = TUtilityString.FetchUTF(param1);
         this.FEventType = param1.readUnsignedInt();
         this.FIsChange = param1.readUnsignedInt();
         this.FIsSkip = param1.readUnsignedInt();
         this.FFightNpc = param1.readUnsignedInt();
         this.FAddAction = param1.readInt();
         this.FEventDescribe = TUtilityString.FetchUTF(param1);
         this.FIcon = param1.readInt();
         this.FWinRate = param1.readInt();
      }
      
      override ResourcesSpace function ReadDataByXml(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc5_ = uint(param1.elements().length());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = param1.elements()[_loc6_];
            _loc3_ = String(_loc2_.name());
            _loc4_ = _loc2_;
            if(_loc3_ == "id")
            {
               Coerce(uint(_loc4_));
            }
            else
            {
               _loc3_ = "F" + _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = "F" + _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
                  }
                  if(hasOwnProperty(_loc3_.slice(1)))
                  {
                     if(this[_loc3_] is Boolean)
                     {
                        this[_loc3_] = Boolean(int(_loc4_));
                     }
                     else
                     {
                        this[_loc3_] = _loc4_;
                     }
                  }
               }
            }
            _loc6_++;
         }
      }
   }
}

