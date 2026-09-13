package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TChannelChet extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FAllowSend:int;
      
      protected var FHasCooldown:int;
      
      protected var FCoolTime:int;
      
      protected var FTargetType:int;
      
      protected var FAllowShow:Boolean;
      
      protected var FTextColor:String;
      
      protected var FIsChannel:Boolean;
      
      protected var FCanUseIds:Vector.<uint>;
      
      protected var FNeedAuth:Boolean;
      
      protected var FLevelAnalog:int;
      
      protected var FCanUseId:String;
      
      public function TChannelChet()
      {
         super();
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
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FAllowSend);
         param1.writeUnsignedInt(this.FHasCooldown);
         param1.writeUnsignedInt(this.FCoolTime);
         param1.writeUnsignedInt(this.FTargetType);
         param1.writeBoolean(this.FAllowShow);
         TUtilityString.FlushUTF(param1,this.FTextColor);
         param1.writeBoolean(this.FIsChannel);
         TUtilityString.FlushUTF(param1,this.FCanUseId);
         param1.writeBoolean(this.FNeedAuth);
         param1.writeUnsignedInt(this.FLevelAnalog);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FAllowSend = param1.readUnsignedInt();
         this.FHasCooldown = param1.readUnsignedInt();
         this.FCoolTime = param1.readUnsignedInt();
         this.FTargetType = param1.readUnsignedInt();
         this.FAllowShow = param1.readBoolean();
         this.FTextColor = TUtilityString.FetchUTF(param1);
         this.FIsChannel = param1.readBoolean();
         this.FCanUseId = TUtilityString.FetchUTF(param1);
         _loc3_ = 0;
         if(!TUtilityString.Empty(this.FCanUseId))
         {
            _loc4_ = this.FCanUseId.split("|");
            _loc3_ = int(_loc4_.length);
         }
         this.FCanUseIds = new Vector.<uint>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FCanUseIds[_loc2_] = _loc4_[_loc2_];
            _loc2_++;
         }
         this.FNeedAuth = param1.readBoolean();
         this.FLevelAnalog = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get AllowSend() : int
      {
         return this.FAllowSend;
      }
      
      public function get HasCooldown() : int
      {
         return this.FHasCooldown;
      }
      
      public function get CoolTime() : int
      {
         return this.FCoolTime;
      }
      
      public function get TargetType() : int
      {
         return this.FTargetType;
      }
      
      public function get AllowShow() : Boolean
      {
         return this.FAllowShow;
      }
      
      public function get TextColor() : String
      {
         return this.FTextColor;
      }
      
      public function get IsChannel() : Boolean
      {
         return this.FIsChannel;
      }
      
      public function get CanUseIds() : Vector.<uint>
      {
         return this.FCanUseIds;
      }
      
      public function get NeedAuth() : Boolean
      {
         return this.FNeedAuth;
      }
      
      public function get LevelAnalog() : int
      {
         return this.FLevelAnalog;
      }
      
      public function get CanUseId() : String
      {
         return this.FCanUseId;
      }
   }
}

