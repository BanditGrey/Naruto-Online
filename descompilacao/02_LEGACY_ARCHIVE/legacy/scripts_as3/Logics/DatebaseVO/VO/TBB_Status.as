package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TBB_Status extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FDesc:String;
      
      protected var FRarity:int;
      
      protected var FSmPic:int;
      
      protected var FMidPic:int;
      
      protected var FBigPic:int;
      
      protected var FOriginLevel:int;
      
      protected var FEvoLevel:int;
      
      protected var FExtraLevel:int;
      
      protected var FExtraAttr:String;
      
      protected var FEvoTarget:String;
      
      protected var FGetPoint:int;
      
      public function TBB_Status()
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
         TUtilityString.FlushUTF(param1,this.FName);
         TUtilityString.FlushUTF(param1,this.FDesc);
         param1.writeUnsignedInt(this.FRarity);
         param1.writeUnsignedInt(this.FSmPic);
         param1.writeUnsignedInt(this.FMidPic);
         param1.writeUnsignedInt(this.FBigPic);
         param1.writeUnsignedInt(this.FOriginLevel);
         param1.writeUnsignedInt(this.FEvoLevel);
         param1.writeUnsignedInt(this.FExtraLevel);
         TUtilityString.FlushUTF(param1,this.FExtraAttr);
         TUtilityString.FlushUTF(param1,this.FEvoTarget);
         param1.writeUnsignedInt(this.FGetPoint);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FRarity = param1.readUnsignedInt();
         this.FSmPic = param1.readUnsignedInt();
         this.FMidPic = param1.readUnsignedInt();
         this.FBigPic = param1.readUnsignedInt();
         this.FOriginLevel = param1.readUnsignedInt();
         this.FEvoLevel = param1.readUnsignedInt();
         this.FExtraLevel = param1.readUnsignedInt();
         this.FExtraAttr = TUtilityString.FetchUTF(param1);
         this.FEvoTarget = TUtilityString.FetchUTF(param1);
         this.FGetPoint = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get Rarity() : int
      {
         return this.FRarity;
      }
      
      public function get SmPic() : int
      {
         return this.FSmPic;
      }
      
      public function get MidPic() : int
      {
         return this.FMidPic;
      }
      
      public function get BigPic() : int
      {
         return this.FBigPic;
      }
      
      public function get OriginLevel() : int
      {
         return this.FOriginLevel;
      }
      
      public function get EvoLevel() : int
      {
         return this.FEvoLevel;
      }
      
      public function get ExtraLevel() : int
      {
         return this.FExtraLevel;
      }
      
      public function get ExtraAttr() : String
      {
         return this.FExtraAttr;
      }
      
      public function get EvoTarget() : String
      {
         return this.FEvoTarget;
      }
      
      public function get GetPoint() : int
      {
         return this.FGetPoint;
      }
   }
}

