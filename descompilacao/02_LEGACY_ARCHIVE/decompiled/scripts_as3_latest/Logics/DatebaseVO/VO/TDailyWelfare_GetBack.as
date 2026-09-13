package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TDailyWelfare_GetBack extends TDatebaseVO
   {
      
      public static const TYPE_SILVER:String = "Silver";
      
      public static const TYPE_EXP:String = "Exp";
      
      protected var FMonster_Silver:int;
      
      protected var FMonster_Exp:int;
      
      protected var FOrgBattle_Silver:int;
      
      protected var FOrgBattle_Exp:int;
      
      protected var FOrgDefence_Silver:int;
      
      protected var FOrgDefence_Exp:int;
      
      protected var FTraitor_Silver:int;
      
      protected var FTraitor_Exp:int;
      
      protected var FTeambattle_Points:int;
      
      protected var FTeambattle_Exp:int;
      
      protected var FSilverVect:Vector.<uint>;
      
      protected var FExpVect:Vector.<uint>;
      
      public function TDailyWelfare_GetBack()
      {
         super();
         this.FSilverVect = new Vector.<uint>();
         this.FExpVect = new Vector.<uint>();
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
         param1.writeUnsignedInt(this.FMonster_Silver);
         param1.writeUnsignedInt(this.FMonster_Exp);
         param1.writeUnsignedInt(this.FOrgBattle_Silver);
         param1.writeUnsignedInt(this.FOrgBattle_Exp);
         param1.writeUnsignedInt(this.FOrgDefence_Silver);
         param1.writeUnsignedInt(this.FOrgDefence_Exp);
         param1.writeUnsignedInt(this.FTraitor_Silver);
         param1.writeUnsignedInt(this.FTraitor_Exp);
         param1.writeUnsignedInt(this.FTeambattle_Points);
         param1.writeUnsignedInt(this.FTeambattle_Exp);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FMonster_Silver = param1.readUnsignedInt();
         this.FMonster_Exp = param1.readUnsignedInt();
         this.FOrgBattle_Silver = param1.readUnsignedInt();
         this.FOrgBattle_Exp = param1.readUnsignedInt();
         this.FOrgDefence_Silver = param1.readUnsignedInt();
         this.FOrgDefence_Exp = param1.readUnsignedInt();
         this.FTraitor_Silver = param1.readUnsignedInt();
         this.FTraitor_Exp = param1.readUnsignedInt();
         this.FTeambattle_Points = param1.readUnsignedInt();
         this.FTeambattle_Exp = param1.readUnsignedInt();
         this.FSilverVect.push(this.FMonster_Silver);
         this.FSilverVect.push(this.FOrgBattle_Silver);
         this.FSilverVect.push(this.FOrgDefence_Silver);
         this.FSilverVect.push(this.FTraitor_Silver);
         this.FSilverVect.push(this.FTeambattle_Points);
         this.FExpVect.push(this.FMonster_Exp);
         this.FExpVect.push(this.FOrgBattle_Exp);
         this.FExpVect.push(this.FOrgDefence_Exp);
         this.FExpVect.push(this.FTraitor_Exp);
         this.FExpVect.push(this.FTeambattle_Exp);
      }
      
      public function get Monster_Silver() : int
      {
         return this.FMonster_Silver;
      }
      
      public function get Monster_Exp() : int
      {
         return this.FMonster_Exp;
      }
      
      public function get OrgBattle_Silver() : int
      {
         return this.FOrgBattle_Silver;
      }
      
      public function get OrgBattle_Exp() : int
      {
         return this.FOrgBattle_Exp;
      }
      
      public function get OrgDefence_Silver() : int
      {
         return this.FOrgDefence_Silver;
      }
      
      public function get OrgDefence_Exp() : int
      {
         return this.FOrgDefence_Exp;
      }
      
      public function get Traitor_Silver() : int
      {
         return this.FTraitor_Silver;
      }
      
      public function get Traitor_Exp() : int
      {
         return this.FTraitor_Exp;
      }
      
      public function get Teambattle_Points() : int
      {
         return this.FTeambattle_Points;
      }
      
      public function get Teambattle_Exp() : int
      {
         return this.FTeambattle_Exp;
      }
      
      public function GetDateBySortKey(param1:uint, param2:String) : uint
      {
         var _loc3_:uint = 0;
         _loc3_ = 0;
         if(param2 == TYPE_SILVER)
         {
            _loc3_ = this.FSilverVect[param1];
         }
         else
         {
            _loc3_ = this.FExpVect[param1];
         }
         return _loc3_;
      }
   }
}

