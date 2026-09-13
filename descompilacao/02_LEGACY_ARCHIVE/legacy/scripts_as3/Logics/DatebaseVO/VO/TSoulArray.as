package Logics.DatebaseVO.VO
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SOULFORMATION;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TSoulArray extends TDatebaseVO
   {
      
      public var name:String;
      
      public var level:int;
      
      public var levelDescription:String;
      
      public var needExp:int;
      
      public var type:int;
      
      public var resource:int;
      
      public var active:String;
      
      public var attackEffect:String;
      
      public var attackEffect1:String;
      
      public var condition:String;
      
      public var forwardAddition:String;
      
      public var middleAddition:String;
      
      public var backAddition:String;
      
      public var skillName:String;
      
      public var CurExp:int;
      
      public var Status:int;
      
      public function TSoulArray()
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
               _loc3_ = _loc3_;
               if(hasOwnProperty(_loc3_))
               {
                  this[_loc3_] = _loc4_;
               }
               else
               {
                  if(Count_AttributeName.indexOf(_loc3_.slice(1,2)) < 0)
                  {
                     _loc3_ = _loc3_.slice(1,2).toLocaleUpperCase() + _loc3_.slice(2);
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
         TUtilityString.FlushUTF(param1,this.name);
         param1.writeUnsignedInt(this.level);
         TUtilityString.FlushUTF(param1,this.levelDescription);
         param1.writeUnsignedInt(this.needExp);
         param1.writeUnsignedInt(this.type);
         param1.writeUnsignedInt(this.resource);
         TUtilityString.FlushUTF(param1,this.active);
         TUtilityString.FlushUTF(param1,this.attackEffect);
         TUtilityString.FlushUTF(param1,this.attackEffect1);
         TUtilityString.FlushUTF(param1,this.condition);
         TUtilityString.FlushUTF(param1,this.forwardAddition);
         TUtilityString.FlushUTF(param1,this.middleAddition);
         TUtilityString.FlushUTF(param1,this.backAddition);
         TUtilityString.FlushUTF(param1,this.skillName);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.name = TUtilityString.FetchUTF(param1);
         this.level = param1.readUnsignedInt();
         this.levelDescription = TUtilityString.FetchUTF(param1);
         this.needExp = param1.readUnsignedInt();
         this.type = param1.readUnsignedInt();
         this.resource = param1.readUnsignedInt();
         this.active = TUtilityString.FetchUTF(param1);
         this.attackEffect = TUtilityString.FetchUTF(param1);
         this.attackEffect1 = TUtilityString.FetchUTF(param1);
         this.condition = TUtilityString.FetchUTF(param1);
         this.forwardAddition = TUtilityString.FetchUTF(param1);
         this.middleAddition = TUtilityString.FetchUTF(param1);
         this.backAddition = TUtilityString.FetchUTF(param1);
         this.skillName = TUtilityString.FetchUTF(param1);
      }
      
      public function get SkillName() : String
      {
         return this.skillName;
      }
      
      public function SkillDescByIndex(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         _loc4_ = Json.decode(this.active);
         _loc3_ = int(_loc4_[param1][1]);
         return (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SkillConfig,_loc3_) as TSkillConfig).Desc;
      }
      
      public function get OpenCondition() : String
      {
         var _loc1_:Array = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         _loc1_ = Json.decode(this.condition);
         switch(_loc1_[0])
         {
            case 1:
               _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0010).DescribeString;
               _loc2_ = TUtilityString.Format(new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0010).DescribeString,STRING_COMMON.GetLevelStrByLevelLineFeed(_loc1_[1]));
               break;
            case 2:
               _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0011).DescribeString;
               _loc2_ = TUtilityString.Format(_loc2_,STRING_COMMON.GetItemNameByType(1,_loc1_[1]),_loc1_[2]);
               break;
            case 3:
               _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0012).DescribeString;
               _loc3_ = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SevenHeroArmy,_loc1_[1]) as TSevenHeroArmy).Name;
               _loc2_ = TUtilityString.Format(_loc2_,_loc3_);
               break;
            case 4:
               _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0013).DescribeString;
               _loc2_ = TUtilityString.Format(_loc2_,_loc1_[1]);
               break;
            case 5:
               _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_0014).DescribeString;
               _loc2_ = TUtilityString.Format(_loc2_,_loc1_[1]);
               break;
            default:
               _loc2_ = "";
         }
         return _loc2_;
      }
   }
}

