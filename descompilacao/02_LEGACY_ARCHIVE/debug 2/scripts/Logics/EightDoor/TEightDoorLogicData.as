package Logics.EightDoor
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TEightInnerGates_Attr;
   import Logics.DatebaseVO.VO.TEightInnerGates_Mission;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TEightDoorLogicData
   {
      
      protected var FWenRouTiaoJiao:Vector.<uint>;
      
      protected var FEMengTiaoJiao:Vector.<uint>;
      
      protected var FDiYuTiaoJiao:Vector.<uint>;
      
      protected var FEightDoorMoRenOpenCount:uint;
      
      protected var FEightDoorBuyCountGoldCount:Vector.<uint>;
      
      protected var FEightDoorPuTongFanBeiGoldCount:uint;
      
      protected var FEightDoorBiDingFanBeiGoldCount:uint;
      
      protected var FEightDoorBuyMaxCount:uint;
      
      protected var FEightDoorBuyMaxPageCount:uint;
      
      protected var FGodStoreCount:uint;
      
      protected var FPiShanCount:uint;
      
      protected var FPiShanBuyCount:uint;
      
      protected var FCurState:int;
      
      protected var FCostTypeVec:Vector.<int>;
      
      protected var FGetRewardVec1:Vector.<uint>;
      
      protected var FGetRewardVec2:Vector.<uint>;
      
      protected var FGetRewardVec3:Vector.<uint>;
      
      protected var FGetRewardVec4:Vector.<uint>;
      
      protected var FTianShiId:uint;
      
      protected var FOpenedLastId:int;
      
      public function TEightDoorLogicData()
      {
         super();
         this.FCostTypeVec = new Vector.<int>(3);
         this.FGetRewardVec1 = new Vector.<uint>();
         this.FGetRewardVec2 = new Vector.<uint>();
         this.FGetRewardVec3 = new Vector.<uint>();
         this.FGetRewardVec4 = new Vector.<uint>();
      }
      
      public function set PiShanBuyCount(param1:uint) : void
      {
         this.FPiShanBuyCount = param1;
      }
      
      public function get PiShanBuyCount() : uint
      {
         return this.FPiShanBuyCount;
      }
      
      public function set PiShanCount(param1:uint) : void
      {
         this.FPiShanCount = param1;
      }
      
      public function get PiShanCount() : uint
      {
         return this.FPiShanCount;
      }
      
      public function set GodStoreCount(param1:uint) : void
      {
         this.FGodStoreCount = param1;
      }
      
      public function get GodStoreCount() : uint
      {
         return this.FGodStoreCount;
      }
      
      public function set EightDoorMoRenOpenCount(param1:uint) : void
      {
         this.FEightDoorMoRenOpenCount = param1;
      }
      
      public function get EightDoorMoRenOpenCount() : uint
      {
         return this.FEightDoorMoRenOpenCount;
      }
      
      public function get WenRouTiaoJiao() : Vector.<uint>
      {
         return this.FWenRouTiaoJiao;
      }
      
      public function set WenRouTiaoJiao(param1:Vector.<uint>) : void
      {
         this.FWenRouTiaoJiao = param1;
      }
      
      public function get EMengTiaoJiao() : Vector.<uint>
      {
         return this.FEMengTiaoJiao;
      }
      
      public function set EMengTiaoJiao(param1:Vector.<uint>) : void
      {
         this.FEMengTiaoJiao = param1;
      }
      
      public function get DiYuTiaoJiao() : Vector.<uint>
      {
         return this.FDiYuTiaoJiao;
      }
      
      public function set DiYuTiaoJiao(param1:Vector.<uint>) : void
      {
         this.FDiYuTiaoJiao = param1;
      }
      
      public function set EightDoorBuyCountGoldCount(param1:Vector.<uint>) : void
      {
         this.FEightDoorBuyCountGoldCount = param1;
      }
      
      public function get EightDoorBuyCountGoldCount() : Vector.<uint>
      {
         return this.FEightDoorBuyCountGoldCount;
      }
      
      public function set EightDoorPuTongFanBeiGoldCount(param1:uint) : void
      {
         this.FEightDoorPuTongFanBeiGoldCount = param1;
      }
      
      public function get EightDoorPuTongFanBeiGoldCount() : uint
      {
         return this.FEightDoorPuTongFanBeiGoldCount;
      }
      
      public function set EightDoorBiDingFanBeiGoldCount(param1:uint) : void
      {
         this.FEightDoorBiDingFanBeiGoldCount = param1;
      }
      
      public function get EightDoorBiDingFanBeiGoldCount() : uint
      {
         return this.FEightDoorBiDingFanBeiGoldCount;
      }
      
      public function set EightDoorBuyMaxCount(param1:uint) : void
      {
         this.FEightDoorBuyMaxCount = param1;
      }
      
      public function get EightDoorBuyMaxCount() : uint
      {
         return this.FEightDoorBuyMaxCount;
      }
      
      public function set EightDoorBuyMaxPageCount(param1:uint) : void
      {
         this.FEightDoorBuyMaxPageCount = param1;
      }
      
      public function get EightDoorBuyMaxPageCount() : uint
      {
         return this.FEightDoorBuyMaxPageCount;
      }
      
      public function set CurState(param1:int) : void
      {
         this.FCurState = param1;
      }
      
      public function get CurState() : int
      {
         return this.FCurState;
      }
      
      public function set OpenedLastId(param1:int) : void
      {
         this.FOpenedLastId = param1;
      }
      
      public function get OpenedLastId() : int
      {
         return this.FOpenedLastId;
      }
      
      public function get CostTypeVec() : Vector.<int>
      {
         return this.FCostTypeVec;
      }
      
      public function ClearVecLength() : void
      {
         this.FGetRewardVec1.length = 0;
         this.FGetRewardVec2.length = 0;
         this.FGetRewardVec3.length = 0;
         this.FGetRewardVec4.length = 0;
      }
      
      public function GetRewardVecById(param1:int) : Vector.<uint>
      {
         var _loc2_:Vector.<uint> = null;
         switch(param1)
         {
            case 0:
               _loc2_ = this.FGetRewardVec1;
               break;
            case 1:
               _loc2_ = this.FGetRewardVec2;
               break;
            case 2:
               _loc2_ = this.FGetRewardVec3;
               break;
            case 3:
               _loc2_ = this.FGetRewardVec4;
         }
         return _loc2_;
      }
      
      public function set TianShiId(param1:uint) : void
      {
         this.FTianShiId = param1;
      }
      
      public function get TianShiId() : uint
      {
         return this.FTianShiId;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:TEightInnerGates_Attr = null;
         var _loc3_:TEightDoorLogicData = null;
         var _loc4_:TEightInnerGates_Mission = null;
         var _loc5_:uint = 0;
         _loc3_ = SLogicsCore.EightDoorLogicData;
         if(SLogicsCore.EightDoorLogicData.OpenedLastId == 0)
         {
            _loc1_ = 10000001;
         }
         else
         {
            _loc1_ = SLogicsCore.EightDoorLogicData.OpenedLastId + 1;
         }
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Attr,_loc1_) as TEightInnerGates_Attr;
         if(Boolean(_loc2_) && SLogicsCore.EightDoorLogicData.GodStoreCount >= _loc2_.Consumption)
         {
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EightInnerGates_Mission,_loc2_.MajorType) as TEightInnerGates_Mission;
            _loc5_ = uint(SLogicsCore.Character.GetMainLevel());
            if(Boolean(_loc4_) && _loc5_ >= _loc4_.Level)
            {
               return true;
            }
         }
         if(_loc3_.EightDoorMoRenOpenCount + _loc3_.PiShanBuyCount - _loc3_.PiShanCount > 0)
         {
            return true;
         }
         return false;
      }
   }
}

