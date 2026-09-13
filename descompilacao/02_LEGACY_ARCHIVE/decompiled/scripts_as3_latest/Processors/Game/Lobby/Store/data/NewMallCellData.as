package Processors.Game.Lobby.Store.data
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TNewMall;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class NewMallCellData
   {
      
      protected var FNewMall:TNewMall = null;
      
      protected var FArtial:TArticle = null;
      
      protected var FCurGoodsBuyCount:int;
      
      protected var FCanBuyCount:int;
      
      protected var FToDayCanBuyCount:int;
      
      protected var UnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FSelectInventories:TInventories;
      
      protected var FTempSelectInventoriesId:Vector.<uint>;
      
      protected var FCurGoodsIsShow:Boolean = true;
      
      protected var FBuyCondition:int;
      
      protected var FConditionCount:int;
      
      protected var FIsHaveCountCondition:Boolean;
      
      protected var FConditionIsOver_ShowOrHide:Boolean;
      
      public function NewMallCellData()
      {
         super();
         this.FTempSelectInventoriesId = new Vector.<uint>();
         this.FSelectInventories = new TInventories();
         this.UnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      }
      
      public function set NewMall(param1:TNewMall) : void
      {
         this.FNewMall = param1;
         this.FArtial = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param1.Itemid) as TArticle;
         this.UpdateInventory();
      }
      
      public function get NewMall() : TNewMall
      {
         return this.FNewMall;
      }
      
      public function set CurGoodsBuyCount(param1:int) : void
      {
         this.FCurGoodsBuyCount = param1;
         this.updateCondition();
      }
      
      public function updateCondition() : void
      {
         this.FBuyCondition = this.FNewMall.ConditionArr[0];
         this.FConditionCount = this.FNewMall.ConditionArr[1];
         if(this.FNewMall.BuyLimitArr[0] == 0 || this.FNewMall.BuyLimitArr[0] == 1 && this.FNewMall.BuyLimitArr[1] == 0 || this.FNewMall.BuyLimitArr[0] == 2 && this.FNewMall.BuyLimitArr[1] == 0)
         {
            this.FIsHaveCountCondition = false;
         }
         else
         {
            this.FCanBuyCount = this.FNewMall.BuyLimitArr[1];
            if(this.FCurGoodsBuyCount >= this.FCanBuyCount)
            {
               this.FCurGoodsIsShow = false;
            }
            this.FIsHaveCountCondition = true;
         }
         if(this.FNewMall.LimitDisplay)
         {
            this.FConditionIsOver_ShowOrHide = false;
         }
         else
         {
            this.FConditionIsOver_ShowOrHide = true;
         }
      }
      
      public function get CurGoodsBuyCount() : int
      {
         return this.FCurGoodsBuyCount;
      }
      
      public function get CanBuyCount() : int
      {
         return this.FCanBuyCount;
      }
      
      public function set ToDayCanBuyCount(param1:int) : void
      {
         this.FToDayCanBuyCount = param1;
      }
      
      public function get ToDayCanBuyCount() : int
      {
         return this.FToDayCanBuyCount;
      }
      
      public function get CurGoodsIsShow() : Boolean
      {
         return this.FCurGoodsIsShow;
      }
      
      public function get BuyCondition() : int
      {
         return this.FBuyCondition;
      }
      
      public function get ConditionCount() : int
      {
         return this.FConditionCount;
      }
      
      public function get IsHaveCountCondition() : Boolean
      {
         return this.FIsHaveCountCondition;
      }
      
      public function get ConditionIsOver_ShowOrHide() : Boolean
      {
         return this.FConditionIsOver_ShowOrHide;
      }
      
      public function get Artial() : TArticle
      {
         return this.FArtial;
      }
      
      protected function UpdateInventory() : void
      {
         this.FTempSelectInventoriesId.length = 0;
         this.FSelectInventories.Clear();
         this.FTempSelectInventoriesId.push(this.FArtial.Identifier);
         this.UnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
      }
      
      public function GetTInventorie() : TInventory
      {
         return this.FSelectInventories.GetInventoryByIndex(0);
      }
   }
}

