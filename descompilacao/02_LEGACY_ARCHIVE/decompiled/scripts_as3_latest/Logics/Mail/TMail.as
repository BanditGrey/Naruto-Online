package Logics.Mail
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.Stubs.TStubReferences;
   import Logics.Inventories.TInventories;
   
   public class TMail
   {
      
      public static const TYPE_Inbox:uint = 1;
      
      public static const TYPE_Sentbox:uint = 2;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FType:uint;
      
      protected var FSortIndex:UInt64;
      
      protected var FName:String;
      
      protected var FSubject:String;
      
      protected var FDetail:String;
      
      protected var FCreatTime:uint;
      
      protected var FHasRead:uint;
      
      protected var FAccessoryInventories:TInventories;
      
      protected var FAccessoryList:Vector.<uint>;
      
      protected var FAccessoryNumList:Vector.<uint>;
      
      public function TMail()
      {
         super();
         this.FStubReferences = new TStubReferences(this);
         this.FAccessoryInventories = new TInventories();
         this.FAccessoryList = new Vector.<uint>();
         this.FAccessoryNumList = new Vector.<uint>();
         this.FSortIndex = new UInt64();
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get Type() : uint
      {
         return this.FType;
      }
      
      public function set Type(param1:uint) : void
      {
         this.FType = param1;
      }
      
      public function get SortIndex() : UInt64
      {
         return this.FSortIndex;
      }
      
      public function set SortIndex(param1:UInt64) : void
      {
         this.FSortIndex = param1;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Subject() : String
      {
         return this.FSubject;
      }
      
      public function set Subject(param1:String) : void
      {
         this.FSubject = param1;
      }
      
      public function get CreatTime() : uint
      {
         return this.FCreatTime;
      }
      
      public function set CreatTime(param1:uint) : void
      {
         this.FCreatTime = param1;
      }
      
      public function get Detail() : String
      {
         return this.FDetail;
      }
      
      public function set Detail(param1:String) : void
      {
         this.FDetail = param1;
      }
      
      public function get HasRead() : uint
      {
         return this.FHasRead;
      }
      
      public function set HasRead(param1:uint) : void
      {
         this.FHasRead = param1;
      }
      
      public function get AccessoryInventories() : TInventories
      {
         return this.FAccessoryInventories;
      }
      
      public function set AccessoryInventories(param1:TInventories) : void
      {
         this.FAccessoryInventories = param1;
      }
      
      public function get AccessoryList() : Vector.<uint>
      {
         return this.FAccessoryList;
      }
      
      public function set AccessoryList(param1:Vector.<uint>) : void
      {
         this.FAccessoryList = param1;
      }
      
      public function get AccessoryNumList() : Vector.<uint>
      {
         return this.FAccessoryNumList;
      }
      
      public function set AccessoryNumList(param1:Vector.<uint>) : void
      {
         this.FAccessoryNumList = param1;
      }
      
      public function Reset() : void
      {
         this.FType = 0;
         this.FName = "";
         this.FSubject = "";
         this.FDetail = "";
         this.FCreatTime = 0;
         this.FHasRead = 0;
      }
      
      public function ClearNoIconAccessory() : void
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         _loc2_ = this.AccessoryList.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.AccessoryList.pop();
            this.AccessoryNumList.pop();
            _loc1_++;
         }
         this.AccessoryList.length = 0;
         this.AccessoryNumList.length = 0;
      }
   }
}

