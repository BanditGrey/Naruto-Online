package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TEnemyArmy extends TDatebaseVO
   {
      
      protected var FName:String;
      
      protected var FFrontVect:Vector.<uint>;
      
      protected var FMiddleVect:Vector.<uint>;
      
      protected var FBackVect:Vector.<uint>;
      
      protected var FText:String;
      
      protected var FEnemyIdVect:Vector.<uint>;
      
      protected var FEnemyPosVect:Vector.<uint>;
      
      protected var FFront:String;
      
      protected var FMiddle:String;
      
      protected var FBack:String;
      
      protected var FIsLeader:uint;
      
      public function TEnemyArmy()
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
         TUtilityString.FlushUTF(param1,this.FFront);
         TUtilityString.FlushUTF(param1,this.FMiddle);
         TUtilityString.FlushUTF(param1,this.FBack);
         TUtilityString.FlushUTF(param1,this.FText);
         param1.writeUnsignedInt(this.FIsLeader);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FFront = TUtilityString.FetchUTF(param1);
         if(Boolean(this.FFront) && this.FFront != "")
         {
            _loc3_ = Json.decode(this.FFront);
            this.FFrontVect = Vector.<uint>(_loc3_.front);
         }
         this.FMiddle = TUtilityString.FetchUTF(param1);
         if(Boolean(this.FMiddle) && this.FMiddle != "")
         {
            _loc3_ = Json.decode(this.FMiddle);
            this.FMiddleVect = Vector.<uint>(_loc3_.middle);
         }
         this.FBack = TUtilityString.FetchUTF(param1);
         if(Boolean(this.FBack) && this.FBack != "")
         {
            _loc3_ = Json.decode(this.FBack);
            this.FBackVect = Vector.<uint>(_loc3_.back);
         }
         this.FText = TUtilityString.FetchUTF(param1);
         this.MakeEnemyVect();
         this.FIsLeader = param1.readUnsignedInt();
      }
      
      protected function AddEnemy(param1:Vector.<uint>, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         _loc5_ = param2;
         if(param1 != null)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc4_ = param1[_loc3_];
               if(this.FEnemyIdVect.indexOf(_loc4_) < 0)
               {
                  this.FEnemyIdVect.push(_loc4_);
                  this.FEnemyPosVect.push(_loc5_);
                  _loc5_++;
               }
               _loc3_++;
            }
         }
      }
      
      protected function MakeEnemyVect() : void
      {
         this.FEnemyIdVect = new Vector.<uint>();
         this.FEnemyPosVect = new Vector.<uint>();
         this.AddEnemy(this.FFrontVect,1);
         this.AddEnemy(this.FMiddleVect,6);
         this.AddEnemy(this.FBackVect,11);
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get Text() : String
      {
         return this.FText;
      }
      
      public function get EnemyIdVect() : Vector.<uint>
      {
         return this.FEnemyIdVect;
      }
      
      public function get EnemyPosVect() : Vector.<uint>
      {
         return this.FEnemyPosVect;
      }
      
      public function get Front() : String
      {
         return this.FFront;
      }
      
      public function get Middle() : String
      {
         return this.FMiddle;
      }
      
      public function get Back() : String
      {
         return this.FBack;
      }
      
      public function get IsLeader() : uint
      {
         return this.FIsLeader;
      }
   }
}

