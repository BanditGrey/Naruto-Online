package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TNinjiaRecommend extends TDatebaseVO
   {
      
      protected var FNinjia:String;
      
      protected var FAvatar:int;
      
      protected var FLevel:int;
      
      protected var FDesc:String;
      
      protected var FSource:String;
      
      protected var FJump:uint;
      
      protected var FPage:uint;
      
      public function TNinjiaRecommend()
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
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FNinjia);
         param1.writeUnsignedInt(this.FAvatar);
         param1.writeUnsignedInt(this.FLevel);
         TUtilityString.FlushUTF(param1,this.FDesc);
         TUtilityString.FlushUTF(param1,this.FSource);
         param1.writeUnsignedInt(this.FJump);
         param1.writeUnsignedInt(this.FPage);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FNinjia = TUtilityString.FetchUTF(param1);
         this.FAvatar = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FSource = TUtilityString.FetchUTF(param1);
         this.FJump = param1.readUnsignedInt();
         this.FPage = param1.readUnsignedInt();
      }
      
      public function get Ninjia() : String
      {
         return this.FNinjia;
      }
      
      public function set Ninjia(param1:String) : void
      {
         this.FNinjia = param1;
      }
      
      public function get Avatar() : int
      {
         return this.FAvatar;
      }
      
      public function set Avatar(param1:int) : void
      {
         this.FAvatar = param1;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function set Level(param1:int) : void
      {
         this.FLevel = param1;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function set Desc(param1:String) : void
      {
         this.FDesc = param1;
      }
      
      public function get Source() : String
      {
         return this.FSource;
      }
      
      public function set Source(param1:String) : void
      {
         this.FSource = param1;
      }
      
      public function get Jump() : uint
      {
         return this.FJump;
      }
      
      public function set Jump(param1:uint) : void
      {
         this.FJump = param1;
      }
      
      public function get Page() : uint
      {
         return this.FPage;
      }
      
      public function set Page(param1:uint) : void
      {
         this.FPage = param1;
      }
   }
}

