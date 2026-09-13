package Logics.Exercise.ThanksgivingDay
{
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TThanksgivingDay3 extends TBaseActivity
   {
      
      protected var FFreeCount:int;
      
      protected var FMyPower:int;
      
      protected var FPowerPrice:int;
      
      protected var FPet:TBaseBox;
      
      protected var FRound:int;
      
      protected var FBigBox:TBaseBox;
      
      protected var FItemID:uint;
      
      protected var FDartID:uint;
      
      protected var FBoxList:Vector.<TBaseBox>;
      
      public var RankList:Vector.<TConsumeRankInfo>;
      
      public var RankRewardList:Vector.<TBaseBox>;
      
      public function TThanksgivingDay3()
      {
         super();
         this.FBoxList = new Vector.<TBaseBox>();
         this.RankList = new Vector.<TConsumeRankInfo>();
         this.RankRewardList = new Vector.<TBaseBox>();
      }
      
      public function get FreeCount() : int
      {
         return this.FFreeCount;
      }
      
      public function set FreeCount(param1:int) : void
      {
         this.FFreeCount = param1;
      }
      
      public function get MyPower() : int
      {
         return this.FMyPower;
      }
      
      public function set MyPower(param1:int) : void
      {
         this.FMyPower = param1;
      }
      
      public function get PowerPrice() : int
      {
         return this.FPowerPrice;
      }
      
      public function set PowerPrice(param1:int) : void
      {
         this.FPowerPrice = param1;
      }
      
      public function get BigBox() : TBaseBox
      {
         return this.FBigBox;
      }
      
      public function set BigBox(param1:TBaseBox) : void
      {
         this.FBigBox = param1;
      }
      
      public function get BoxList() : Vector.<TBaseBox>
      {
         return this.FBoxList;
      }
      
      public function set BoxList(param1:Vector.<TBaseBox>) : void
      {
         this.FBoxList = param1;
      }
      
      public function get Round() : int
      {
         return this.FRound;
      }
      
      public function set Round(param1:int) : void
      {
         this.FRound = param1;
      }
      
      public function get Pet() : TBaseBox
      {
         return this.FPet;
      }
      
      public function set Pet(param1:TBaseBox) : void
      {
         this.FPet = param1;
      }
      
      public function get ItemID() : uint
      {
         return this.FItemID;
      }
      
      public function set ItemID(param1:uint) : void
      {
         this.FItemID = param1;
      }
      
      public function get DartID() : uint
      {
         return this.FDartID;
      }
      
      public function set DartID(param1:uint) : void
      {
         this.FDartID = param1;
      }
      
      public function ChangeStatus() : void
      {
         if(Boolean(this.FBigBox) && Boolean(this.FBigBox.Status == TBaseActivity.STATUS_CANNOTGET) && FRankPoint >= this.FBigBox.Price)
         {
            this.FBigBox.Status = TBaseActivity.STATUS_CANGET;
         }
      }
   }
}

