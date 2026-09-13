package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TLostsacredGenerate extends TDatebaseVO
   {
      
      protected var FArtifactId:uint;
      
      protected var FNeedTreasurelevel:uint;
      
      protected var FCostlostItemCount:uint;
      
      public function TLostsacredGenerate()
      {
         super();
      }
      
      public function get ArtifactId() : uint
      {
         return this.FArtifactId;
      }
      
      public function get NeedTreasurelevel() : uint
      {
         return this.FNeedTreasurelevel;
      }
      
      public function get CostlostItemCount() : uint
      {
         return this.FCostlostItemCount;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FArtifactId);
         param1.writeUnsignedInt(this.FNeedTreasurelevel);
         param1.writeUnsignedInt(this.FCostlostItemCount);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FArtifactId = param1.readUnsignedInt();
         this.FNeedTreasurelevel = param1.readUnsignedInt();
         this.FCostlostItemCount = param1.readUnsignedInt();
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

