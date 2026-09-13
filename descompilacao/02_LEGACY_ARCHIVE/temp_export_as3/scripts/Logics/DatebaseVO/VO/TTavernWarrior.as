package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.DatebaseVO.VO.Json.TTavernWarriorAwardSoul;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TTavernWarrior extends TDatebaseVO
   {
      
      protected var FGrade:uint;
      
      protected var FAwardId:int;
      
      protected var FReturnType:uint;
      
      protected var FReturnValue:uint;
      
      protected var FRecruitSoul:int;
      
      protected var FRecruitName:String;
      
      protected var FWinDialogue:String;
      
      protected var FLoseDialogue:String;
      
      protected var FAwardsouls:TTavernWarriorAwardSoul;
      
      protected var FAwardsoul:String;
      
      public function TTavernWarrior()
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
         param1.writeUnsignedInt(this.FGrade);
         param1.writeUnsignedInt(this.FAwardId);
         param1.writeUnsignedInt(this.FReturnType);
         param1.writeUnsignedInt(this.FReturnValue);
         param1.writeUnsignedInt(this.FRecruitSoul);
         TUtilityString.FlushUTF(param1,this.FRecruitName);
         TUtilityString.FlushUTF(param1,this.FWinDialogue);
         TUtilityString.FlushUTF(param1,this.FLoseDialogue);
         TUtilityString.FlushUTF(param1,this.FAwardsoul);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         this.FGrade = param1.readUnsignedInt();
         this.FAwardId = param1.readUnsignedInt();
         this.FReturnType = param1.readUnsignedInt();
         this.FReturnValue = param1.readUnsignedInt();
         this.FRecruitSoul = param1.readUnsignedInt();
         this.FRecruitName = TUtilityString.FetchUTF(param1);
         this.FWinDialogue = TUtilityString.FetchUTF(param1);
         this.FLoseDialogue = TUtilityString.FetchUTF(param1);
         this.FAwardsoul = TUtilityString.FetchUTF(param1);
         this.FAwardsouls = new TTavernWarriorAwardSoul(this.FAwardsoul);
      }
      
      public function get Grade() : int
      {
         return this.FGrade;
      }
      
      public function get AwardId() : int
      {
         return this.FAwardId;
      }
      
      public function get ReturnType() : int
      {
         return this.FReturnType;
      }
      
      public function get ReturnValue() : int
      {
         return this.FReturnValue;
      }
      
      public function get RecruitSoul() : int
      {
         return this.FRecruitSoul;
      }
      
      public function get RecruitName() : String
      {
         return this.FRecruitName;
      }
      
      public function get WinDialogue() : String
      {
         return this.FWinDialogue;
      }
      
      public function get LoseDialogue() : String
      {
         return this.FLoseDialogue;
      }
      
      public function get Awardsouls() : TTavernWarriorAwardSoul
      {
         return this.FAwardsouls;
      }
      
      public function get Awardsoul() : String
      {
         return this.FAwardsoul;
      }
   }
}

