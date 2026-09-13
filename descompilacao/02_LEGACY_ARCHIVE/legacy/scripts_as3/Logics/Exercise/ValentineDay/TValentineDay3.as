package Logics.Exercise.ValentineDay
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TValentineDay3 extends TBaseActivity
   {
      
      public static const ROSE_NONE:int = 0;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FGiftList:Vector.<TBaseBox>;
      
      protected var FRoseStatus:Vector.<int>;
      
      protected var FIsEnd:int;
      
      protected var FRosePrice:int;
      
      protected var FTitleID:uint;
      
      protected var FTitleStatus:int;
      
      protected var FTitlePrice:int;
      
      protected var FTitleDesc1:String;
      
      protected var FTitleDesc2:String;
      
      protected var FTitleDesc3:String;
      
      protected var FScore:int;
      
      protected var FFreeCount:int;
      
      protected var FRoseList:Vector.<TBaseBox>;
      
      public function TValentineDay3()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FGiftList = new Vector.<TBaseBox>();
         this.FRoseStatus = new Vector.<int>();
         this.FRoseList = new Vector.<TBaseBox>();
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get GiftList() : Vector.<TBaseBox>
      {
         return this.FGiftList;
      }
      
      public function set GiftList(param1:Vector.<TBaseBox>) : void
      {
         this.FGiftList = param1;
      }
      
      public function get RoseStatus() : Vector.<int>
      {
         return this.FRoseStatus;
      }
      
      public function set RoseStatus(param1:Vector.<int>) : void
      {
         this.FRoseStatus = param1;
      }
      
      public function get IsEnd() : int
      {
         return this.FIsEnd;
      }
      
      public function set IsEnd(param1:int) : void
      {
         this.FIsEnd = param1;
      }
      
      public function get RosePrice() : int
      {
         return this.FRosePrice;
      }
      
      public function set RosePrice(param1:int) : void
      {
         this.FRosePrice = param1;
      }
      
      public function get TitleID() : uint
      {
         return this.FTitleID;
      }
      
      public function set TitleID(param1:uint) : void
      {
         this.FTitleID = param1;
      }
      
      public function get TitlePrice() : int
      {
         return this.FTitlePrice;
      }
      
      public function set TitlePrice(param1:int) : void
      {
         this.FTitlePrice = param1;
      }
      
      public function get Score() : int
      {
         return this.FScore;
      }
      
      public function set Score(param1:int) : void
      {
         this.FScore = param1;
      }
      
      public function get FreeCount() : int
      {
         return this.FFreeCount;
      }
      
      public function set FreeCount(param1:int) : void
      {
         this.FFreeCount = param1;
      }
      
      public function get TitleStatus() : int
      {
         return this.FTitleStatus;
      }
      
      public function set TitleStatus(param1:int) : void
      {
         this.FTitleStatus = param1;
      }
      
      public function get TitleDesc1() : String
      {
         return this.FTitleDesc1;
      }
      
      public function set TitleDesc1(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FTitleDesc1 = _loc3_;
            }
         }
         else
         {
            this.FTitleDesc1 = param1;
         }
      }
      
      public function get TitleDesc2() : String
      {
         return this.FTitleDesc2;
      }
      
      public function set TitleDesc2(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FTitleDesc2 = _loc3_;
            }
         }
         else
         {
            this.FTitleDesc2 = param1;
         }
      }
      
      public function get TitleDesc3() : String
      {
         return this.FTitleDesc3;
      }
      
      public function set TitleDesc3(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FTitleDesc3 = _loc3_;
            }
         }
         else
         {
            this.FTitleDesc3 = param1;
         }
      }
      
      public function get RoseList() : Vector.<TBaseBox>
      {
         return this.FRoseList;
      }
      
      public function set RoseList(param1:Vector.<TBaseBox>) : void
      {
         this.FRoseList = param1;
      }
      
      public function ChangeGiftStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TBaseBox = null;
         _loc2_ = int(this.FGiftList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FGiftList[_loc1_];
            if(_loc3_.Status == TBaseActivity.STATUS_CANGET)
            {
               return;
            }
            if(_loc3_.Status == TBaseActivity.STATUS_CANNOTGET && this.FScore >= _loc3_.Price)
            {
               _loc3_.Status = TBaseActivity.STATUS_CANGET;
               return;
            }
            _loc1_++;
         }
         if(this.FTitleStatus == TBaseActivity.STATUS_CANNOTGET && this.FScore >= this.FTitlePrice)
         {
            this.FTitleStatus = TBaseActivity.STATUS_CANGET;
         }
      }
      
      public function ResetRoseStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FIsEnd = 0;
         _loc2_ = int(this.FRoseStatus.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FRoseStatus[_loc1_] = 0;
            _loc1_++;
         }
      }
      
      public function GetNotOpenCount() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(this.FRoseStatus.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(this.FRoseStatus[_loc1_] == 0)
            {
               _loc3_++;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function GetAllOpenCost() : int
      {
         var _loc1_:int = 0;
         if(this.GetNotOpenCount() >= this.FFreeCount)
         {
            _loc1_ = (this.GetNotOpenCount() - this.FFreeCount) * this.FRosePrice;
         }
         else
         {
            _loc1_ = 0;
         }
         return _loc1_;
      }
   }
}

