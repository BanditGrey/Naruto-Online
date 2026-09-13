package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TLeaguePointPath extends TDatebaseVO
   {
      
      protected var FArmy:String;
      
      protected var FPicture:String;
      
      protected var FRemarks:String;
      
      protected var FMapname:int;
      
      protected var FAramyVect:Vector.<uint>;
      
      protected var FPictureVect:Vector.<uint>;
      
      public function TLeaguePointPath()
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
         TUtilityString.FlushUTF(param1,this.FArmy);
         TUtilityString.FlushUTF(param1,this.FPicture);
         TUtilityString.FlushUTF(param1,this.FRemarks);
         param1.writeUnsignedInt(this.FMapname);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         this.FArmy = TUtilityString.FetchUTF(param1);
         _loc6_ = Json.decode(this.FArmy);
         _loc5_ = _loc6_["army"];
         _loc3_ = int(_loc5_.length);
         this.FAramyVect = new Vector.<uint>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            this.FAramyVect[_loc2_] = _loc5_[_loc2_];
            _loc2_++;
         }
         this.FPicture = TUtilityString.FetchUTF(param1);
         _loc5_ = Json.decode(this.FPicture);
         this.FPictureVect = new Vector.<uint>(_loc5_);
         this.FRemarks = TUtilityString.FetchUTF(param1);
         this.FMapname = param1.readUnsignedInt();
      }
      
      public function get Army() : String
      {
         return this.FArmy;
      }
      
      public function get AramyVect() : Vector.<uint>
      {
         return this.FAramyVect;
      }
      
      public function get Picture() : String
      {
         return this.FPicture;
      }
      
      public function get PictureVect() : Vector.<uint>
      {
         return this.FPictureVect;
      }
      
      public function get Remarks() : String
      {
         return this.FRemarks;
      }
      
      public function get Mapname() : uint
      {
         return this.FMapname;
      }
   }
}

