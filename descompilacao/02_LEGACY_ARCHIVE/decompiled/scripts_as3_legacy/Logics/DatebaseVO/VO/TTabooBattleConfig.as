package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TTabooBattleConfig extends TDatebaseVO
   {
      
      protected var FCampaignName:String;
      
      protected var FStageStartId:int;
      
      protected var FPicID:int;
      
      protected var FOpenLevel:int;
      
      protected var FCampaignCount:int;
      
      protected var FMissionTips:String;
      
      public function TTabooBattleConfig()
      {
         super();
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FCampaignName);
         param1.writeUnsignedInt(this.FStageStartId);
         param1.writeUnsignedInt(this.FPicID);
         param1.writeUnsignedInt(this.FOpenLevel);
         param1.writeUnsignedInt(this.FCampaignCount);
         TUtilityString.FlushUTF(param1,this.FMissionTips);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FCampaignName = TUtilityString.FetchUTF(param1);
         this.FStageStartId = param1.readUnsignedInt();
         this.FPicID = param1.readUnsignedInt();
         this.FOpenLevel = param1.readUnsignedInt();
         this.FCampaignCount = param1.readUnsignedInt();
         this.FMissionTips = TUtilityString.FetchUTF(param1);
      }
      
      public function get CampaignName() : String
      {
         return this.FCampaignName;
      }
      
      public function get StageStartId() : int
      {
         return this.FStageStartId;
      }
      
      public function get PicID() : int
      {
         return this.FPicID;
      }
      
      public function get OpenLevel() : int
      {
         return this.FOpenLevel;
      }
      
      public function get CampaignCount() : int
      {
         return this.FCampaignCount;
      }
      
      public function get MissionTips() : String
      {
         return this.FMissionTips;
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

