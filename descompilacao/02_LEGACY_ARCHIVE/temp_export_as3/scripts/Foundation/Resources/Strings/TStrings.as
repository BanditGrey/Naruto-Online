package Foundation.Resources.Strings
{
   import Foundation.Resources.Common.*;
   import Foundation.Resources.Spaces.*;
   
   use namespace ResourcesSpace;
   
   public class TStrings extends TResource
   {
      
      protected var FIdentifiers:Vector.<uint>;
      
      protected var FValues:Vector.<String>;
      
      public function TStrings(param1:uint)
      {
         super(param1);
         this.FIdentifiers = new Vector.<uint>();
         this.FValues = new Vector.<String>();
      }
      
      ResourcesSpace function Coerce(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      ResourcesSpace function StringAppend(param1:uint, param2:String) : void
      {
         this.FIdentifiers.push(param1);
         this.FValues.push(param2);
      }
      
      protected function MergeIdentifier(param1:uint, param2:String) : uint
      {
         var _loc3_:uint = 0;
         _loc3_ = 0;
         return uint(parseInt(param1.toString() + param2));
      }
      
      public function GetStringByIndex(param1:int) : String
      {
         return this.FValues[param1];
      }
      
      public function GetStringByIdentifier(param1:uint, param2:String = "") : String
      {
         var _loc3_:int = 0;
         param1 = this.MergeIdentifier(param1,param2);
         _loc3_ = this.FIdentifiers.indexOf(param1);
         if(_loc3_ < 0)
         {
            return null;
         }
         return this.FValues[_loc3_];
      }
   }
}

