package Logics.DatebaseVO.VO
{
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class THeroTalent extends TDatebaseVO
   {
      
      protected var FTalentName:String;
      
      protected var FTalentDesc:String;
      
      protected var FTalentEffect:String;
      
      protected var FAwakeEffect1:String;
      
      protected var FAwakeEffect2:String;
      
      protected var FAwakeEffect3:String;
      
      protected var FAwakeDesc:String;
      
      protected var FTalentEffectObject:Object;
      
      protected var FAwakeEffectObject1:Object;
      
      protected var FAwakeEffectObject2:Object;
      
      protected var FAwakeEffectObject3:Object;
      
      public function THeroTalent()
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
         TUtilityString.FlushUTF(param1,this.FTalentName);
         TUtilityString.FlushUTF(param1,this.FTalentDesc);
         TUtilityString.FlushUTF(param1,this.FTalentEffect);
         TUtilityString.FlushUTF(param1,this.FAwakeEffect1);
         TUtilityString.FlushUTF(param1,this.FAwakeEffect2);
         TUtilityString.FlushUTF(param1,this.FAwakeEffect3);
         TUtilityString.FlushUTF(param1,this.FAwakeDesc);
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FTalentName = TUtilityString.FetchUTF(param1);
         this.FTalentDesc = TUtilityString.FetchUTF(param1);
         this.FTalentEffect = TUtilityString.FetchUTF(param1);
         if(!this.FTalentEffect)
         {
            this.FTalentEffectObject = null;
         }
         else
         {
            this.FTalentEffectObject = Json.decode(this.FTalentEffect) as Object;
         }
         this.FAwakeEffect1 = TUtilityString.FetchUTF(param1);
         this.FAwakeEffect2 = TUtilityString.FetchUTF(param1);
         this.FAwakeEffect3 = TUtilityString.FetchUTF(param1);
         if(!this.FAwakeEffect1)
         {
            this.FAwakeEffectObject1 = null;
         }
         else
         {
            this.FAwakeEffectObject1 = Json.decode(this.FAwakeEffect1) as Object;
         }
         if(!this.FAwakeEffect2)
         {
            this.FAwakeEffectObject2 = null;
         }
         else
         {
            this.FAwakeEffectObject2 = Json.decode(this.FAwakeEffect2) as Object;
         }
         if(!this.FAwakeEffect3)
         {
            this.FAwakeEffectObject3 = null;
         }
         else
         {
            this.FAwakeEffectObject3 = Json.decode(this.FAwakeEffect3) as Object;
         }
         this.FAwakeDesc = TUtilityString.FetchUTF(param1);
      }
      
      public function get TalentName() : String
      {
         return this.FTalentName;
      }
      
      public function get TalentDesc() : String
      {
         return this.FTalentDesc;
      }
      
      public function get TalentEffect() : String
      {
         return this.FTalentEffect;
      }
      
      public function get TalentEffectObject() : Object
      {
         return this.FTalentEffectObject;
      }
      
      public function get AwakeEffect1() : String
      {
         return this.FAwakeEffect1;
      }
      
      public function get AwakeEffect2() : String
      {
         return this.FAwakeEffect2;
      }
      
      public function get AwakeEffect3() : String
      {
         return this.FAwakeEffect3;
      }
      
      public function get AwakeEffectObject1() : Object
      {
         return this.FAwakeEffectObject1;
      }
      
      public function get AwakeEffectObject2() : Object
      {
         return this.FAwakeEffectObject2;
      }
      
      public function get AwakeEffectObject3() : Object
      {
         return this.FAwakeEffectObject3;
      }
      
      public function get AwakeDesc() : String
      {
         return this.FAwakeDesc;
      }
   }
}

