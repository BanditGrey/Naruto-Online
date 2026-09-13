package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TPlatformID extends TDatebaseVO
   {
      
      protected var FPlatform:String;
      
      protected var FBecomeMemberURL:String;
      
      protected var FYearMemberURL:String;
      
      protected var FMemberDescURL:String;
      
      protected var FOpen:uint;
      
      public function TPlatformID()
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
         TUtilityString.FlushUTF(param1,this.FPlatform);
         param1.writeUnsignedInt(this.FOpen);
         TUtilityString.FlushUTF(param1,this.FBecomeMemberURL);
         TUtilityString.FlushUTF(param1,this.FYearMemberURL);
         TUtilityString.FlushUTF(param1,this.FMemberDescURL);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FPlatform = TUtilityString.FetchUTF(param1);
         this.FOpen = param1.readUnsignedInt();
         this.FBecomeMemberURL = TUtilityString.FetchUTF(param1);
         this.FYearMemberURL = TUtilityString.FetchUTF(param1);
         this.FMemberDescURL = TUtilityString.FetchUTF(param1);
      }
      
      public function get Platform() : String
      {
         return this.FPlatform;
      }
      
      public function set Platform(param1:String) : void
      {
         this.FPlatform = param1;
      }
      
      public function get Open() : uint
      {
         return this.FOpen;
      }
      
      public function set Open(param1:uint) : void
      {
         this.FOpen = param1;
      }
      
      public function get BecomeMemberURL() : String
      {
         return this.FBecomeMemberURL;
      }
      
      public function set BecomeMemberURL(param1:String) : void
      {
         this.FBecomeMemberURL = param1;
      }
      
      public function get YearMemberURL() : String
      {
         return this.FYearMemberURL;
      }
      
      public function set YearMemberURL(param1:String) : void
      {
         this.FYearMemberURL = param1;
      }
      
      public function get MemberDescURL() : String
      {
         return this.FMemberDescURL;
      }
      
      public function set MemberDescURL(param1:String) : void
      {
         this.FMemberDescURL = param1;
      }
   }
}

