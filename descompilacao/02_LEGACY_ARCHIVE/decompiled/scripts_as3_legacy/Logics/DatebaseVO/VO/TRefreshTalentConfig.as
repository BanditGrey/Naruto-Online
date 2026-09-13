package Logics.DatebaseVO.VO
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Spaces.ResourcesSpace;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.TDatebaseVO;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   use namespace ResourcesSpace;
   
   public class TRefreshTalentConfig extends TDatebaseVO
   {
      
      protected var FClass:int;
      
      protected var FClasslevel:int;
      
      protected var FNeedExp:int;
      
      protected var FAllExp:int;
      
      protected var FPorperty:String;
      
      protected var FPorpertyrate:String;
      
      public var Porperties:Array;
      
      public var Porpertyrates:Array;
      
      public function TRefreshTalentConfig()
      {
         super();
      }
      
      override ResourcesSpace function ReadDataByStream(param1:ByteArray) : void
      {
         this.FClass = param1.readUnsignedInt();
         this.FClasslevel = param1.readUnsignedInt();
         this.FNeedExp = param1.readUnsignedInt();
         this.FAllExp = param1.readUnsignedInt();
         this.FPorperty = TUtilityString.FetchUTF(param1);
         this.FPorpertyrate = TUtilityString.FetchUTF(param1);
         this.Porperties = Json.decode(this.FPorperty);
         this.Porpertyrates = Json.decode(this.FPorpertyrate);
      }
      
      override ResourcesSpace function WriteDataToStream(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(FIdentifier);
         param1.writeUnsignedInt(this.FClass);
         param1.writeUnsignedInt(this.FClasslevel);
         param1.writeUnsignedInt(this.FNeedExp);
         param1.writeUnsignedInt(this.FAllExp);
         TUtilityString.FlushUTF(param1,this.FPorperty);
         TUtilityString.FlushUTF(param1,this.FPorpertyrate);
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
      
      public function get NextRefreshTalentConfig() : TRefreshTalentConfig
      {
         var _loc1_:TRefreshTalentConfig = null;
         return SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RefreshTalentConfig,Identifier + 1) as TRefreshTalentConfig;
      }
      
      public function get Class() : int
      {
         return this.FClass;
      }
      
      public function get Classlevel() : int
      {
         return this.FClasslevel;
      }
      
      public function get NeedExp() : int
      {
         return this.FNeedExp;
      }
      
      public function get AllExp() : int
      {
         return this.FAllExp;
      }
      
      public function get Porperty() : String
      {
         return this.FPorperty;
      }
      
      public function get Porpertyrate() : String
      {
         return this.FPorpertyrate;
      }
   }
}

