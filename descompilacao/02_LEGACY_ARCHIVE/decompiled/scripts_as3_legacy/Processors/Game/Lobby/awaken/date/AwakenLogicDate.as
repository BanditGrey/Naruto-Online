package Processors.Game.Lobby.awaken.date
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Logics.DatebaseVO.VO.TAwakenConfig;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class AwakenLogicDate
   {
      
      public static const THREE:int = 3;
      
      protected var FNextTimesVec:Vector.<uint>;
      
      protected var FDangRiYiDuiHuanCount:Vector.<uint>;
      
      protected var FDangRiYiShiYongDuiHuanCount:Vector.<uint>;
      
      protected var FPiLiangCountVec:Vector.<uint>;
      
      protected var FDanCiCountVec:Vector.<uint>;
      
      protected var FChangeCountVec:Vector.<uint>;
      
      protected var FSuiPianId:uint;
      
      protected var FDanRiMastCount:int;
      
      protected var FPiLiangMastCount:int;
      
      protected var FDiJiDanCiMastCount:uint;
      
      protected var FDiJiPiLiangDanCiMastCount:uint;
      
      protected var FZhongJiDanCiMastCount:uint;
      
      protected var FZhongJiPiLiangDanCiMastCount:uint;
      
      protected var FGaoJiDanCiMastCount:uint;
      
      protected var FGaoJiPiLiangDanCiMastCount:uint;
      
      protected var FDaoJiDiJiTanSuoCount:Vector.<uint>;
      
      protected var FDaoJiZhongJiTanSuoCount:Vector.<uint>;
      
      protected var FDaoJiGaoJiTanSuoCount:Vector.<uint>;
      
      protected var FBarCount:int;
      
      protected var FTanSuoIdVec:Vector.<uint>;
      
      protected var FTanSuoCountVec:Vector.<uint>;
      
      protected var FBackPackageVecCopy:Vector.<AwakenDateCELL> = null;
      
      protected var vc1:Vector.<AwakenDateCELL> = null;
      
      protected var vc2:Vector.<AwakenDateCELL> = null;
      
      protected var vc3:Vector.<AwakenDateCELL> = null;
      
      protected var vc4:Vector.<AwakenDateCELL> = null;
      
      protected var FGetRewardTakeNotes:Vector.<AwakenDateCELL> = null;
      
      protected var FTanSuoBtnIsCanClick:int;
      
      public var CommonCount:int;
      
      public var AwakenConfigBins:TBins;
      
      public function AwakenLogicDate()
      {
         super();
         this.FNextTimesVec = new Vector.<uint>(THREE);
         this.FDangRiYiDuiHuanCount = new Vector.<uint>(THREE);
         this.FDangRiYiShiYongDuiHuanCount = new Vector.<uint>(THREE);
         this.FPiLiangCountVec = new Vector.<uint>(THREE);
         this.FDanCiCountVec = new Vector.<uint>(THREE);
         this.FChangeCountVec = new Vector.<uint>(THREE);
         this.FBackPackageVecCopy = new Vector.<AwakenDateCELL>();
         this.vc1 = new Vector.<AwakenDateCELL>();
         this.vc2 = new Vector.<AwakenDateCELL>();
         this.vc3 = new Vector.<AwakenDateCELL>();
         this.vc4 = new Vector.<AwakenDateCELL>();
         this.FTanSuoIdVec = new Vector.<uint>();
         this.FTanSuoCountVec = new Vector.<uint>();
         this.FGetRewardTakeNotes = new Vector.<AwakenDateCELL>();
      }
      
      public function GetCountById(param1:uint) : int
      {
         var _loc2_:int = 0;
         var _loc3_:AwakenDateCELL = new AwakenDateCELL();
         var _loc4_:Vector.<AwakenDateCELL> = null;
         var _loc5_:int = 0;
         _loc3_.SetValueById(param1);
         switch(_loc3_.AwakenConfigDate.Type)
         {
            case 1:
               _loc4_ = this.vc1;
               break;
            case 2:
               _loc4_ = this.vc2;
               break;
            case 3:
               _loc4_ = this.vc3;
               break;
            case 4:
               _loc4_ = this.vc4;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            if(_loc4_[_loc2_].AwakenConfigDate.Identifier == param1)
            {
               _loc5_ += _loc4_[_loc2_].Count;
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      public function addGetRewardTakeNotesById(param1:uint, param2:int = 1) : void
      {
         var _loc3_:AwakenDateCELL = new AwakenDateCELL();
         if(this.FGetRewardTakeNotes.length >= this.FBarCount)
         {
            this.FGetRewardTakeNotes.shift();
         }
         _loc3_.SetValueById(param1);
         _loc3_.Count = param2;
         this.FGetRewardTakeNotes.push(_loc3_);
      }
      
      public function AddBackPackageById(param1:uint, param2:int = 1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:AwakenDateCELL = new AwakenDateCELL();
         var _loc5_:Vector.<AwakenDateCELL> = null;
         _loc4_.SetValueById(param1);
         switch(_loc4_.AwakenConfigDate.Type)
         {
            case 1:
               _loc5_ = this.vc1;
               break;
            case 2:
               _loc5_ = this.vc2;
               break;
            case 3:
               _loc5_ = this.vc3;
               break;
            case 4:
               _loc5_ = this.vc4;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            if(_loc5_[_loc3_].AwakenConfigDate.Identifier == param1)
            {
               if(param2 == 0)
               {
                  _loc5_.splice(_loc3_,1);
               }
               else
               {
                  _loc5_[_loc3_].Count = param2;
               }
               return;
            }
            _loc3_++;
         }
         _loc4_.Count = param2;
         _loc5_.push(_loc4_);
      }
      
      public function GetVectorByType(param1:int, param2:Boolean = true) : Vector.<AwakenDateCELL>
      {
         var _loc3_:Vector.<AwakenDateCELL> = null;
         switch(param1)
         {
            case 1:
               _loc3_ = this.vc1;
               break;
            case 2:
               _loc3_ = this.vc2;
               break;
            case 3:
               _loc3_ = this.vc3;
               break;
            case 4:
               _loc3_ = this.vc4;
         }
         if(param2)
         {
            this.CopyVector(_loc3_);
         }
         else
         {
            this.CopyVectorBackAge();
         }
         this.SplitBackPackageVec();
         return this.FBackPackageVecCopy;
      }
      
      public function CopyVectorBackAge() : void
      {
         var _loc1_:int = 0;
         this.FBackPackageVecCopy.length = 0;
         _loc1_ = 0;
         while(_loc1_ < this.vc3.length)
         {
            this.FBackPackageVecCopy.push(this.CloneCell(this.vc3[_loc1_]));
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.vc4.length)
         {
            this.FBackPackageVecCopy.push(this.CloneCell(this.vc4[_loc1_]));
            _loc1_++;
         }
         this.FBackPackageVecCopy.sort(this.BiJiao);
      }
      
      protected function BiJiao(param1:AwakenDateCELL, param2:AwakenDateCELL) : int
      {
         if(param1.AwakenConfigDate.Order < param2.AwakenConfigDate.Order)
         {
            return -1;
         }
         return 1;
      }
      
      public function CopyVector(param1:Vector.<AwakenDateCELL>) : void
      {
         var _loc2_:int = 0;
         this.FBackPackageVecCopy.length = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            this.FBackPackageVecCopy.push(this.CloneCell(param1[_loc2_]));
            _loc2_++;
         }
         this.FBackPackageVecCopy.sort(this.BiJiao);
      }
      
      protected function CloneCell(param1:AwakenDateCELL) : AwakenDateCELL
      {
         var _loc2_:AwakenDateCELL = new AwakenDateCELL();
         _loc2_.SetValueById(param1.AwakenConfigDate.Identifier);
         _loc2_.Count = param1.Count;
         return _loc2_;
      }
      
      protected function SplitBackPackageVec() : void
      {
         var _loc1_:int = 0;
         var _loc2_:AwakenDateCELL = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBackPackageVecCopy.length)
         {
            if(this.FBackPackageVecCopy[_loc1_].Count > this.FBackPackageVecCopy[_loc1_].AwakenConfigDate.StackNum)
            {
               _loc2_ = this.CloneCell(this.FBackPackageVecCopy[_loc1_]);
               _loc2_.Count = this.FBackPackageVecCopy[_loc1_].Count - this.FBackPackageVecCopy[_loc1_].AwakenConfigDate.StackNum;
               this.FBackPackageVecCopy[_loc1_].Count = this.FBackPackageVecCopy[_loc1_].AwakenConfigDate.StackNum;
               this.FBackPackageVecCopy.splice(_loc1_ + 1,0,_loc2_);
            }
            _loc1_++;
         }
      }
      
      public function get PiLiangCountVec() : Vector.<uint>
      {
         return this.FPiLiangCountVec;
      }
      
      public function get DanCiCountVec() : Vector.<uint>
      {
         return this.FDanCiCountVec;
      }
      
      public function get DangRiYiShiYongDuiHuanCount() : Vector.<uint>
      {
         return this.FDangRiYiShiYongDuiHuanCount;
      }
      
      public function get DangRiYiDuiHuanCount() : Vector.<uint>
      {
         return this.FDangRiYiDuiHuanCount;
      }
      
      public function get NextTimesVec() : Vector.<uint>
      {
         return this.FNextTimesVec;
      }
      
      public function get GetRewardTakeNotes() : Vector.<AwakenDateCELL>
      {
         return this.FGetRewardTakeNotes;
      }
      
      public function get ChangeCountVec() : Vector.<uint>
      {
         return this.FChangeCountVec;
      }
      
      public function set SuiPianId(param1:uint) : void
      {
         this.FSuiPianId = param1;
      }
      
      public function get SuiPianId() : uint
      {
         return this.FSuiPianId;
      }
      
      public function GetDanCiMastCountByType(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = int(this.FDiJiDanCiMastCount);
               break;
            case 1:
               _loc2_ = int(this.FZhongJiDanCiMastCount);
               break;
            case 2:
               _loc2_ = int(this.FGaoJiDanCiMastCount);
         }
         return _loc2_;
      }
      
      public function GetPiLiangMastCountByType(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = int(this.FDiJiPiLiangDanCiMastCount);
               break;
            case 1:
               _loc2_ = int(this.FZhongJiPiLiangDanCiMastCount);
               break;
            case 2:
               _loc2_ = int(this.FGaoJiPiLiangDanCiMastCount);
         }
         return _loc2_;
      }
      
      public function set DanRiMastCount(param1:int) : void
      {
         this.FDanRiMastCount = param1;
      }
      
      public function get DanRiMastCount() : int
      {
         return this.FDanRiMastCount;
      }
      
      public function set PiLiangMastCount(param1:int) : void
      {
         this.FPiLiangMastCount = param1;
      }
      
      public function get PiLiangMastCount() : int
      {
         return this.FPiLiangMastCount;
      }
      
      public function get GaoJiPiLiangDanCiMastCount() : uint
      {
         return this.FGaoJiPiLiangDanCiMastCount;
      }
      
      public function set GaoJiPiLiangDanCiMastCount(param1:uint) : void
      {
         this.FGaoJiPiLiangDanCiMastCount = param1;
      }
      
      public function get GaoJiDanCiMastCount() : uint
      {
         return this.FGaoJiDanCiMastCount;
      }
      
      public function set GaoJiDanCiMastCount(param1:uint) : void
      {
         this.FGaoJiDanCiMastCount = param1;
      }
      
      public function get ZhongJiPiLiangDanCiMastCount() : uint
      {
         return this.FZhongJiPiLiangDanCiMastCount;
      }
      
      public function set ZhongJiPiLiangDanCiMastCount(param1:uint) : void
      {
         this.FZhongJiPiLiangDanCiMastCount = param1;
      }
      
      public function get ZhongJiDanCiMastCount() : uint
      {
         return this.FZhongJiDanCiMastCount;
      }
      
      public function set ZhongJiDanCiMastCount(param1:uint) : void
      {
         this.FZhongJiDanCiMastCount = param1;
      }
      
      public function get DiJiPiLiangDanCiMastCount() : uint
      {
         return this.FDiJiPiLiangDanCiMastCount;
      }
      
      public function set DiJiPiLiangDanCiMastCount(param1:uint) : void
      {
         this.FDiJiPiLiangDanCiMastCount = param1;
      }
      
      public function get DiJiDanCiMastCount() : uint
      {
         return this.FDiJiDanCiMastCount;
      }
      
      public function set DiJiDanCiMastCount(param1:uint) : void
      {
         this.FDiJiDanCiMastCount = param1;
      }
      
      public function set DaoJiGaoJiTanSuoCount(param1:Vector.<uint>) : void
      {
         this.FDaoJiGaoJiTanSuoCount = param1;
      }
      
      public function get DaoJiGaoJiTanSuoCount() : Vector.<uint>
      {
         return this.FDaoJiGaoJiTanSuoCount;
      }
      
      public function set DaoJiZhongJiTanSuoCount(param1:Vector.<uint>) : void
      {
         this.FDaoJiZhongJiTanSuoCount = param1;
      }
      
      public function get DaoJiZhongJiTanSuoCount() : Vector.<uint>
      {
         return this.FDaoJiZhongJiTanSuoCount;
      }
      
      public function set DaoJiDiJiTanSuoCount(param1:Vector.<uint>) : void
      {
         this.FDaoJiDiJiTanSuoCount = param1;
      }
      
      public function get DaoJiDiJiTanSuoCount() : Vector.<uint>
      {
         return this.FDaoJiDiJiTanSuoCount;
      }
      
      public function GetArrByType(param1:int) : Vector.<uint>
      {
         var _loc2_:Vector.<uint> = null;
         switch(param1)
         {
            case 0:
               _loc2_ = this.FDaoJiDiJiTanSuoCount;
               break;
            case 1:
               _loc2_ = this.FDaoJiZhongJiTanSuoCount;
               break;
            case 2:
               _loc2_ = this.FDaoJiGaoJiTanSuoCount;
         }
         return _loc2_;
      }
      
      public function GetDaoJuCountAtBeiBaoByType(param1:int) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:TInventories = null;
         var _loc6_:TInventory = null;
         _loc5_ = SLogicsCore.Character.Appliances;
         _loc3_ = uint(_loc5_.Count);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc6_ = _loc5_.GetInventoryByIndex(_loc2_);
            if(_loc6_.IDTemplate == this.GetArrByType(param1)[0])
            {
               _loc4_ += _loc6_.Quantity;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function set BarCount(param1:int) : void
      {
         this.FBarCount = param1;
      }
      
      public function get BarCount() : int
      {
         return this.FBarCount;
      }
      
      public function get TanSuoCountVec() : Vector.<uint>
      {
         return this.FTanSuoCountVec;
      }
      
      public function get TanSuoIdVec() : Vector.<uint>
      {
         return this.FTanSuoIdVec;
      }
      
      public function set TanSuoBtnIsCanClick(param1:int) : void
      {
         this.FTanSuoBtnIsCanClick = param1;
      }
      
      public function get TanSuoBtnIsCanClick() : int
      {
         return this.FTanSuoBtnIsCanClick;
      }
      
      public function CheckStatus() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FNextTimesVec.length)
         {
            if(this.FNextTimesVec[_loc1_] - STimingCore.GetServerTick() <= 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function TotalClipType() : int
      {
         var _loc1_:int = 0;
         var _loc2_:TAwakenConfig = null;
         var _loc3_:int = 0;
         if(!this.AwakenConfigBins)
         {
            this.AwakenConfigBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_AwakenConfig);
         }
         _loc1_ = 0;
         while(_loc1_ < this.AwakenConfigBins.Count)
         {
            _loc2_ = this.AwakenConfigBins.GetDatebaseByIndex(_loc1_) as TAwakenConfig;
            if(_loc2_.Type == 2)
            {
               _loc3_++;
            }
            _loc1_++;
         }
         return _loc3_;
      }
      
      public function GetClipIndexByID(param1:int, param2:Vector.<AwakenDateCELL>) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param2.length)
         {
            if(param2[_loc3_].AwakenConfigDate.Identifier == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
   }
}

