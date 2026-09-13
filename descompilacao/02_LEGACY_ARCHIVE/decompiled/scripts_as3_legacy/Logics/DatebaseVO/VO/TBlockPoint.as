package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Logics.SLogicsCore;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TBlockPoint extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FCampaign:uint;
      
      protected var FLast:int;
      
      protected var FLevel:int;
      
      protected var FTransLevel:int;
      
      protected var FNextPoint:int;
      
      protected var FArmys:Vector.<uint>;
      
      protected var FTollgatIcon:uint;
      
      protected var FBossIcon:int;
      
      protected var FBigImage:int;
      
      protected var FDesc:String;
      
      protected var FPopTipIds:Vector.<Array>;
      
      protected var FTaskId:String;
      
      protected var FTaskIdArr:Array;
      
      protected var FArmy:String;
      
      protected var FPop:String;
      
      public function TBlockPoint()
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
         param1.writeUnsignedInt(this.FCampaign);
         param1.writeUnsignedInt(this.FLast);
         param1.writeUnsignedInt(this.FLevel);
         param1.writeUnsignedInt(this.FTransLevel);
         param1.writeUnsignedInt(this.FNextPoint);
         TUtilityString.FlushUTF(param1,this.FArmy);
         param1.writeUnsignedInt(this.FTollgatIcon);
         param1.writeUnsignedInt(this.FBossIcon);
         param1.writeUnsignedInt(this.FBigImage);
         TUtilityString.FlushUTF(param1,this.FDesc);
         TUtilityString.FlushUTF(param1,this.FPop);
         TUtilityString.FlushUTF(param1,this.FTaskId);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FCampaign = param1.readUnsignedInt();
         this.FLast = param1.readUnsignedInt();
         this.FLevel = param1.readUnsignedInt();
         this.FTransLevel = param1.readUnsignedInt();
         this.FNextPoint = param1.readUnsignedInt();
         this.FArmy = TUtilityString.FetchUTF(param1);
         _loc3_ = Json.decode(this.FArmy);
         this.FArmys = Vector.<uint>(_loc3_.army);
         this.FTollgatIcon = param1.readUnsignedInt();
         this.FBossIcon = param1.readUnsignedInt();
         this.FBigImage = param1.readUnsignedInt();
         this.FDesc = TUtilityString.FetchUTF(param1);
         this.FPop = TUtilityString.FetchUTF(param1);
         _loc2_ = Json.decode(this.FPop);
         this.FPopTipIds = Vector.<Array>(_loc2_);
         this.FTaskId = TUtilityString.FetchUTF(param1);
         this.FTaskIdArr = Json.decode(this.FTaskId);
      }
      
      public function get TaskIdArr() : Array
      {
         return this.FTaskIdArr;
      }
      
      public function get TaskId() : String
      {
         return this.FTaskId;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Last() : int
      {
         return this.FLast;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function get BossIcon() : int
      {
         return this.FBossIcon;
      }
      
      public function get BigImage() : int
      {
         return this.FBigImage;
      }
      
      public function get Campaign() : uint
      {
         return this.FCampaign;
      }
      
      public function get LvDec() : String
      {
         var _loc1_:String = "";
         if(SLogicsCore.Character.MainHero.ReincarnationOneOrTwo > 0)
         {
            _loc1_ = SLogicsCore.Character.MainHero.GetOnlyLevelStrByLevelCopy(this.FTransLevel);
         }
         else
         {
            _loc1_ = this.FLevel.toString();
         }
         return _loc1_;
      }
      
      public function get LevelCopy() : int
      {
         if(SLogicsCore.Character.MainHero.ReincarnationOneOrTwo > 0)
         {
            return this.FTransLevel;
         }
         return this.FLevel;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function get TransLevel() : int
      {
         return this.FTransLevel;
      }
      
      public function get NextPoint() : int
      {
         return this.FNextPoint;
      }
      
      public function get TollgatIcon() : uint
      {
         return this.FTollgatIcon;
      }
      
      public function get PopTipIds() : Vector.<Array>
      {
         return this.FPopTipIds;
      }
      
      public function get Armys() : Vector.<uint>
      {
         return this.FArmys;
      }
      
      public function get Army() : String
      {
         return this.FArmy;
      }
      
      public function get Pop() : String
      {
         return this.FPop;
      }
   }
}

