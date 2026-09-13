package Logics.ActivityMode
{
   import Foundation.Common.*;
   import Foundation.Resources.*;
   import Logics.DatebaseVO.VO.*;
   import Resources.Constants.*;
   
   public class TActivityAtoms extends TEntity
   {
      
      protected var FActivityAtoms:Vector.<TActivityAtom>;
      
      protected var FLeftCaption:String;
      
      protected var FRightCaption:String;
      
      protected var FDesc:String;
      
      protected var FIconType:uint;
      
      protected var FSecondIconType:uint;
      
      protected var FStartIndex:Vector.<uint>;
      
      protected var FEndIndex:Vector.<uint>;
      
      protected var FSort:uint;
      
      protected var FIsOn:Boolean;
      
      protected var FStartTime:uint;
      
      protected var FEndTime:uint;
      
      protected var FCheckTime:uint;
      
      protected var FChgIconStatus:Function;
      
      public function TActivityAtoms(param1:uint)
      {
         super(param1);
         this.FActivityAtoms = new Vector.<TActivityAtom>();
      }
      
      protected function SortMount(param1:TActivityAtom, param2:TActivityAtom) : int
      {
         if(param1.Sort < param2.Sort)
         {
            return -1;
         }
         return 1;
      }
      
      public function get Count() : int
      {
         return this.FActivityAtoms.length;
      }
      
      public function get OpenCount() : int
      {
         var _loc1_:uint = 0;
         var _loc2_:TActivityAtom = null;
         var _loc3_:uint = 0;
         _loc3_ = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FActivityAtoms.length)
         {
            _loc2_ = this.FActivityAtoms[_loc1_];
            if(_loc2_.IsOn)
            {
               _loc3_++;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function GetActivityAtomByIndex(param1:int) : TActivityAtom
      {
         return this.FActivityAtoms[param1];
      }
      
      public function GetOpenActivityAtomByIndex(param1:int) : TActivityAtom
      {
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtom = null;
         var _loc4_:uint = 0;
         _loc4_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this.FActivityAtoms.length)
         {
            _loc3_ = this.FActivityAtoms[_loc2_];
            if(_loc3_.IsOn)
            {
               if(param1 == _loc4_)
               {
                  return _loc3_;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetActivityAtomByIdentifier(param1:uint) : TActivityAtom
      {
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtom = null;
         _loc2_ = 0;
         while(_loc2_ < this.FActivityAtoms.length)
         {
            _loc3_ = this.FActivityAtoms[_loc2_];
            if(_loc3_.Identifier == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function set IsOn(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:TActivityAtom = null;
         this.FIsOn = param1;
         _loc2_ = 0;
         while(_loc2_ < this.FActivityAtoms.length)
         {
            _loc3_ = this.FActivityAtoms[_loc2_];
            _loc3_.IsOn = param1;
            _loc2_++;
         }
         if(this.FChgIconStatus != null)
         {
            this.FChgIconStatus();
         }
      }
      
      public function get IsOn() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:TActivityAtom = null;
         _loc1_ = 0;
         while(_loc1_ < this.FActivityAtoms.length)
         {
            _loc2_ = this.FActivityAtoms[_loc1_];
            this.FIsOn = _loc2_.IsOn;
            if(this.FIsOn)
            {
               break;
            }
            _loc1_++;
         }
         return this.FIsOn;
      }
      
      public function get StartTime() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:TActivityAtom = null;
         var _loc3_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < this.FActivityAtoms.length)
         {
            _loc2_ = this.FActivityAtoms[_loc1_];
            _loc3_ = _loc2_.IsOn;
            if(_loc3_)
            {
               this.FStartTime = _loc2_.StartTime;
               break;
            }
            _loc1_++;
         }
         return this.FStartTime;
      }
      
      public function get EndTime() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:TActivityAtom = null;
         var _loc3_:Boolean = false;
         _loc1_ = 0;
         while(_loc1_ < this.FActivityAtoms.length)
         {
            _loc2_ = this.FActivityAtoms[_loc1_];
            _loc3_ = _loc2_.IsOn;
            if(_loc3_)
            {
               this.FEndTime = _loc2_.EndTime;
               break;
            }
            _loc1_++;
         }
         return this.FEndTime;
      }
      
      public function get DayTime() : Vector.<Object>
      {
         var _loc1_:uint = 0;
         var _loc2_:TActivityAtom = null;
         var _loc3_:Vector.<Object> = null;
         _loc1_ = 0;
         while(_loc1_ < this.FActivityAtoms.length)
         {
            _loc2_ = this.FActivityAtoms[_loc1_];
            if(_loc2_.IsOn)
            {
               return _loc2_.DayTime;
            }
            _loc1_++;
         }
         if(_loc2_)
         {
            return _loc2_.DayTime;
         }
         return null;
      }
      
      public function set CheckTime(param1:uint) : void
      {
         this.FCheckTime = param1;
      }
      
      public function get CheckTime() : uint
      {
         return this.FCheckTime;
      }
      
      public function get LeftCaption() : String
      {
         return this.FLeftCaption;
      }
      
      public function set LeftCaption(param1:String) : void
      {
         this.FLeftCaption = param1;
      }
      
      public function get RightCaption() : String
      {
         return this.FRightCaption;
      }
      
      public function set RightCaption(param1:String) : void
      {
         this.FRightCaption = param1;
      }
      
      public function get Desc() : String
      {
         return this.FDesc;
      }
      
      public function set Desc(param1:String) : void
      {
         this.FDesc = param1;
      }
      
      public function get IconType() : uint
      {
         return this.FIconType;
      }
      
      public function set IconType(param1:uint) : void
      {
         this.FIconType = param1;
      }
      
      public function get SecondIconType() : uint
      {
         return this.FSecondIconType;
      }
      
      public function set SecondIconType(param1:uint) : void
      {
         this.FSecondIconType = param1;
      }
      
      public function get StartIndex() : Vector.<uint>
      {
         return this.FStartIndex;
      }
      
      public function set StartIndex(param1:Vector.<uint>) : void
      {
         this.FStartIndex = param1;
      }
      
      public function get EndIndex() : Vector.<uint>
      {
         return this.FEndIndex;
      }
      
      public function set EndIndex(param1:Vector.<uint>) : void
      {
         this.FEndIndex = param1;
      }
      
      public function get Sort() : uint
      {
         return this.FSort;
      }
      
      public function set Sort(param1:uint) : void
      {
         this.FSort = param1;
      }
      
      public function get ChgIconStatus() : Function
      {
         return this.FChgIconStatus;
      }
      
      public function set ChgIconStatus(param1:Function) : void
      {
         this.FChgIconStatus = param1;
      }
      
      public function Clear() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TActivityAtom = null;
         _loc1_ = int(this.FActivityAtoms.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.FActivityAtoms[_loc2_];
            _loc2_++;
         }
         this.FActivityAtoms.length = 0;
      }
      
      public function Add(param1:TActivityAtom) : void
      {
         this.FActivityAtoms.push(param1);
      }
      
      public function Delete(param1:int) : void
      {
         var _loc2_:TActivityAtom = null;
         _loc2_ = this.FActivityAtoms[param1];
         this.FActivityAtoms.splice(param1,1);
      }
      
      public function SortActivityAtoms() : void
      {
         this.FActivityAtoms.sort(this.SortMount);
      }
   }
}

