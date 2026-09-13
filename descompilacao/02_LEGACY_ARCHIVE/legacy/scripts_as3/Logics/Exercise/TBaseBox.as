package Logics.Exercise
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TBaseBox
   {
      
      public static const OVERLAYER_TYPE_GET_ALL:int = 0;
      
      public static const OVERLAYER_TYPE_GET_ONE:int = 1;
      
      public static const TYPE_IS_HERO:int = 0;
      
      public static const TYPE_IS_PET:int = 1;
      
      public static const TYPE_IS_TITLE:int = 2;
      
      public static const TYPE_IS_ITEM:int = 3;
      
      public static const TYPE_IS_SCORE:int = 4;
      
      public static const TYPE_IS_EQUIP:int = 5;
      
      public static const TYPE_IS_ACCESSORIE:int = 6;
      
      protected var FIdentify:int;
      
      protected var FStatus:int;
      
      protected var FBuyCount:int;
      
      protected var FCount:int;
      
      protected var FPrice:int;
      
      protected var FInventories:TInventories;
      
      protected var FInventory:TInventory;
      
      protected var FExchangeInventories:TInventories;
      
      protected var FOverlayerType:int;
      
      protected var FLimitCount:int;
      
      protected var FDiscount:int;
      
      protected var FCurPrice:int;
      
      protected var FTitle:String;
      
      protected var FQuality:String;
      
      protected var FDesc1:String;
      
      protected var FDesc2:String;
      
      protected var FDesc3:String;
      
      protected var FDesc4:String;
      
      protected var FMax:int;
      
      protected var FMin:int;
      
      protected var FTitleID:uint;
      
      protected var FExchangeVect:Vector.<int>;
      
      protected var FType:int;
      
      protected var FMaxVect:Vector.<int>;
      
      protected var FLevel:int;
      
      protected var FPicType:int;
      
      protected var FIsHot:int;
      
      protected var FReturnMoney:int;
      
      protected var FDescList:Vector.<String>;
      
      protected var FTime:int;
      
      protected var FTotalTms:int;
      
      public var NickName:String;
      
      public var Items:TInventories;
      
      public var DescListNew:Vector.<String>;
      
      public var Desc5:String;
      
      public function TBaseBox()
      {
         super();
         this.FExchangeVect = new Vector.<int>();
         this.FMaxVect = new Vector.<int>();
         this.FDescList = new Vector.<String>();
         this.DescListNew = new Vector.<String>();
         this.Inventories = new TInventories();
      }
      
      public static function IsRealNumber(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if((param1.charCodeAt(_loc2_) > 57 || param1.charCodeAt(_loc2_) < 48) && param1.charCodeAt(_loc2_) != 46)
            {
               return false;
            }
            _loc2_++;
         }
         return true;
      }
      
      public function get DescList() : Vector.<String>
      {
         return this.FDescList;
      }
      
      public function set DescList(param1:Vector.<String>) : void
      {
         this.FDescList = param1;
      }
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get Status() : int
      {
         return this.FStatus;
      }
      
      public function set Status(param1:int) : void
      {
         this.FStatus = param1;
      }
      
      public function get BuyCount() : int
      {
         return this.FBuyCount;
      }
      
      public function set BuyCount(param1:int) : void
      {
         this.FBuyCount = param1;
      }
      
      public function get Count() : int
      {
         return this.FCount;
      }
      
      public function set Count(param1:int) : void
      {
         this.FCount = param1;
      }
      
      public function get Price() : int
      {
         return this.FPrice;
      }
      
      public function set Price(param1:int) : void
      {
         this.FPrice = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get Inventory() : TInventory
      {
         return this.FInventory;
      }
      
      public function set Inventory(param1:TInventory) : void
      {
         this.FInventory = param1;
      }
      
      public function get ExchangeInventories() : TInventories
      {
         return this.FExchangeInventories;
      }
      
      public function set ExchangeInventories(param1:TInventories) : void
      {
         this.FExchangeInventories = param1;
      }
      
      public function get OverlayerType() : int
      {
         return this.FOverlayerType;
      }
      
      public function set OverlayerType(param1:int) : void
      {
         this.FOverlayerType = param1;
      }
      
      public function get LimitCount() : int
      {
         return this.FLimitCount;
      }
      
      public function set LimitCount(param1:int) : void
      {
         this.FLimitCount = param1;
      }
      
      public function get Discount() : int
      {
         return this.FDiscount;
      }
      
      public function set Discount(param1:int) : void
      {
         this.FDiscount = param1;
      }
      
      public function get CurPrice() : int
      {
         return this.FCurPrice;
      }
      
      public function set CurPrice(param1:int) : void
      {
         this.FCurPrice = param1;
      }
      
      public function get Title() : String
      {
         return this.FTitle;
      }
      
      public function set Title(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FTitle = _loc3_;
            }
         }
         else
         {
            this.FTitle = param1;
         }
      }
      
      public function get Max() : int
      {
         return this.FMax;
      }
      
      public function set Max(param1:int) : void
      {
         this.FMax = param1;
      }
      
      public function get Min() : int
      {
         return this.FMin;
      }
      
      public function set Min(param1:int) : void
      {
         this.FMin = param1;
      }
      
      public function get Quality() : String
      {
         return this.FQuality;
      }
      
      public function set Quality(param1:String) : void
      {
         this.FQuality = param1;
      }
      
      public function get Desc1() : String
      {
         return this.FDesc1;
      }
      
      public function set Desc1(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FDesc1 = _loc3_;
            }
         }
         else
         {
            this.FDesc1 = param1;
         }
      }
      
      public function get Desc2() : String
      {
         return this.FDesc2;
      }
      
      public function set Desc2(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FDesc2 = _loc3_;
            }
         }
         else
         {
            this.FDesc2 = param1;
         }
      }
      
      public function get Desc3() : String
      {
         return this.FDesc3;
      }
      
      public function set Desc3(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FDesc3 = _loc3_;
            }
         }
         else
         {
            this.FDesc3 = param1;
         }
      }
      
      public function get Desc4() : String
      {
         return this.FDesc4;
      }
      
      public function set Desc4(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc2_ = int(parseInt(param1));
         if(IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
            if(_loc4_)
            {
               _loc3_ = _loc4_.Desc;
               _loc3_ = _loc3_.split("&lt;").join("<");
               _loc3_ = _loc3_.split("&gt;").join(">");
               this.FDesc4 = _loc3_;
            }
         }
         else
         {
            this.FDesc4 = param1;
         }
      }
      
      public function get TitleID() : uint
      {
         return this.FTitleID;
      }
      
      public function set TitleID(param1:uint) : void
      {
         this.FTitleID = param1;
      }
      
      public function get ExchangeVect() : Vector.<int>
      {
         return this.FExchangeVect;
      }
      
      public function set ExchangeVect(param1:Vector.<int>) : void
      {
         this.FExchangeVect = param1;
      }
      
      public function get Type() : int
      {
         return this.FType;
      }
      
      public function set Type(param1:int) : void
      {
         this.FType = param1;
      }
      
      public function get MaxVect() : Vector.<int>
      {
         return this.FMaxVect;
      }
      
      public function set MaxVect(param1:Vector.<int>) : void
      {
         this.FMaxVect = param1;
      }
      
      public function get Level() : int
      {
         return this.FLevel;
      }
      
      public function set Level(param1:int) : void
      {
         this.FLevel = param1;
      }
      
      public function get PicType() : int
      {
         return this.FPicType;
      }
      
      public function set PicType(param1:int) : void
      {
         this.FPicType = param1;
      }
      
      public function get IsHot() : int
      {
         return this.FIsHot;
      }
      
      public function set IsHot(param1:int) : void
      {
         this.FIsHot = param1;
      }
      
      public function get ReturnMoney() : int
      {
         return this.FReturnMoney;
      }
      
      public function set ReturnMoney(param1:int) : void
      {
         this.FReturnMoney = param1;
      }
      
      public function get Time() : int
      {
         return this.FTime;
      }
      
      public function set Time(param1:int) : void
      {
         this.FTime = param1;
      }
      
      public function get TotalTms() : int
      {
         return this.FTotalTms;
      }
      
      public function set TotalTms(param1:int) : void
      {
         this.FTotalTms = param1;
      }
      
      public function InitDescListNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         if(this.DescListNew.length > 0 && Boolean(this.DescListNew[0]))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FDescList.length)
         {
            _loc2_ = int(parseInt(this.FDescList[_loc1_]));
            if(IsRealNumber(this.FDescList[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.DescListNew[_loc1_] = _loc3_;
               }
               else
               {
                  this.DescListNew[_loc1_] = this.FDescList[_loc1_];
               }
            }
            else
            {
               this.DescListNew[_loc1_] = this.FDescList[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}

