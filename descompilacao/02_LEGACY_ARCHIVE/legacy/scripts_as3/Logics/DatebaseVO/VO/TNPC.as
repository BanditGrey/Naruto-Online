package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TNPC extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FNpcTitle:String;
      
      protected var FTalk:String;
      
      protected var FStartTime:int;
      
      protected var FEndTime:int;
      
      protected var FCityid:int;
      
      protected var FUserType:int;
      
      protected var FX:int;
      
      protected var FY:int;
      
      public function TNPC()
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
         TUtilityString.FlushUTF(param1,this.FNpcTitle);
         TUtilityString.FlushUTF(param1,this.FTalk);
         param1.writeUnsignedInt(this.FStartTime);
         param1.writeUnsignedInt(this.FEndTime);
         param1.writeUnsignedInt(this.FCityid);
         param1.writeUnsignedInt(this.FUserType);
         param1.writeUnsignedInt(this.FX);
         param1.writeUnsignedInt(this.FY);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FNpcTitle = TUtilityString.FetchUTF(param1);
         this.FTalk = TUtilityString.FetchUTF(param1);
         this.FStartTime = param1.readUnsignedInt();
         this.FEndTime = param1.readUnsignedInt();
         this.FCityid = param1.readUnsignedInt();
         this.FUserType = param1.readUnsignedInt();
         this.FX = param1.readUnsignedInt();
         this.FY = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get NpcTitle() : String
      {
         return this.FNpcTitle;
      }
      
      public function get Talk() : String
      {
         return this.FTalk;
      }
      
      public function get StartTime() : int
      {
         return this.FStartTime;
      }
      
      public function get EndTime() : int
      {
         return this.FEndTime;
      }
      
      public function get Cityid() : int
      {
         return this.FCityid;
      }
      
      public function get UserType() : int
      {
         return this.FUserType;
      }
      
      public function get X() : int
      {
         return this.FX;
      }
      
      public function get Y() : int
      {
         return this.FY;
      }
   }
}

