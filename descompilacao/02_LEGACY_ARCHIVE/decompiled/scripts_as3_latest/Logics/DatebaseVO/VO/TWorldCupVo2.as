package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   
   use namespace ResourcesSpace;
   
   public class TWorldCupVo2 extends TDatebaseVO
   {
      
      public var hometeam:int;
      
      public var guestteam:int;
      
      public var matchday:int;
      
      public var deadline:int;
      
      public var win:int;
      
      public var draw:int;
      
      public var defeat:int;
      
      public var single:int;
      
      public var max:int;
      
      public var results:int;
      
      public var score:String;
      
      public var currency:String;
      
      public var awardtime:int;
      
      public var page:int;
      
      public function TWorldCupVo2()
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
         param1.writeUnsignedInt(this.hometeam);
         param1.writeUnsignedInt(this.guestteam);
         param1.writeUnsignedInt(this.matchday);
         param1.writeUnsignedInt(this.deadline);
         param1.writeUnsignedInt(this.win);
         param1.writeUnsignedInt(this.draw);
         param1.writeUnsignedInt(this.defeat);
         param1.writeUnsignedInt(this.single);
         param1.writeUnsignedInt(this.max);
         param1.writeUnsignedInt(this.results);
         TUtilityString.FlushUTF(param1,this.score);
         TUtilityString.FlushUTF(param1,this.currency);
         param1.writeUnsignedInt(this.awardtime);
         param1.writeUnsignedInt(this.page);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.hometeam = param1.readUnsignedInt();
         this.guestteam = param1.readUnsignedInt();
         this.matchday = param1.readUnsignedInt();
         this.deadline = param1.readUnsignedInt();
         this.win = param1.readUnsignedInt();
         this.draw = param1.readUnsignedInt();
         this.defeat = param1.readUnsignedInt();
         this.single = param1.readUnsignedInt();
         this.max = param1.readUnsignedInt();
         this.results = param1.readUnsignedInt();
         this.score = TUtilityString.FetchUTF(param1);
         this.currency = TUtilityString.FetchUTF(param1);
         this.awardtime = param1.readUnsignedInt();
         this.page = param1.readUnsignedInt();
      }
   }
}

