package Logics.Exercise
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Inventories.TInventories;
   import Logics.Lottery.TLotteryNews;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TBaseActivity
   {
      
      public static const STATUS_CANGET:int = 1;
      
      public static const STATUS_CANNOTGET:int = 0;
      
      public static const STATUS_GETED:int = -1;
      
      public static const STATUS_IS_GOT:int = 2;
      
      public static const PAY_END:int = 0;
      
      public static const GET_END:int = 1;
      
      public static const NEED_CONFIG:int = 1;
      
      public static const NOT_NEED_CONFIG:int = 0;
      
      public static const REQ_TYPE_GET:int = 1;
      
      public static const REQ_TYPE_BUY:int = 2;
      
      public static const IS_OPEN:int = 1;
      
      public static const IS_NOT_OPEN:int = 2;
      
      public static const IS_CLOSED:int = 3;
      
      public static const SWEET_TYPE_GOLD:int = 0;
      
      public static const SWEET_TYPE_FREE:int = 1;
      
      public static const SWEET_TYPE_COIN:int = 2;
      
      public static const SWEET_TYPE_GOLD_GIFT:int = 4;
      
      public static const IS_NOHOT:int = 0;
      
      public static const IS_HOT:int = 1;
      
      public static const RETURN_GOLD:int = 1;
      
      public static const RETURN_GIFT:int = 2;
      
      public static const RANK_TYPE_1:int = 1;
      
      public static const RANK_TYPE_3:int = 3;
      
      protected var FIdentify:int;
      
      protected var FActivityName:String;
      
      protected var FActivityTabName:String;
      
      protected var FActivityDesc:String;
      
      protected var FBeginTime:int;
      
      protected var FEndTime:int;
      
      protected var FInventories:TInventories;
      
      protected var FRewardStatus:Vector.<int>;
      
      protected var FPayEndTime:int;
      
      protected var FNeedConfig:Boolean;
      
      protected var FEndType:int;
      
      protected var FLogList:Vector.<TLotteryNews>;
      
      protected var FIsOpen:int;
      
      protected var FNeedShine:int;
      
      protected var FActivityDesc2:String;
      
      protected var FActivityDesc3:String;
      
      protected var FActivityDesc4:String;
      
      protected var FDescList:Vector.<String>;
      
      protected var FRewardDescs:Vector.<String>;
      
      protected var FCurMyRank:int;
      
      protected var FRankPoint:int;
      
      protected var FNeedEffect:int;
      
      protected var FRankGiftList:Vector.<TBaseBox>;
      
      protected var FRankPlayerList:Vector.<TConsumeRankInfo>;
      
      protected var FShopExchangeItems:Vector.<TBaseBox>;
      
      protected var FShopRewardItems:Vector.<TBaseBox>;
      
      protected var FShopExchangePoint:int;
      
      public var TotalConsumeGold:int;
      
      public var TotalRechargeGold:int;
      
      public var ConsumeGift:Vector.<TBaseBox>;
      
      public var RankType:int;
      
      public var RankIndex:int;
      
      public var Equipments:TInventories;
      
      public var Titles:Vector.<uint>;
      
      public var DescListNew:Vector.<String>;
      
      public var RewardDescsNew:Vector.<String>;
      
      public function TBaseActivity()
      {
         super();
         this.FRewardStatus = new Vector.<int>();
         this.FNeedConfig = true;
         this.FLogList = new Vector.<TLotteryNews>();
         this.FDescList = new Vector.<String>();
         this.FRewardDescs = new Vector.<String>();
         this.FRankGiftList = new Vector.<TBaseBox>();
         this.FRankPlayerList = new Vector.<TConsumeRankInfo>();
         this.FShopExchangeItems = new Vector.<TBaseBox>();
         this.FShopRewardItems = new Vector.<TBaseBox>();
         this.ConsumeGift = new Vector.<TBaseBox>();
         this.Titles = new Vector.<uint>();
         this.DescListNew = new Vector.<String>();
         this.RewardDescsNew = new Vector.<String>();
         this.RankIndex = 1;
      }
      
      public static function GetStrByID(param1:String) : String
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
            }
         }
         else
         {
            _loc3_ = "ID = " + _loc2_;
         }
         return _loc3_;
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
      
      public function get Identify() : int
      {
         return this.FIdentify;
      }
      
      public function set Identify(param1:int) : void
      {
         this.FIdentify = param1;
      }
      
      public function get ActivityName() : String
      {
         return this.FActivityName;
      }
      
      public function set ActivityName(param1:String) : void
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
               this.FActivityName = _loc3_;
            }
         }
         else
         {
            this.FActivityName = param1;
         }
      }
      
      public function set ActivityTabName(param1:String) : void
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
               this.FActivityTabName = _loc3_;
            }
         }
         else
         {
            this.FActivityTabName = param1;
         }
      }
      
      public function get ActivityTabName() : String
      {
         return this.FActivityTabName;
      }
      
      public function get ActivityDesc() : String
      {
         return this.FActivityDesc;
      }
      
      public function set ActivityDesc(param1:String) : void
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
               this.FActivityDesc = _loc3_;
            }
         }
         else
         {
            this.FActivityDesc = param1;
         }
      }
      
      public function get BeginTime() : int
      {
         return this.FBeginTime;
      }
      
      public function set BeginTime(param1:int) : void
      {
         this.FBeginTime = param1;
      }
      
      public function get EndTime() : int
      {
         return this.FEndTime;
      }
      
      public function set EndTime(param1:int) : void
      {
         this.FEndTime = param1;
      }
      
      public function get Inventories() : TInventories
      {
         return this.FInventories;
      }
      
      public function set Inventories(param1:TInventories) : void
      {
         this.FInventories = param1;
      }
      
      public function get RewardStatus() : Vector.<int>
      {
         return this.FRewardStatus;
      }
      
      public function set RewardStatus(param1:Vector.<int>) : void
      {
         this.FRewardStatus = param1;
      }
      
      public function get PayEndTime() : int
      {
         return this.FPayEndTime;
      }
      
      public function set PayEndTime(param1:int) : void
      {
         this.FPayEndTime = param1;
      }
      
      public function get NeedConfig() : Boolean
      {
         return this.FNeedConfig;
      }
      
      public function set NeedConfig(param1:Boolean) : void
      {
         this.FNeedConfig = param1;
      }
      
      public function get EndType() : int
      {
         return this.FEndType;
      }
      
      public function set EndType(param1:int) : void
      {
         this.FEndType = param1;
      }
      
      public function get LogList() : Vector.<TLotteryNews>
      {
         return this.FLogList;
      }
      
      public function set LogList(param1:Vector.<TLotteryNews>) : void
      {
         this.FLogList = param1;
      }
      
      public function get IsOpen() : int
      {
         return this.FIsOpen;
      }
      
      public function set IsOpen(param1:int) : void
      {
         this.FIsOpen = param1;
      }
      
      public function get NeedShine() : int
      {
         return this.FNeedShine;
      }
      
      public function set NeedShine(param1:int) : void
      {
         this.FNeedShine = param1;
      }
      
      public function get ActivityDesc2() : String
      {
         return this.FActivityDesc2;
      }
      
      public function set ActivityDesc2(param1:String) : void
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
               this.FActivityDesc2 = _loc3_;
            }
         }
         else
         {
            this.FActivityDesc2 = param1;
         }
      }
      
      public function get ActivityDesc3() : String
      {
         return this.FActivityDesc3;
      }
      
      public function set ActivityDesc3(param1:String) : void
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
               this.FActivityDesc3 = _loc3_;
            }
         }
         else
         {
            this.FActivityDesc3 = param1;
         }
      }
      
      public function get DescList() : Vector.<String>
      {
         return this.FDescList;
      }
      
      public function set DescList(param1:Vector.<String>) : void
      {
         this.FDescList = param1;
      }
      
      public function get ActivityDesc4() : String
      {
         return this.FActivityDesc4;
      }
      
      public function set ActivityDesc4(param1:String) : void
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
               this.FActivityDesc4 = _loc3_;
            }
         }
         else
         {
            this.FActivityDesc4 = param1;
         }
      }
      
      public function get RewardDescs() : Vector.<String>
      {
         return this.FRewardDescs;
      }
      
      public function set RewardDescs(param1:Vector.<String>) : void
      {
         this.FRewardDescs = param1;
      }
      
      public function get CurMyRank() : int
      {
         return this.FCurMyRank;
      }
      
      public function set CurMyRank(param1:int) : void
      {
         this.FCurMyRank = param1;
      }
      
      public function get RankGiftList() : Vector.<TBaseBox>
      {
         return this.FRankGiftList;
      }
      
      public function set RankGiftList(param1:Vector.<TBaseBox>) : void
      {
         this.FRankGiftList = param1;
      }
      
      public function get RankPlayerList() : Vector.<TConsumeRankInfo>
      {
         return this.FRankPlayerList;
      }
      
      public function set RankPlayerList(param1:Vector.<TConsumeRankInfo>) : void
      {
         this.FRankPlayerList = param1;
      }
      
      public function get RankPoint() : int
      {
         return this.FRankPoint;
      }
      
      public function set RankPoint(param1:int) : void
      {
         this.FRankPoint = param1;
      }
      
      public function get NeedEffect() : int
      {
         return this.FNeedEffect;
      }
      
      public function set NeedEffect(param1:int) : void
      {
         this.FNeedEffect = param1;
      }
      
      public function get ShopExchangeItems() : Vector.<TBaseBox>
      {
         return this.FShopExchangeItems;
      }
      
      public function set ShopExchangeItems(param1:Vector.<TBaseBox>) : void
      {
         this.FShopExchangeItems = param1;
      }
      
      public function get ShopRewardItems() : Vector.<TBaseBox>
      {
         return this.FShopRewardItems;
      }
      
      public function set ShopRewardItems(param1:Vector.<TBaseBox>) : void
      {
         this.FShopRewardItems = param1;
      }
      
      public function get ShopExchangePoint() : int
      {
         return this.FShopExchangePoint;
      }
      
      public function set ShopExchangePoint(param1:int) : void
      {
         this.FShopExchangePoint = param1;
      }
      
      public function IsGoldEnough(param1:int) : Boolean
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGiftCertificate + _loc2_.CreditGold >= param1)
         {
            return true;
         }
         return false;
      }
      
      public function IsCreditGoldEnough(param1:int) : Boolean
      {
         var _loc2_:TCharacter = null;
         _loc2_ = SLogicsCore.Character;
         if(_loc2_.CreditGold >= param1)
         {
            return true;
         }
         return false;
      }
      
      public function IsActivityEnd(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = int(STimingCore.GetServerTick());
         if(param1 == PAY_END)
         {
            if(_loc2_ > this.FPayEndTime)
            {
               return true;
            }
            return false;
         }
         if(_loc2_ > this.FEndTime)
         {
            return true;
         }
         return false;
      }
      
      public function InitDescListNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
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
      
      public function InitRewardDescsNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         if(this.FRewardDescs.length > 0 && Boolean(this.FRewardDescs[0]))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.RewardDescsNew.length)
         {
            _loc2_ = int(parseInt(this.RewardDescsNew[_loc1_]));
            if(IsRealNumber(this.RewardDescsNew[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.FRewardDescs[_loc1_] = _loc3_;
               }
               else
               {
                  this.FRewardDescs[_loc1_] = this.RewardDescsNew[_loc1_];
               }
            }
            else
            {
               this.FRewardDescs[_loc1_] = this.RewardDescsNew[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}

