package Processors.Game.Lobby.Shop.data
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TItemMall;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class ShopData
   {
      
      protected var ShopDataVec:Array;
      
      public function ShopData()
      {
         super();
         this.ShopDataVec = new Array();
      }
      
      public function InitShopData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TBins = null;
         var _loc3_:TItemMall = null;
         var _loc4_:ShopCellData = null;
         var _loc5_:int = 0;
         _loc2_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_ItemMall) as TBins;
         _loc1_ = 0;
         while(_loc1_ < _loc2_.Count)
         {
            _loc3_ = _loc2_.GetDatebaseByIndex(_loc1_) as TItemMall;
            _loc4_ = new ShopCellData();
            _loc4_.ItemMall = _loc3_;
            _loc5_ = _loc3_.Tpye - 1;
            if(this.ShopDataVec[_loc5_] == undefined)
            {
               this.ShopDataVec[_loc5_] = new Array();
            }
            this.ShopDataVec[_loc5_].push(_loc4_);
            _loc1_++;
         }
      }
      
      public function SetValueByByteArray(param1:ByteArray) : void
      {
         var _loc5_:TItemMall = null;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:ShopCellData = null;
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc3_:int = int(param1.readUnsignedInt());
         var _loc4_:int = int(param1.readUnsignedInt());
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ItemMall,_loc2_) as TItemMall;
         _loc7_ = this.ShopDataVec[_loc5_.Tpye - 1];
         _loc6_ = 0;
         while(_loc6_ < _loc7_.length)
         {
            _loc8_ = _loc7_[_loc6_] as ShopCellData;
            if(_loc8_.ItemMall.Identifier == _loc2_)
            {
               _loc8_.CanBuyCount = _loc5_.Maxbuy - _loc4_;
               _loc8_.TodayCanBuyCount = _loc5_.Daybuy - _loc3_;
               break;
            }
            _loc6_++;
         }
      }
      
      public function getArrByType(param1:int) : Array
      {
         var _loc2_:Array = null;
         return this.ShopDataVec[param1];
      }
   }
}

