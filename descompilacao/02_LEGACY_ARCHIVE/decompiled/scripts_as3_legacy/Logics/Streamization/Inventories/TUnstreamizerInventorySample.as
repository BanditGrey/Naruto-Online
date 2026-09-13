package Logics.Streamization.Inventories
{
   import Foundation.Resources.SResourcesCore;
   import Logics.CrossServerWar.TOrangeInventorySample;
   import Logics.CrossServerWar.TTokenInventorySample;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TChallengeMall;
   import Logics.DatebaseVO.VO.TDrawNinjaMall;
   import Logics.DatebaseVO.VO.TGSPVP_CreditExchange;
   import Logics.DatebaseVO.VO.TGSPVP_GemExchange;
   import Logics.DatebaseVO.VO.TGlobalArenaMall;
   import Logics.DatebaseVO.VO.TGlobalBattleMall;
   import Logics.DatebaseVO.VO.TKingBattleMall;
   import Logics.DatebaseVO.VO.TMall;
   import Logics.DatebaseVO.VO.TPvpMall;
   import Logics.DatebaseVO.VO.TSummonBattleMall;
   import Logics.Inventories.TInventory;
   import Logics.Inventories.TInventorySample;
   import Resources.Constants.CONST_DATEBASEVO;
   import flash.utils.ByteArray;
   
   public class TUnstreamizerInventorySample extends TUnstreamizerInventoryReference
   {
      
      protected var FUnstreamizerInventorySamplePrices:TUnstreamizerInventorySamplePrices;
      
      public function TUnstreamizerInventorySample()
      {
         super();
         this.FUnstreamizerInventorySamplePrices = new TUnstreamizerInventorySamplePrices();
      }
      
      override protected function UnstreamizationPerform(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.Unstreamizationperform_BaseInfo(param1,param2,param3);
      }
      
      protected function Unstreamizationperform_BaseInfo(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         _loc4_ = param2 as TInventorySample;
         this.UnstreamizationPerform_Inventory(param1,_loc4_,param3);
      }
      
      override protected function UnstreamizationPerform_Inventory(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TUnstreamizerInventory = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param1.readUnsignedByte();
         _loc6_ = AcquireInventory(_loc5_);
         _loc7_ = InventoryUnstreamizerByCategory(_loc5_);
         _loc7_.Unstreamize(param1,_loc6_,param3);
         _loc4_.Inventory = _loc6_;
      }
      
      protected function UnstreamizationPerform_InventorySampleByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:TMall = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param3 as TMall;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.Model = _loc5_.Model;
         _loc4_.Name = _loc5_.Name;
         _loc4_.MajorType = _loc5_.MajorType;
         _loc4_.TemplateID = _loc5_.Itemid;
         _loc4_.ConsumeType = _loc5_.Type;
         _loc4_.Integration = _loc5_.Integration;
         _loc4_.UnlockLevel = _loc5_.Level;
         _loc4_.IsVip = _loc5_.Isvip;
         _loc4_.IsDisplay = _loc5_.Display;
         _loc4_.Amount = _loc5_.Amount;
         _loc4_.CostGold = _loc5_.Gold;
         _loc4_.Discount = _loc5_.Discount;
         _loc4_.HotPrice = _loc5_.Hotprice;
         _loc4_.Page = _loc5_.Page;
         _loc4_.VipLevel = _loc5_.Vip;
         _loc4_.IsHot = _loc5_.Ishot;
         _loc4_.IsNew = _loc5_.Isnew;
         _loc4_.BuyTimes = _loc5_.Times;
         this.UnstreamizationPerform_InventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_InventorySample(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TUnstreamizerInventory = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = _loc4_.MajorType;
         _loc6_ = AcquireInventory(_loc5_);
         _loc7_ = InventoryUnstreamizerByCategory(_loc5_);
         _loc6_.IDTemplate = _loc4_.TemplateID;
         _loc7_.UnstreamizeGenerateInventory(param1,_loc6_,param3);
         _loc4_.Inventory = _loc6_;
      }
      
      protected function UnstreamizationPerform_OrangeInventorySampleByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TOrangeInventorySample = null;
         var _loc5_:TGSPVP_GemExchange = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TOrangeInventorySample;
         _loc5_ = param3 as TGSPVP_GemExchange;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.TemplateID = _loc5_.ItemId;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.ItemId) as TArticle;
         if(_loc6_ != null)
         {
            _loc4_.MajorType = _loc6_.MajorType;
         }
         _loc4_.Type = _loc5_.Type;
         _loc4_.Amount = _loc5_.GetCount;
         _loc4_.ExchangeItem = _loc5_.ExchangeItem;
         _loc4_.ExchangeCount = _loc5_.ExchangeCount;
         _loc4_.VipLevel = _loc5_.Vip;
         this.UnstreamizationPerform_OrangeInventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_OrangeInventorySample(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TOrangeInventorySample = null;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TUnstreamizerInventory = null;
         _loc4_ = param2 as TOrangeInventorySample;
         _loc5_ = _loc4_.MajorType;
         if(_loc5_ > 0)
         {
            _loc6_ = AcquireInventory(_loc5_);
            _loc7_ = InventoryUnstreamizerByCategory(_loc5_);
            if(_loc6_ != null)
            {
               _loc6_.IDTemplate = _loc4_.TemplateID;
            }
            if(_loc7_ != null)
            {
               _loc7_.UnstreamizeGenerateInventory(param1,_loc6_,param3);
            }
         }
         _loc4_.Inventory = _loc6_;
      }
      
      protected function UnstreamizationPerform_TokenInventorySampleByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TTokenInventorySample = null;
         var _loc5_:TGSPVP_CreditExchange = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TTokenInventorySample;
         _loc5_ = param3 as TGSPVP_CreditExchange;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.TemplateID = _loc5_.ItemId;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.ItemId) as TArticle;
         _loc4_.MajorType = _loc6_.MajorType;
         _loc4_.Amount = _loc5_.GetCount;
         _loc4_.ExchangeItem = _loc5_.ExchangeItem;
         _loc4_.ExchangeCount = _loc5_.ExchangeCount;
         _loc4_.VipLevel = _loc5_.Vip;
         this.UnstreamizationPerform_TokenInventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_TokenInventorySample(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TTokenInventorySample = null;
         var _loc5_:uint = 0;
         var _loc6_:TInventory = null;
         var _loc7_:TUnstreamizerInventory = null;
         _loc4_ = param2 as TTokenInventorySample;
         _loc5_ = _loc4_.MajorType;
         _loc6_ = AcquireInventory(_loc5_);
         _loc7_ = InventoryUnstreamizerByCategory(_loc5_);
         if(_loc6_ != null)
         {
            _loc6_.IDTemplate = _loc4_.TemplateID;
         }
         if(_loc7_ != null)
         {
            _loc7_.UnstreamizeGenerateInventory(param1,_loc6_,param3);
         }
         _loc4_.Inventory = _loc6_;
      }
      
      protected function UnstreamizationPerform_PvpMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:TPvpMall = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param3 as TPvpMall;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.Itemid) as TArticle;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.Name = _loc5_.Name;
         if(_loc6_ != null)
         {
            _loc4_.MajorType = _loc6_.MajorType;
         }
         else
         {
            _loc4_.MajorType = _loc5_.MajorType;
         }
         _loc4_.TemplateID = _loc5_.Itemid;
         _loc4_.Integration = _loc5_.Integration;
         _loc4_.UnlockLevel = _loc5_.Level;
         _loc4_.IsVip = _loc5_.Isvip;
         _loc4_.Amount = _loc5_.Amount;
         _loc4_.Page = _loc5_.Page;
         _loc4_.BuyTimes = _loc5_.Times;
         this.UnstreamizationPerform_InventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_ChallengeMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:TChallengeMall = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param3 as TChallengeMall;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.Itemid) as TArticle;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.Name = _loc5_.Name;
         _loc4_.TemplateID = _loc5_.Itemid;
         _loc4_.Integration = _loc5_.Integration;
         _loc4_.Amount = _loc5_.Amount;
         _loc4_.Page = _loc5_.Page;
         _loc4_.MajorType = _loc6_.MajorType;
         this.UnstreamizationPerform_InventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_KingBattleMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:TKingBattleMall = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param3 as TKingBattleMall;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.Itemid) as TArticle;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.TemplateID = _loc5_.Itemid;
         _loc4_.Integration = _loc5_.Integration;
         _loc4_.Amount = _loc5_.Amount;
         _loc4_.Page = _loc5_.Page;
         _loc4_.Model = _loc5_.Heroid;
         _loc4_.Name = _loc6_.Name;
         this.UnstreamizationPerform_InventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_GlobalBattleMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:TGlobalBattleMall = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param3 as TGlobalBattleMall;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.Itemid) as TArticle;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.TemplateID = _loc5_.Itemid;
         _loc4_.Integration = _loc5_.Integration;
         _loc4_.Amount = _loc5_.Amount;
         _loc4_.Page = _loc5_.Page;
         _loc4_.Model = _loc5_.Heroid;
         _loc4_.Name = _loc6_.Name;
         this.UnstreamizationPerform_InventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_GlobalArenaMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:TGlobalArenaMall = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param3 as TGlobalArenaMall;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.Itemid) as TArticle;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.TemplateID = _loc5_.Itemid;
         _loc4_.Integration = _loc5_.Integration;
         _loc4_.Amount = _loc5_.Amount;
         _loc4_.Page = _loc5_.Page;
         _loc4_.Model = _loc5_.Heroid;
         _loc4_.Name = _loc6_.Name;
         this.UnstreamizationPerform_InventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_SummonBattleMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:TSummonBattleMall = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param3 as TSummonBattleMall;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.Itemid) as TArticle;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.TemplateID = _loc5_.Itemid;
         _loc4_.Integration = _loc5_.Integration;
         _loc4_.Amount = _loc5_.Amount;
         _loc4_.Page = _loc5_.Page;
         _loc4_.Model = _loc5_.Heroid;
         _loc4_.Name = _loc6_.Name;
         this.UnstreamizationPerform_InventorySample(param1,_loc4_,0);
      }
      
      protected function UnstreamizationPerform_DrawNinjaMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         var _loc4_:TInventorySample = null;
         var _loc5_:TDrawNinjaMall = null;
         var _loc6_:TArticle = null;
         _loc4_ = param2 as TInventorySample;
         _loc5_ = param3 as TDrawNinjaMall;
         _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,_loc5_.Itemid) as TArticle;
         _loc4_.Indentifier = _loc5_.Identifier;
         _loc4_.TemplateID = _loc5_.Itemid;
         _loc4_.Integration = _loc5_.Integration;
         _loc4_.Amount = _loc5_.Amount;
         _loc4_.Page = _loc5_.Page;
         _loc4_.Model = _loc5_.Heroid;
         _loc4_.Name = _loc6_.Name;
         this.UnstreamizationPerform_InventorySample(param1,_loc4_,0);
      }
      
      public function UnstreamizeInventorySampleByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_InventorySampleByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizeOrangeInventorySampleByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_OrangeInventorySampleByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizeTokenInventorySampleByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_TokenInventorySampleByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizePvpMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_PvpMallByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizeChallengeMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_ChallengeMallByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizerKingBattleMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_KingBattleMallByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizerGlobalBattleMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_GlobalBattleMallByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizerGlobalArenaMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_GlobalArenaMallByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizerSummonBattleMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_SummonBattleMallByDatabase(param1,param2,param3);
      }
      
      public function UnstreamizerDrawNinjaMallByDatabase(param1:ByteArray, param2:Object, param3:Object) : void
      {
         this.UnstreamizationPerform_DrawNinjaMallByDatabase(param1,param2,param3);
      }
   }
}

