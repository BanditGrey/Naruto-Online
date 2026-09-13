package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TChallengeMall extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FItemid:int;
      
      protected var FIntegration:int;
      
      protected var FAmount:int;
      
      protected var FPage:int;
      
      protected var FTimes:int;
      
      public function TChallengeMall()
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
         param1.writeUnsignedInt(this.FItemid);
         param1.writeUnsignedInt(this.FIntegration);
         param1.writeUnsignedInt(this.FAmount);
         param1.writeUnsignedInt(this.FPage);
         param1.writeUnsignedInt(this.FTimes);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FItemid = param1.readUnsignedInt();
         this.FIntegration = param1.readUnsignedInt();
         this.FAmount = param1.readUnsignedInt();
         this.FPage = param1.readUnsignedInt();
         this.FTimes = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Itemid() : int
      {
         return this.FItemid;
      }
      
      public function get Integration() : int
      {
         return this.FIntegration;
      }
      
      public function get Amount() : int
      {
         return this.FAmount;
      }
      
      public function get Page() : int
      {
         return this.FPage;
      }
      
      public function get Times() : int
      {
         return this.FTimes;
      }
   }
}

