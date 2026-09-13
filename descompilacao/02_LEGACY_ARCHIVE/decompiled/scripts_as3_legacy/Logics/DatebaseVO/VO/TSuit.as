package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.*;
   import Logics.DatebaseVO.VO.Json.*;
   import flash.utils.ByteArray;
   import ghostcat.util.data.*;
   
   use namespace ResourcesSpace;
   
   public class TSuit extends TDatebaseVO
   {
      
      protected static const KEY_01:String = "2";
      
      protected static const KEY_02:String = "4";
      
      protected static const KEY_03:String = "6";
      
      protected static const KEY_04:String = "8";
      
      protected static const KEYS:Vector.<String> = Vector.<String>([KEY_01,KEY_02,KEY_03,KEY_04]);
      
      protected var FName:String;
      
      protected var FMaxCount:uint;
      
      protected var FSuitEffects:Vector.<TSuitEffect>;
      
      protected var FSEffect:String;
      
      protected var FSEffectIdDesc:String;
      
      public function TSuit()
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
         param1.writeUnsignedInt(this.FMaxCount);
         TUtilityString.FlushUTF(param1,this.FSEffect);
         TUtilityString.FlushUTF(param1,this.FSEffectIdDesc);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:TSuitEffect = null;
         this.FName = TUtilityString.FetchUTF(param1);
         this.FMaxCount = param1.readUnsignedInt();
         this.FSEffect = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FSEffect);
         _loc3_ = int(KEYS.length);
         this.FSuitEffects = new Vector.<TSuitEffect>(_loc3_);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = KEYS[_loc2_];
            _loc7_ = _loc4_[_loc6_] as Array;
            _loc8_ = new TSuitEffect(_loc6_,_loc7_);
            this.FSuitEffects[_loc2_] = _loc8_;
            _loc2_++;
         }
         this.FSEffectIdDesc = TUtilityString.FetchUTF(param1);
         _loc4_ = Json.decode(this.FSEffectIdDesc);
         _loc2_ = 0;
         while(_loc2_ < this.FSuitEffects.length)
         {
            _loc6_ = KEYS[_loc2_];
            _loc7_ = _loc4_[_loc6_] as Array;
            _loc8_ = this.FSuitEffects[_loc2_];
            _loc8_.EffectDescArray = _loc7_;
            _loc2_++;
         }
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function get MaxCount() : uint
      {
         return this.FMaxCount;
      }
      
      public function get SuitEffects() : Vector.<TSuitEffect>
      {
         return this.FSuitEffects;
      }
      
      public function get SEffect() : String
      {
         return this.FSEffect;
      }
      
      public function get SEffectIdDesc() : String
      {
         return this.FSEffectIdDesc;
      }
   }
}

