package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.*;
   import Foundation.Utilities.*;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import flash.utils.*;
   import ghostcat.util.data.*;
   
   use namespace ResourcesSpace;
   
   public class TOrganizationAddition extends TDatebaseVO
   {
      
      protected var FOrgLevel:uint;
      
      protected var FAtkAddition:uint;
      
      protected var FAtkConsume:uint;
      
      protected var FPhysDefAddition:uint;
      
      protected var FPhysDefConsume:uint;
      
      protected var FMagDefAddition:uint;
      
      protected var FMagDefConsume:uint;
      
      protected var FLifeAddition:uint;
      
      protected var FLifeConsume:uint;
      
      protected var FSpeedAddition:uint;
      
      protected var FSpeedConsume:uint;
      
      public function TOrganizationAddition()
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
         param1.writeUnsignedInt(this.FOrgLevel);
         param1.writeUnsignedInt(this.FAtkAddition);
         param1.writeUnsignedInt(this.FAtkConsume);
         param1.writeUnsignedInt(this.FPhysDefAddition);
         param1.writeUnsignedInt(this.FPhysDefConsume);
         param1.writeUnsignedInt(this.FMagDefAddition);
         param1.writeUnsignedInt(this.FMagDefConsume);
         param1.writeUnsignedInt(this.FLifeAddition);
         param1.writeUnsignedInt(this.FLifeConsume);
         param1.writeUnsignedInt(this.FSpeedAddition);
         param1.writeUnsignedInt(this.FSpeedConsume);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         this.FOrgLevel = param1.readUnsignedInt();
         this.FAtkAddition = param1.readUnsignedInt();
         this.FAtkConsume = param1.readUnsignedInt();
         this.FPhysDefAddition = param1.readUnsignedInt();
         this.FPhysDefConsume = param1.readUnsignedInt();
         this.FMagDefAddition = param1.readUnsignedInt();
         this.FMagDefConsume = param1.readUnsignedInt();
         this.FLifeAddition = param1.readUnsignedInt();
         this.FLifeConsume = param1.readUnsignedInt();
         this.FSpeedAddition = param1.readUnsignedInt();
         this.FSpeedConsume = param1.readUnsignedInt();
      }
      
      public function get OrgLevel() : uint
      {
         return this.FOrgLevel;
      }
      
      public function get AtkAddition() : uint
      {
         return this.FAtkAddition;
      }
      
      public function get AtkConsume() : uint
      {
         return this.FAtkConsume;
      }
      
      public function get PhysDefAddition() : uint
      {
         return this.FPhysDefAddition;
      }
      
      public function get MagDefAddition() : uint
      {
         return this.FMagDefAddition;
      }
      
      public function get MagDefConsume() : uint
      {
         return this.FMagDefConsume;
      }
      
      public function get LifeAddition() : uint
      {
         return this.FLifeAddition;
      }
      
      public function get LifeConsume() : uint
      {
         return this.FLifeConsume;
      }
      
      public function get SpeedAddition() : uint
      {
         return this.FSpeedAddition;
      }
      
      public function get SpeedConsume() : uint
      {
         return this.FSpeedConsume;
      }
      
      public function get PhysDefConsume() : uint
      {
         return this.FPhysDefConsume;
      }
   }
}

