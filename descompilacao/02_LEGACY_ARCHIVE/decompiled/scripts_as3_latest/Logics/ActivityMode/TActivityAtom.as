package Logics.ActivityMode
{
   import Foundation.Common.*;
   import Foundation.Common.Stubs.*;
   import Foundation.Resources.*;
   import Logics.DatebaseVO.VO.*;
   import Logics.Inventories.*;
   import Logics.Spaces.*;
   import Resources.Constants.*;
   
   use namespace LogicsSpace;
   
   public class TActivityAtom extends TEntity
   {
      
      protected var FActiveStatus:int;
      
      protected var FConditionValue:Vector.<Object>;
      
      protected var FTips:Vector.<String>;
      
      protected var FPrice:uint;
      
      protected var FAddAwardNum:uint;
      
      protected var FGetType:uint;
      
      protected var FSort:uint;
      
      protected var FDayTime:Vector.<Object>;
      
      protected var FIsOn:Boolean;
      
      protected var FStartTime:uint;
      
      protected var FEndTime:uint;
      
      protected var FInventoriesVect:Vector.<TInventories>;
      
      public function TActivityAtom(param1:uint)
      {
         super(param1);
         this.FInventoriesVect = new Vector.<TInventories>();
      }
      
      LogicsSpace function Coerce(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      public function get ActiveStatus() : int
      {
         return this.FActiveStatus;
      }
      
      public function set ActiveStatus(param1:int) : void
      {
         this.FActiveStatus = param1;
      }
      
      public function get ConditionValue() : Vector.<Object>
      {
         return this.FConditionValue;
      }
      
      public function set ConditionValue(param1:Vector.<Object>) : void
      {
         this.FConditionValue = param1;
      }
      
      public function get Tips() : Vector.<String>
      {
         return this.FTips;
      }
      
      public function set Tips(param1:Vector.<String>) : void
      {
         this.FTips = param1;
      }
      
      public function get Price() : uint
      {
         return this.FPrice;
      }
      
      public function set Price(param1:uint) : void
      {
         this.FPrice = param1;
      }
      
      public function get AddAwardNum() : uint
      {
         return this.FAddAwardNum;
      }
      
      public function set AddAwardNum(param1:uint) : void
      {
         this.FAddAwardNum = param1;
      }
      
      public function get GetType() : uint
      {
         return this.FGetType;
      }
      
      public function set GetType(param1:uint) : void
      {
         this.FGetType = param1;
      }
      
      public function get Sort() : uint
      {
         return this.FSort;
      }
      
      public function set Sort(param1:uint) : void
      {
         this.FSort = param1;
      }
      
      public function get DayTime() : Vector.<Object>
      {
         return this.FDayTime;
      }
      
      public function set DayTime(param1:Vector.<Object>) : void
      {
         this.FDayTime = param1;
      }
      
      public function get InventoriesVect() : Vector.<TInventories>
      {
         return this.FInventoriesVect;
      }
      
      public function get IsOn() : Boolean
      {
         return this.FIsOn;
      }
      
      public function set IsOn(param1:Boolean) : void
      {
         this.FIsOn = param1;
      }
      
      public function set StartTime(param1:uint) : void
      {
         this.FStartTime = param1;
      }
      
      public function get StartTime() : uint
      {
         return this.FStartTime;
      }
      
      public function set EndTime(param1:uint) : void
      {
         this.FEndTime = param1;
      }
      
      public function get EndTime() : uint
      {
         return this.FEndTime;
      }
   }
}

