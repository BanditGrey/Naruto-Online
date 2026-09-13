package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TSkillReform extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FConditions:int;
      
      protected var FConsume:String;
      
      protected var FDescription:String;
      
      protected var FIcon:int;
      
      protected var FGetSkillId:int;
      
      protected var FReplaceSkillID:int;
      
      protected var FFrameEffect:int;
      
      protected var FProfessor:int;
      
      protected var FSubtype:int;
      
      protected var FTalentType:int;
      
      protected var FLevel:int;
      
      protected var FNextLevelId:int;
      
      protected var FNeedLevel:int;
      
      protected var FPosition:int;
      
      protected var FConsumeVector:Vector.<Array>;
      
      public function TSkillReform()
      {
         super();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Conditions() : int
      {
         return this.FConditions;
      }
      
      public function get Consume() : String
      {
         return this.FConsume;
      }
      
      public function get Description() : String
      {
         return this.FDescription;
      }
      
      public function get Icon() : int
      {
         return this.FIcon;
      }
      
      public function get GetSkillId() : int
      {
         return this.FGetSkillId;
      }
      
      public function get ReplaceSkillID() : int
      {
         return this.FReplaceSkillID;
      }
      
      public function get FrameEffect() : int
      {
         return this.FFrameEffect;
      }
      
      public function get ConsumeVector() : Vector.<Array>
      {
         return this.FConsumeVector;
      }
      
      public function get Professor() : int
      {
         return this.FProfessor;
      }
      
      public function get Subtype() : int
      {
         return this.FSubtype;
      }
      
      public function get TalentType() : int
      {
         return this.FTalentType;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get NextLevelId() : int
      {
         return this.FNextLevelId;
      }
      
      public function get NeedLevel() : int
      {
         return this.FNeedLevel;
      }
      
      public function get Position() : int
      {
         return this.FPosition;
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         TUtilityString.FlushUTF(param1,this.FName);
         param1.writeUnsignedInt(this.FConditions);
         TUtilityString.FlushUTF(param1,this.FConsume);
         TUtilityString.FlushUTF(param1,this.FDescription);
         param1.writeUnsignedInt(this.FIcon);
         param1.writeUnsignedInt(this.FGetSkillId);
         param1.writeUnsignedInt(this.FReplaceSkillID);
         param1.writeUnsignedInt(this.FFrameEffect);
         param1.writeUnsignedInt(this.FProfessor);
         param1.writeUnsignedInt(this.FSubtype);
         param1.writeUnsignedInt(this.FTalentType);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FNextLevelId);
         param1.writeUnsignedInt(this.FNeedLevel);
         param1.writeUnsignedInt(this.FPosition);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FConditions = param1.readUnsignedInt();
         this.FConsume = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FConsume);
         this.FConsumeVector = Vector.<Array>(_loc2_);
         this.FDescription = TUtilityString.FetchUTF(param1);
         this.FIcon = param1.readUnsignedInt();
         this.FGetSkillId = param1.readUnsignedInt();
         this.FReplaceSkillID = param1.readUnsignedInt();
         this.FFrameEffect = param1.readUnsignedInt();
         this.FProfessor = param1.readUnsignedInt();
         this.FSubtype = param1.readUnsignedInt();
         this.FTalentType = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FNextLevelId = param1.readUnsignedInt();
         this.FNeedLevel = param1.readUnsignedInt();
         this.FPosition = param1.readUnsignedInt();
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

