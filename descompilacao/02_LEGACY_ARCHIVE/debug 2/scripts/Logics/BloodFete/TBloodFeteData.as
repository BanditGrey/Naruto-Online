package Logics.BloodFete
{
   import Foundation.Common.Integer.UInt64;
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TFollowBloodBound;
   import Processors.Game.Lobby.BloodFete.cell.TBagBloodFeteCell;
   import Resources.Constants.CONST_BLOODFETE;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class TBloodFeteData
   {
      
      protected static const CONST_FIVE:int = 5;
      
      protected var FCallCast:int;
      
      protected var FBodyLevel_OpenCount:Vector.<uint>;
      
      protected var FBagCellOpened:int;
      
      protected var FBagCost_ByCount:Vector.<uint>;
      
      protected var FCallBloodFeteCountFree:int;
      
      protected var FCallBtnCountFree:int;
      
      protected var FDebrisId:uint;
      
      protected var FDebrisNum:uint;
      
      protected var FDebris64int:UInt64;
      
      protected var FMC_AutoSell_TaskIndex:int;
      
      protected var FMC_AutoCompound_Task:int;
      
      protected var FNumenBagBloodFete:Vector.<TBloodFeteSingle> = null;
      
      protected var FRealBagBloodFete:Vector.<TBloodFeteSingle> = null;
      
      protected var FTBagBFCell:Vector.<TBagBloodFeteCell> = null;
      
      protected var FTBNumenBBS:Vector.<TBloodFeteSingle> = null;
      
      protected var FBagFieldLocked:uint;
      
      protected var FBagFieldIsOpen:uint;
      
      protected var FFiveState:Vector.<uint> = null;
      
      protected var FIsOneKeyBloodState:Boolean = false;
      
      protected var FIsAutoClick:Boolean = false;
      
      protected var FCallCostPri:Vector.<int>;
      
      protected var FNewIndex:int = 0;
      
      protected var FNewName:String = "";
      
      public function TBloodFeteData()
      {
         super();
         this.FDebris64int = new UInt64();
         this.FNumenBagBloodFete = new Vector.<TBloodFeteSingle>();
         this.FRealBagBloodFete = new Vector.<TBloodFeteSingle>();
         this.FTBagBFCell = new Vector.<TBagBloodFeteCell>();
         this.FTBNumenBBS = new Vector.<TBloodFeteSingle>();
         this.FFiveState = new Vector.<uint>(CONST_FIVE);
         this.FCallCostPri = new Vector.<int>();
         this.FFiveState[0] = 0;
         this.FFiveState[1] = 1;
         this.FFiveState[2] = 1;
         this.FFiveState[3] = 1;
         this.FFiveState[4] = 1;
      }
      
      protected function SetValue(param1:TBloodFeteSingle) : void
      {
         var _loc2_:TFollowBloodBound = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_FollowBloodBound,param1.Identifier) as TFollowBloodBound;
         param1.Type = _loc2_.Type;
         param1.EffectId = _loc2_.IconID;
         param1.Name = _loc2_.Name;
         param1.Quality = _loc2_.Quality;
         param1.Price = _loc2_.Price;
         param1.AddAttrArr = _loc2_.AddAttrArr;
         param1.NeedExp = _loc2_.NeedExp;
         param1.AllExp = _loc2_.ExpAll;
         param1.Levelcount = _loc2_.Levelcount;
         param1.DevourExp = _loc2_.DevourExp;
         param1.Level = _loc2_.Level;
         param1.NextLevelID = _loc2_.NextLevelID;
      }
      
      public function get FiveState() : Vector.<uint>
      {
         return this.FFiveState;
      }
      
      public function get NumenBagBloodFete() : Vector.<TBloodFeteSingle>
      {
         return this.FNumenBagBloodFete;
      }
      
      public function get RealBagBloodFete() : Vector.<TBloodFeteSingle>
      {
         return this.FRealBagBloodFete;
      }
      
      public function set BagCellOpened(param1:int) : void
      {
         this.FBagCellOpened = param1;
      }
      
      public function get BagCellOpened() : int
      {
         return this.FBagCellOpened;
      }
      
      public function set BagCost_ByCount(param1:Vector.<uint>) : void
      {
         this.FBagCost_ByCount = param1;
      }
      
      public function get BagCost_ByCount() : Vector.<uint>
      {
         return this.FBagCost_ByCount;
      }
      
      public function set BodyLevel_OpenCount(param1:Vector.<uint>) : void
      {
         this.FBodyLevel_OpenCount = param1;
      }
      
      public function get BodyLevel_OpenCount() : Vector.<uint>
      {
         return this.FBodyLevel_OpenCount;
      }
      
      public function set CallCast(param1:int) : void
      {
         this.FCallCast = param1;
      }
      
      public function get CallCast() : int
      {
         return this.FCallCast;
      }
      
      public function set CallBloodFeteCountFree(param1:int) : void
      {
         this.FCallBloodFeteCountFree = param1;
      }
      
      public function get CallBloodFeteCountFree() : int
      {
         return this.FCallBloodFeteCountFree;
      }
      
      public function set CallBtnCountFree(param1:int) : void
      {
         this.FCallBtnCountFree = param1;
      }
      
      public function get CallBtnCountFree() : int
      {
         return this.FCallBtnCountFree;
      }
      
      public function set DebrisId(param1:uint) : void
      {
         this.FDebrisId = param1;
      }
      
      public function get DebrisId() : uint
      {
         return this.FDebrisId;
      }
      
      public function get DebrisNum() : uint
      {
         return this.FDebrisNum;
      }
      
      public function set DebrisNum(param1:uint) : void
      {
         this.FDebrisNum = param1;
      }
      
      public function set Debris64int(param1:UInt64) : void
      {
         this.FDebris64int = param1;
      }
      
      public function get Debris64int() : UInt64
      {
         return this.FDebris64int;
      }
      
      public function set MC_AutoSell_TaskIndex(param1:int) : void
      {
         this.FMC_AutoSell_TaskIndex = param1;
      }
      
      public function get MC_AutoSell_TaskIndex() : int
      {
         return this.FMC_AutoSell_TaskIndex;
      }
      
      public function set MC_AutoCompound_Task(param1:int) : void
      {
         this.FMC_AutoCompound_Task = param1;
      }
      
      public function get MC_AutoCompound_Task() : int
      {
         return this.FMC_AutoCompound_Task;
      }
      
      public function set BagFieldIsOpen(param1:uint) : void
      {
         this.FBagFieldIsOpen = param1;
      }
      
      public function get BagFieldIsOpen() : uint
      {
         return this.FBagFieldIsOpen;
      }
      
      public function set BagFieldLocked(param1:uint) : void
      {
         this.FBagFieldLocked = param1;
      }
      
      public function get BagFieldLocked() : uint
      {
         return CONST_BLOODFETE.PackageNum - this.FBagFieldLocked;
      }
      
      public function set IsOneKeyBloodState(param1:Boolean) : void
      {
         this.FIsOneKeyBloodState = param1;
      }
      
      public function get IsOneKeyBloodState() : Boolean
      {
         return this.FIsOneKeyBloodState;
      }
      
      public function set IsAutoClick(param1:Boolean) : void
      {
         this.FIsAutoClick = param1;
      }
      
      public function get IsAutoClick() : Boolean
      {
         return this.FIsAutoClick;
      }
      
      public function set TBNumenBBS(param1:Vector.<TBloodFeteSingle>) : void
      {
         this.FTBNumenBBS = param1;
      }
      
      public function get TBNumenBBS() : Vector.<TBloodFeteSingle>
      {
         if(this.FTBNumenBBS.length > 30)
         {
            this.FTBNumenBBS.shift();
         }
         return this.FTBNumenBBS;
      }
      
      public function set TBagBFCell(param1:Vector.<TBagBloodFeteCell>) : void
      {
         this.FTBagBFCell = param1;
      }
      
      public function get TBagBFCell() : Vector.<TBagBloodFeteCell>
      {
         if(this.FTBagBFCell.length > 30)
         {
            this.FTBagBFCell.shift();
         }
         return this.FTBagBFCell;
      }
      
      public function get CallCostPri() : Vector.<int>
      {
         return this.FCallCostPri;
      }
      
      public function set NewIndex(param1:int) : void
      {
         this.FNewIndex = param1;
      }
      
      public function get NewIndex() : int
      {
         return this.FNewIndex;
      }
      
      public function set NewName(param1:String) : void
      {
         this.FNewName = param1;
      }
      
      public function get NewName() : String
      {
         return this.FNewName;
      }
      
      public function addNumenBagBloodFete(param1:TBloodFeteSingle) : void
      {
         this.ReflaeshProperty(param1);
         this.FNumenBagBloodFete.push(param1);
      }
      
      public function addRealBagBloodFete(param1:TBloodFeteSingle) : void
      {
         this.ReflaeshProperty(param1);
         this.FRealBagBloodFete.push(param1);
         if(this.FRealBagBloodFete.length == 20)
         {
            this.FIsOneKeyBloodState = false;
         }
         else
         {
            this.FIsOneKeyBloodState = true;
         }
      }
      
      public function ReflaeshProperty(param1:TBloodFeteSingle) : void
      {
         this.SetValue(param1);
      }
      
      public function deleteNumenBagBloodFete(param1:uint, param2:uint) : TBloodFeteSingle
      {
         var _loc3_:int = this.GetIndexByNumenBloodFete(param1,param2);
         if(_loc3_ < 0)
         {
            return null;
         }
         var _loc4_:Vector.<TBloodFeteSingle> = this.FNumenBagBloodFete.splice(_loc3_,1);
         return _loc4_[0];
      }
      
      public function addBFStoNumenBBS(param1:TBloodFeteSingle) : void
      {
         if(this.FTBNumenBBS.length < 30)
         {
            this.FTBNumenBBS.push(param1);
         }
      }
      
      public function deleteRealBagBloodFete(param1:uint, param2:uint) : int
      {
         var _loc3_:int = this.GetIndexByRealBloodFete(param1,param2);
         if(_loc3_ < 0)
         {
            return 0;
         }
         this.FRealBagBloodFete.splice(_loc3_,1);
         return _loc3_;
      }
      
      public function GetIndexByNumenBloodFete(param1:uint, param2:uint) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = -1;
         _loc4_ = 0;
         while(_loc4_ < this.FNumenBagBloodFete.length)
         {
            if(param1 == this.FNumenBagBloodFete[_loc4_].IdentifierUInt64.High && param2 == this.FNumenBagBloodFete[_loc4_].IdentifierUInt64.Low)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function GetBloodFeteById64Numen(param1:uint, param2:uint) : TBloodFeteSingle
      {
         var _loc4_:int = 0;
         var _loc3_:TBloodFeteSingle = null;
         _loc4_ = 0;
         while(_loc4_ < this.FNumenBagBloodFete.length)
         {
            if(param1 == this.FNumenBagBloodFete[_loc4_].IdentifierUInt64.High && param2 == this.FNumenBagBloodFete[_loc4_].IdentifierUInt64.Low)
            {
               _loc3_ = this.FNumenBagBloodFete[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function GetIndexByRealBloodFete(param1:uint, param2:uint) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = -1;
         _loc4_ = 0;
         while(_loc4_ < this.FRealBagBloodFete.length)
         {
            if(param1 == this.FRealBagBloodFete[_loc4_].IdentifierUInt64.High && param2 == this.FRealBagBloodFete[_loc4_].IdentifierUInt64.Low)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function GetBloodFeteById64Real(param1:uint, param2:uint) : TBloodFeteSingle
      {
         var _loc3_:TBloodFeteSingle = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < this.FRealBagBloodFete.length)
         {
            if(param1 == this.FRealBagBloodFete[_loc4_].IdentifierUInt64.High && param2 == this.FRealBagBloodFete[_loc4_].IdentifierUInt64.Low)
            {
               _loc3_ = this.FRealBagBloodFete[_loc4_];
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function GetBloodFeteByNumenIndex(param1:int) : TBloodFeteSingle
      {
         return this.FNumenBagBloodFete[param1];
      }
      
      public function GetBloodFeteByRealIndex(param1:int) : TBloodFeteSingle
      {
         return this.FRealBagBloodFete[param1];
      }
      
      public function SetFiveStateByIndex(param1:uint, param2:uint) : void
      {
         this.FFiveState[param1] = param2;
      }
      
      public function TBgBldFteCell() : TBagBloodFeteCell
      {
         var _loc1_:TBagBloodFeteCell = null;
         if(this.FTBagBFCell.length >= 1)
         {
            _loc1_ = this.FTBagBFCell.shift();
         }
         else
         {
            _loc1_ = new TBagBloodFeteCell();
         }
         return _loc1_;
      }
      
      public function FBNumenBBS() : TBloodFeteSingle
      {
         var _loc1_:TBloodFeteSingle = null;
         if(this.FTBNumenBBS.length > 1)
         {
            _loc1_ = this.FTBNumenBBS.pop();
         }
         else
         {
            _loc1_ = new TBloodFeteSingle();
         }
         return _loc1_;
      }
      
      public function CheckStatus() : Boolean
      {
         if(this.FCallBloodFeteCountFree > 0)
         {
            return true;
         }
         return false;
      }
   }
}

