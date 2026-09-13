package Logics.Exercise.RechargeRank
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.ConsumeRank.TPerReward;
   import Logics.Exercise.TBaseActivity;
   import Logics.Inventories.TInventories;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TRechargeRank extends TBaseActivity
   {
      
      protected var FPerRank:int;
      
      protected var FPerScore:int;
      
      protected var FDiffScore:int;
      
      protected var FDesc2:String;
      
      protected var FDesc3:String;
      
      protected var FDesc4:String;
      
      protected var FDesc5:String;
      
      protected var FDesc6:String;
      
      protected var FDesc7:String;
      
      public var CurReturn:int;
      
      public var NextReturn:int;
      
      public var DiffGold:int;
      
      protected var FRankInfoList:Vector.<TRechargeRankInfo>;
      
      protected var FRankRewardList:Vector.<TRechargeRankReward>;
      
      protected var FPerRewardList:Vector.<TPerReward>;
      
      public var RechargeShowItems:TInventories;
      
      public var RechargeEquipments:TInventories;
      
      protected var FChangeTabIndex:int;
      
      public function TRechargeRank()
      {
         super();
         this.FRankInfoList = new Vector.<TRechargeRankInfo>();
         this.FRankRewardList = new Vector.<TRechargeRankReward>();
         this.FPerRewardList = new Vector.<TPerReward>();
         FNeedConfig = true;
      }
      
      public function get PerRank() : int
      {
         return this.FPerRank;
      }
      
      public function set PerRank(param1:int) : void
      {
         this.FPerRank = param1;
      }
      
      public function get PerScore() : int
      {
         return this.FPerScore;
      }
      
      public function set PerScore(param1:int) : void
      {
         this.FPerScore = param1;
      }
      
      public function get DiffScore() : int
      {
         return this.FDiffScore;
      }
      
      public function set DiffScore(param1:int) : void
      {
         this.FDiffScore = param1;
      }
      
      public function get RankInfoList() : Vector.<TRechargeRankInfo>
      {
         return this.FRankInfoList;
      }
      
      public function set RankInfoList(param1:Vector.<TRechargeRankInfo>) : void
      {
         this.FRankInfoList = param1;
      }
      
      public function get RankRewardList() : Vector.<TRechargeRankReward>
      {
         return this.FRankRewardList;
      }
      
      public function set RankRewardList(param1:Vector.<TRechargeRankReward>) : void
      {
         this.FRankRewardList = param1;
      }
      
      public function get PerRewardList() : Vector.<TPerReward>
      {
         return this.FPerRewardList;
      }
      
      public function set PerRewardList(param1:Vector.<TPerReward>) : void
      {
         this.FPerRewardList = param1;
      }
      
      public function get ChangeTabIndex() : int
      {
         return this.FChangeTabIndex;
      }
      
      public function set ChangeTabIndex(param1:int) : void
      {
         this.FChangeTabIndex = param1;
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
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
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
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
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
         if(TBaseActivity.IsRealNumber(param1) && !isNaN(_loc2_) && _loc2_ > 0)
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
      
      public function get Desc5() : String
      {
         return this.FDesc5;
      }
      
      public function set Desc5(param1:String) : void
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
               this.FDesc5 = _loc3_;
            }
         }
         else
         {
            this.FDesc5 = param1;
         }
      }
      
      public function get Desc6() : String
      {
         return this.FDesc6;
      }
      
      public function set Desc6(param1:String) : void
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
               this.FDesc6 = _loc3_;
            }
         }
         else
         {
            this.FDesc6 = param1;
         }
      }
      
      public function get Desc7() : String
      {
         return this.FDesc7;
      }
      
      public function set Desc7(param1:String) : void
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
               this.FDesc7 = _loc3_;
            }
         }
         else
         {
            this.FDesc7 = param1;
         }
      }
      
      public function CheckAwardStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TPerReward = null;
         _loc2_ = int(this.FPerRewardList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FPerRewardList[_loc1_];
            if(this.FPerScore >= _loc3_.Score)
            {
               if(_loc3_.Status == -1)
               {
                  _loc3_.Status = 0;
               }
            }
            _loc1_++;
         }
      }
   }
}

