package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TNewornament_battle extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FBossName:String;
      
      protected var FLocation:uint;
      
      protected var FSStage:uint;
      
      protected var FSStageID:uint;
      
      protected var FImage:uint;
      
      protected var FBaseAward:String;
      
      protected var FGoldAward:String;
      
      protected var FBaseAwardItem:Vector.<Object>;
      
      protected var FGoldAwardItem:Vector.<Object>;
      
      public function TNewornament_battle()
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
         TUtilityString.FlushUTF(param1,this.FBossName);
         param1.writeUnsignedInt(this.FLocation);
         param1.writeUnsignedInt(this.FSStage);
         param1.writeUnsignedInt(this.FSStageID);
         param1.writeUnsignedInt(this.FImage);
         TUtilityString.FlushUTF(param1,this.FBaseAward);
         TUtilityString.FlushUTF(param1,this.FGoldAward);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FBossName = TUtilityString.FetchUTF(param1);
         this.FLocation = param1.readUnsignedInt();
         this.FSStage = param1.readUnsignedInt();
         this.FSStageID = param1.readUnsignedInt();
         this.FImage = param1.readUnsignedInt();
         this.FBaseAward = TUtilityString.FetchUTF(param1);
         this.FGoldAward = TUtilityString.FetchUTF(param1);
         this.FBaseAwardItem = Vector.<Object>(Json.decode(this.FBaseAward));
         this.FGoldAwardItem = Vector.<Object>(Json.decode(this.FGoldAward));
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get BossName() : String
      {
         return this.FBossName;
      }
      
      public function get Location() : uint
      {
         return this.FLocation;
      }
      
      public function get SStage() : uint
      {
         return this.FSStage;
      }
      
      public function get SStageID() : uint
      {
         return this.FSStageID;
      }
      
      public function get Image() : uint
      {
         return this.FImage;
      }
      
      public function get BaseAward() : String
      {
         return this.FBaseAward;
      }
      
      public function get GoldAward() : String
      {
         return this.FGoldAward;
      }
      
      public function get BaseAwardItem() : Vector.<Object>
      {
         return this.FBaseAwardItem;
      }
      
      public function get GoldAwardItem() : Vector.<Object>
      {
         return this.FGoldAwardItem;
      }
   }
}

