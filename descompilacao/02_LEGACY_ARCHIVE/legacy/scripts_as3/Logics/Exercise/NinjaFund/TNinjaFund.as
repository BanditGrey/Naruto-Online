package Logics.Exercise.NinjaFund
{
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   
   public class TNinjaFund extends TBaseActivity
   {
      
      public static const FUND_COUNT:int = 5;
      
      public var NextTime:int;
      
      public var FreshPrice:int;
      
      public var FreshCount:int;
      
      public var RechargeGift:TBaseBox;
      
      public var Funds:Vector.<TBaseBox>;
      
      public var TotalFundDatas:Vector.<TBaseBox>;
      
      public var SaleItems:Vector.<TBaseBox>;
      
      public var FoodList:Vector.<int>;
      
      public function TNinjaFund()
      {
         super();
         this.Funds = new Vector.<TBaseBox>();
         this.TotalFundDatas = new Vector.<TBaseBox>();
         this.SaleItems = new Vector.<TBaseBox>();
         this.FoodList = new Vector.<int>();
         this.RechargeGift = new TBaseBox();
      }
      
      public function ChangeStatus() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBaseBox = null;
         var _loc3_:TBaseBox = null;
      }
      
      public function CheckStatus() : Boolean
      {
         return false;
      }
      
      public function GetFundDataByIndex(param1:int, param2:int) : TBaseBox
      {
         return this.TotalFundDatas[param1 + param2 * FUND_COUNT - 1];
      }
      
      public function AddItem(param1:int) : void
      {
         var _loc2_:TBaseBox = null;
         _loc2_ = this.SaleItems[param1];
         this.FoodList[_loc2_.Type - 1] += _loc2_.Count;
      }
   }
}

