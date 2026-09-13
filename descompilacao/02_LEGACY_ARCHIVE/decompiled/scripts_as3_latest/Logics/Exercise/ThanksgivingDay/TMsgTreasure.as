package Logics.Exercise.ThanksgivingDay
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TMsgTreasure
   {
      
      public static const MAX_COUNT:int = 9;
      
      protected var FTreasureMapBoxList:Vector.<TBaseBox>;
      
      protected var FRewardDesc:Vector.<String>;
      
      protected var FTreasureMapIndex:int;
      
      protected var FTreasureStatus:int;
      
      protected var FNeedScore:int;
      
      protected var FPrize:int;
      
      public var RewardDescNew:Vector.<String>;
      
      public function TMsgTreasure()
      {
         var _loc1_:int = 0;
         super();
         this.FTreasureMapBoxList = new Vector.<TBaseBox>(MAX_COUNT);
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            this.FTreasureMapBoxList[_loc1_] = new TBaseBox();
            _loc1_++;
         }
         this.FRewardDesc = new Vector.<String>();
      }
      
      public function get Prize() : int
      {
         return this.FPrize;
      }
      
      public function set Prize(param1:int) : void
      {
         this.FPrize = param1;
      }
      
      public function get NeedScore() : int
      {
         return this.FNeedScore;
      }
      
      public function set NeedScore(param1:int) : void
      {
         this.FNeedScore = param1;
      }
      
      public function get TreasureStatus() : int
      {
         return this.FTreasureStatus;
      }
      
      public function set TreasureStatus(param1:int) : void
      {
         this.FTreasureStatus = param1;
      }
      
      public function get TreasureMapIndex() : int
      {
         return this.FTreasureMapIndex;
      }
      
      public function set TreasureMapIndex(param1:int) : void
      {
         this.FTreasureMapIndex = param1;
      }
      
      public function get RewardDesc() : Vector.<String>
      {
         return this.FRewardDesc;
      }
      
      public function set RewardDesc(param1:Vector.<String>) : void
      {
         this.FRewardDesc = param1;
      }
      
      public function get TreasureMapBoxList() : Vector.<TBaseBox>
      {
         return this.FTreasureMapBoxList;
      }
      
      public function set TreasureMapBoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FTreasureMapBoxList = param1;
      }
      
      public function InitRewardDescNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         if(this.RewardDesc.length > 0 && Boolean(this.RewardDesc[0]))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.RewardDescNew.length)
         {
            _loc2_ = int(parseInt(this.RewardDescNew[_loc1_]));
            if(TBaseActivity.IsRealNumber(this.RewardDescNew[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.RewardDesc[_loc1_] = _loc3_;
               }
               else
               {
                  this.RewardDesc[_loc1_] = this.RewardDescNew[_loc1_];
               }
            }
            else
            {
               this.RewardDesc[_loc1_] = this.RewardDescNew[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}

