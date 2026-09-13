package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TEnemy extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FType:int;
      
      protected var FProfession:int;
      
      protected var FQuality:int;
      
      protected var FLevel:int;
      
      protected var FSex:int;
      
      protected var FHp:int;
      
      protected var FSpeed:int;
      
      protected var FAnger:int;
      
      protected var FState:int;
      
      protected var FNormal:int;
      
      protected var FSkill:int;
      
      protected var FEffects:String;
      
      protected var FTalentId:int;
      
      protected var FIsBoss:Boolean;
      
      protected var FSoundid:uint;
      
      protected var FSkillsound:uint;
      
      public function TEnemy()
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
         param1.writeUnsignedInt(this.FType);
         param1.writeUnsignedInt(this.FProfession);
         param1.writeUnsignedInt(this.FQuality);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FSex);
         param1.writeUnsignedInt(this.FHp);
         param1.writeUnsignedInt(this.FSpeed);
         param1.writeUnsignedInt(this.FAnger);
         param1.writeUnsignedInt(this.FState);
         param1.writeUnsignedInt(this.FNormal);
         param1.writeUnsignedInt(this.FSkill);
         TUtilityString.FlushUTF(param1,this.FEffects);
         param1.writeUnsignedInt(this.FTalentId);
         param1.writeUnsignedInt(int(this.FIsBoss));
         param1.writeUnsignedInt(this.FSoundid);
         param1.writeUnsignedInt(this.FSkillsound);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FName = TUtilityString.FetchUTF(param1);
         this.FType = param1.readUnsignedInt();
         this.FProfession = param1.readUnsignedInt();
         this.FQuality = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FSex = param1.readUnsignedInt();
         this.FHp = param1.readUnsignedInt();
         this.FSpeed = param1.readUnsignedInt();
         this.FAnger = param1.readUnsignedInt();
         this.FState = param1.readUnsignedInt();
         this.FNormal = param1.readUnsignedInt();
         this.FSkill = param1.readUnsignedInt();
         this.FEffects = TUtilityString.FetchUTF(param1);
         this.FTalentId = param1.readUnsignedInt();
         this.FIsBoss = Boolean(param1.readUnsignedInt());
         this.FSoundid = param1.readUnsignedInt();
         this.FSkillsound = param1.readUnsignedInt();
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function get Profession() : int
      {
         return this.FProfession;
      }
      
      public function get Quality() : int
      {
         return this.FQuality;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get Sex() : int
      {
         return this.FSex;
      }
      
      public function get Hp() : int
      {
         return this.FHp;
      }
      
      public function get Speed() : int
      {
         return this.FSpeed;
      }
      
      public function get Anger() : int
      {
         return this.FAnger;
      }
      
      public function get State() : int
      {
         return this.FState;
      }
      
      public function get Normal() : int
      {
         return this.FNormal;
      }
      
      public function get Skill() : int
      {
         return this.FSkill;
      }
      
      public function get Effects() : String
      {
         return this.FEffects;
      }
      
      public function get TalentId() : int
      {
         return this.FTalentId;
      }
      
      public function get IsBoss() : Boolean
      {
         return this.FIsBoss;
      }
      
      public function get Soundid() : uint
      {
         return this.FSoundid;
      }
      
      public function get Skillsound() : uint
      {
         return this.FSkillsound;
      }
      
      public function set Effects(param1:String) : void
      {
      }
   }
}

