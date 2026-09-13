package Processors.Game.Lobby.Taboo.Data
{
   import Foundation.Resources.SResourcesCore;
   import Logics.Characters.THero;
   import Logics.DatebaseVO.VO.TTabooAddition;
   import Logics.DatebaseVO.VO.TTabooBattle;
   import Logics.DatebaseVO.VO.TTabooConfig;
   import Processors.Game.Lobby.Taboo.Cell.GuanQiaCell;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_TABOO;
   
   public class TabooData
   {
      
      protected var FBackPackageVecCopy:Vector.<TabooDataCell> = null;
      
      protected var vc1:Vector.<TabooDataCell> = null;
      
      protected var vc2:Vector.<TabooDataCell> = null;
      
      protected var vc3:Vector.<TabooDataCell> = null;
      
      protected var TabooConfigBin:TTabooConfig = null;
      
      protected var TabooAdditionBin:TTabooAddition = null;
      
      protected var FCurGuanQia:uint = 0;
      
      protected var FCurSceneCode:int = 0;
      
      protected var FCurSceneIdentifier:int = 0;
      
      protected var FChallengeSurplusCount:int = 0;
      
      protected var FCurStage:int = 0;
      
      protected var FCurGuanQiaCell:GuanQiaCell;
      
      protected var FGuanQiaVec:Vector.<GuanQiaCell> = null;
      
      protected var TBattle:TTabooBattle;
      
      protected var FForRestFlg:Boolean;
      
      protected var FInheritCostGold:Vector.<uint>;
      
      public function TabooData()
      {
         super();
         this.FBackPackageVecCopy = new Vector.<TabooDataCell>();
         this.vc1 = new Vector.<TabooDataCell>();
         this.vc2 = new Vector.<TabooDataCell>();
         this.vc3 = new Vector.<TabooDataCell>();
         this.FGuanQiaVec = new Vector.<GuanQiaCell>();
      }
      
      public function InitilizationDate() : void
      {
      }
      
      public function get BackPackageVecCopy() : Vector.<TabooDataCell>
      {
         return this.FBackPackageVecCopy;
      }
      
      public function GetCountById(param1:uint) : int
      {
         var _loc2_:int = 0;
         var _loc3_:TabooDataCell = new TabooDataCell();
         var _loc4_:Vector.<TabooDataCell> = null;
         var _loc5_:int = 0;
         _loc3_.SetValueById(param1);
         switch(_loc3_.ConfigureConfig.Type)
         {
            case 1:
               _loc4_ = this.vc3;
               break;
            case 2:
               _loc4_ = this.vc1;
               break;
            case 3:
               _loc4_ = this.vc2;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            if(_loc4_[_loc2_].ConfigureConfig.Identifier == param1)
            {
               _loc5_ += _loc4_[_loc2_].Count;
            }
            _loc2_++;
         }
         return _loc5_;
      }
      
      public function AddBackPackageById(param1:uint, param2:int = 1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TabooDataCell = new TabooDataCell();
         var _loc5_:Vector.<TabooDataCell> = null;
         _loc4_.SetValueById(param1);
         switch(_loc4_.ConfigureConfig.Type)
         {
            case 1:
               _loc5_ = this.vc3;
               break;
            case 2:
               _loc5_ = this.vc1;
               break;
            case 3:
               _loc5_ = this.vc2;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            if(_loc5_[_loc3_].ConfigureConfig.Identifier == param1)
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
      
      public function GetBooleanToBagById(param1:int, param2:int) : Boolean
      {
         var _loc3_:uint = 0;
         _loc3_ = CONST_TABOO.Configuration_Base + param1 * 1000 + param2;
         var _loc4_:int = 0;
         while(_loc4_ < this.vc3.length)
         {
            if(_loc3_ == this.vc3[_loc4_].ConfigureConfig.Identifier)
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function GetJinShuCountById(param1:uint) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.vc3.length)
         {
            if(param1 == this.vc3[_loc2_].ConfigureConfig.Identifier)
            {
               return this.vc3[_loc2_].Count;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function GetVectorByType(param1:int) : Vector.<TabooDataCell>
      {
         var _loc2_:Vector.<TabooDataCell> = null;
         switch(param1)
         {
            case 1:
               _loc2_ = this.vc3;
               break;
            case 2:
               _loc2_ = this.vc1;
               break;
            case 3:
               _loc2_ = this.vc2;
         }
         this.CopyVector(_loc2_);
         this.SplitBackPackageVec();
         return this.FBackPackageVecCopy;
      }
      
      public function DeleteBackPackageById(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TabooDataCell = new TabooDataCell();
         var _loc4_:Vector.<TabooDataCell> = null;
         _loc3_.SetValueById(param1);
         switch(_loc3_.ConfigureConfig.Type)
         {
            case 1:
               _loc4_ = this.vc3;
               break;
            case 2:
               _loc4_ = this.vc1;
               break;
            case 3:
               _loc4_ = this.vc1;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            if(_loc4_[_loc2_].ConfigureConfig.Identifier == param1)
            {
               if(_loc4_[_loc2_].Count > 0)
               {
                  --_loc4_[_loc2_].Count;
               }
               else
               {
                  _loc4_.splice(_loc2_,1);
               }
               break;
            }
            _loc2_++;
         }
      }
      
      public function CopyVector(param1:Vector.<TabooDataCell>) : void
      {
         var _loc2_:int = 0;
         this.FBackPackageVecCopy.length = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            this.FBackPackageVecCopy.push(this.CloneCell(param1[_loc2_]));
            _loc2_++;
         }
      }
      
      protected function SplitBackPackageVec() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TabooDataCell = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBackPackageVecCopy.length)
         {
            if(this.FBackPackageVecCopy[_loc1_].Count > this.FBackPackageVecCopy[_loc1_].ConfigureConfig.StackNum)
            {
               _loc2_ = this.CloneCell(this.FBackPackageVecCopy[_loc1_]);
               _loc2_.Count = this.FBackPackageVecCopy[_loc1_].Count - this.FBackPackageVecCopy[_loc1_].ConfigureConfig.StackNum;
               this.FBackPackageVecCopy.splice(_loc1_ + 1,0,_loc2_);
            }
            _loc1_++;
         }
      }
      
      protected function CloneCell(param1:TabooDataCell) : TabooDataCell
      {
         var _loc2_:TabooDataCell = new TabooDataCell();
         _loc2_.SetValueById(param1.ConfigureConfig.Identifier);
         _loc2_.Count = param1.Count;
         _loc2_.SkillCount = param1.SkillCount;
         return _loc2_;
      }
      
      public function GetTabooDataCellVector(param1:THero, param2:int, param3:int) : Vector.<TabooDataCell>
      {
         var _loc5_:int = 0;
         var _loc6_:TabooDataCell = null;
         var _loc4_:Vector.<TabooDataCell> = new Vector.<TabooDataCell>();
         _loc4_.length = 0;
         _loc5_ = 0;
         while(_loc5_ < param1.TabooMounted.length)
         {
            if(param1.TabooMounted[_loc5_].ConfigureAddition.SubType == param2)
            {
               if(param1.TabooMounted[_loc5_].ConfigureConfig.Quality == param3)
               {
                  _loc4_.push(this.CloneCell(param1.TabooMounted[_loc5_]));
               }
            }
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_].SkillCount > 1)
            {
               --_loc4_[_loc5_].SkillCount;
               _loc4_[_loc5_].SkillCount = 1;
               _loc4_.splice(_loc5_ + 1,0,_loc6_);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function GetAllValueByType(param1:int) : uint
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTabooAddition = null;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc3_ = CONST_TABOO.Configuration_Base + param1 * 1000 + 1 + _loc2_;
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooAddition,_loc3_) as TTabooAddition;
            _loc6_ = _loc4_.AddProperty;
            _loc5_ += _loc6_[0][1] * (_loc2_ + 4);
            _loc6_ = _loc4_.AddEffectArr;
            _loc5_ += _loc6_[0][1];
            _loc2_++;
         }
         return _loc5_;
      }
      
      public function get GuanQiaVec() : Vector.<GuanQiaCell>
      {
         return this.FGuanQiaVec;
      }
      
      public function AddGuanQiaVec(param1:uint, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:GuanQiaCell = null;
         this.TBattle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooBattle,param1) as TTabooBattle;
         _loc3_ = 0;
         while(_loc3_ < this.FGuanQiaVec.length)
         {
            if(this.FGuanQiaVec[_loc3_].CurCustomed == param1)
            {
               this.FGuanQiaVec[_loc3_].IsGetRewards = param2;
               this.FGuanQiaVec[_loc3_].ScreenId = this.TBattle.Location;
               _loc4_ = 1;
               break;
            }
            _loc3_++;
         }
         if(!_loc4_)
         {
            _loc5_ = new GuanQiaCell();
            _loc5_.CurCustomed = param1;
            _loc5_.CurBeginCustomed = this.TBattle.NextMode;
            _loc5_.CurStage = this.TBattle.SStage;
            _loc5_.IsGetRewards = param2;
            _loc5_.ScreenId = this.TBattle.Location;
            this.FGuanQiaVec.push(_loc5_);
         }
      }
      
      public function GetGuanQiaCellByConfig(param1:TTabooBattle) : GuanQiaCell
      {
         var _loc3_:int = 0;
         var _loc2_:GuanQiaCell = null;
         _loc3_ = 0;
         while(_loc3_ < this.FGuanQiaVec.length)
         {
            if(this.FGuanQiaVec[_loc3_].CurCustomed == param1.Identifier)
            {
               _loc2_ = this.FGuanQiaVec[_loc3_];
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function set CurGuanQia(param1:uint) : void
      {
         this.FCurGuanQia = param1;
         this.TBattle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooBattle,this.FCurGuanQia) as TTabooBattle;
         if(this.TBattle)
         {
            this.FCurSceneIdentifier = this.TBattle.Location;
            this.FCurSceneCode = uint(this.TBattle.Location.toString().charAt(this.TBattle.Location.toString().length - 1));
            this.FCurStage = this.TBattle.SStage;
         }
         else
         {
            this.FCurSceneIdentifier = 0;
            this.FCurSceneCode = 0;
            this.FCurStage = 0;
         }
      }
      
      public function get CurSceneIdentifier() : int
      {
         return this.FCurSceneIdentifier;
      }
      
      public function get CurSceneCode() : int
      {
         return this.FCurSceneCode;
      }
      
      public function set CurSceneCode(param1:int) : void
      {
         this.FCurSceneCode = param1;
      }
      
      public function get CurStage() : int
      {
         return this.FCurStage;
      }
      
      public function get CurGuanQiaCell() : GuanQiaCell
      {
         return this.FCurGuanQiaCell;
      }
      
      public function set CurGuanQiaCell(param1:GuanQiaCell) : void
      {
         this.FCurGuanQiaCell = param1;
      }
      
      public function set ChallengeSurplusCount(param1:int) : void
      {
         this.FChallengeSurplusCount = param1;
      }
      
      public function get ChallengeSurplusCount() : int
      {
         return this.FChallengeSurplusCount;
      }
      
      public function get CurGuanQia() : uint
      {
         return this.FCurGuanQia;
      }
      
      public function get ForRestFlg() : Boolean
      {
         return this.FForRestFlg;
      }
      
      public function set ForRestFlg(param1:Boolean) : void
      {
         this.FForRestFlg = param1;
      }
      
      public function get InheritCostGold() : Vector.<uint>
      {
         return this.FInheritCostGold;
      }
      
      public function set InheritCostGold(param1:Vector.<uint>) : void
      {
         this.FInheritCostGold = param1;
      }
      
      public function CheckStatus() : Boolean
      {
         if(this.FChallengeSurplusCount > 0)
         {
            return true;
         }
         return false;
      }
   }
}

