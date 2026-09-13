package Logics.Exercise.OctActive
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TActivityDesc;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Lottery.TLotteryNews;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TOctActive2 extends TBaseActivity
   {
      
      protected var FMyScore:int;
      
      protected var FResetPrice:int;
      
      protected var FIsBoxVisible:int;
      
      protected var FIsDescVisible:int;
      
      protected var FRate:int;
      
      protected var FScoreA:int;
      
      protected var FScoreB:int;
      
      protected var FBigCannon:TBaseBox;
      
      protected var FPointList:Vector.<TBaseBox>;
      
      protected var FCannonList:Vector.<TBaseBox>;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      protected var FPointDesc:Vector.<String>;
      
      protected var FNewsList:Vector.<TLotteryNews>;
      
      public var PointDescNew:Vector.<String>;
      
      public function TOctActive2()
      {
         super();
         this.FPointList = new Vector.<TBaseBox>();
         this.FCannonList = new Vector.<TBaseBox>();
         this.FBoxList = new Vector.<TBaseBox>();
         this.FPointDesc = new Vector.<String>();
         this.FNewsList = new Vector.<TLotteryNews>();
         this.PointDescNew = new Vector.<String>();
      }
      
      public function get MyScore() : int
      {
         return this.FMyScore;
      }
      
      public function set MyScore(param1:int) : void
      {
         this.FMyScore = param1;
      }
      
      public function get ResetPrice() : int
      {
         return this.FResetPrice;
      }
      
      public function set ResetPrice(param1:int) : void
      {
         this.FResetPrice = param1;
      }
      
      public function get PointList() : Vector.<TBaseBox>
      {
         return this.FPointList;
      }
      
      public function set PointList(param1:Vector.<TBaseBox>) : void
      {
         this.FPointList = param1;
      }
      
      public function get CannonList() : Vector.<TBaseBox>
      {
         return this.FCannonList;
      }
      
      public function set CannonList(param1:Vector.<TBaseBox>) : void
      {
         this.FCannonList = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get BigCannon() : TBaseBox
      {
         return this.FBigCannon;
      }
      
      public function set BigCannon(param1:TBaseBox) : void
      {
         this.FBigCannon = param1;
      }
      
      public function get IsBoxVisible() : int
      {
         return this.FIsBoxVisible;
      }
      
      public function set IsBoxVisible(param1:int) : void
      {
         this.FIsBoxVisible = param1;
      }
      
      public function get IsDescVisible() : int
      {
         return this.FIsDescVisible;
      }
      
      public function set IsDescVisible(param1:int) : void
      {
         this.FIsDescVisible = param1;
      }
      
      public function get Rate() : int
      {
         return this.FRate;
      }
      
      public function set Rate(param1:int) : void
      {
         this.FRate = param1;
      }
      
      public function get PointDesc() : Vector.<String>
      {
         return this.FPointDesc;
      }
      
      public function set PointDesc(param1:Vector.<String>) : void
      {
         this.FPointDesc = param1;
      }
      
      public function get ScoreA() : int
      {
         return this.FScoreA;
      }
      
      public function set ScoreA(param1:int) : void
      {
         this.FScoreA = param1;
      }
      
      public function get ScoreB() : int
      {
         return this.FScoreB;
      }
      
      public function set ScoreB(param1:int) : void
      {
         this.FScoreB = param1;
      }
      
      public function get NewsList() : Vector.<TLotteryNews>
      {
         return this.FNewsList;
      }
      
      public function set NewsList(param1:Vector.<TLotteryNews>) : void
      {
         this.FNewsList = param1;
      }
      
      public function ChangeStatus() : void
      {
      }
      
      public function InitPointDescNew() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:TActivityDesc = null;
         if(this.PointDescNew.length > 0 && Boolean(this.PointDescNew[0]))
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < this.PointDescNew.length)
         {
            _loc2_ = int(parseInt(this.PointDescNew[_loc1_]));
            if(TBaseActivity.IsRealNumber(this.PointDescNew[_loc1_]) && !isNaN(_loc2_) && _loc2_ > 0)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ActivityDesc,_loc2_) as TActivityDesc;
               if(_loc4_)
               {
                  _loc3_ = _loc4_.Desc;
                  _loc3_ = _loc3_.split("&lt;").join("<");
                  _loc3_ = _loc3_.split("&gt;").join(">");
                  this.FPointDesc[_loc1_] = _loc3_;
               }
               else
               {
                  this.FPointDesc[_loc1_] = FDescList[_loc1_];
               }
            }
            else
            {
               this.FPointDesc[_loc1_] = FDescList[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}

