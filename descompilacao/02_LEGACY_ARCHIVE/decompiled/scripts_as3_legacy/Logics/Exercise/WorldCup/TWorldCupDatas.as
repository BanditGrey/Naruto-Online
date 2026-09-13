package Logics.Exercise.WorldCup
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActiveDatas;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TWorldCupDatas extends TBaseActiveDatas
   {
      
      protected static const ACTIVITY_COUNT:int = 2;
      
      protected var DATE_REFERENCE:Vector.<Class>;
      
      public var BeginTime:int;
      
      public var EndTime:int;
      
      public var DescList:Vector.<String>;
      
      public var DescListNew:Vector.<String>;
      
      public var giftGold:int;
      
      public var gold:int;
      
      public var ShopExchangeItems:Vector.<TBaseBox>;
      
      public function TWorldCupDatas()
      {
         var _loc1_:int = 0;
         var _loc2_:Class = null;
         this.DATE_REFERENCE = Vector.<Class>([TWorldCup1,TWorldCup2]);
         super(ACTIVITY_COUNT);
         FActivities = new Vector.<TBaseActivity>(ACTIVITY_COUNT);
         _loc1_ = 0;
         while(_loc1_ < ACTIVITY_COUNT)
         {
            _loc2_ = this.DATE_REFERENCE[_loc1_];
            FActivities[_loc1_] = new _loc2_();
            FActivities[_loc1_].Identify = _loc1_ + 1;
            _loc1_++;
         }
         this.DescList = new Vector.<String>();
         this.DescListNew = new Vector.<String>();
         this.ShopExchangeItems = new Vector.<TBaseBox>();
      }
      
      public static function IsRealNumber(param1:String) : Boolean
      {
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
      
      override public function ChangeStatus1() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TWorldCup1 = null;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      override public function ChangeStatus2() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TWorldCup2 = null;
         return TBaseActivity.STATUS_CANNOTGET;
      }
      
      public function InitDescListNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         _loc1_ = 0;
         while(_loc1_ < this.DescList.length)
         {
            _loc2_ = int(parseInt(this.DescList[_loc1_]));
            if(IsRealNumber(this.DescList[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
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
                  this.DescListNew[_loc1_] = this.DescList[_loc1_];
               }
            }
            else
            {
               this.DescListNew[_loc1_] = this.DescList[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}

