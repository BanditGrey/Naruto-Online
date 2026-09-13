package Logics.Campaign
{
   import Foundation.Common.*;
   import Foundation.Common.Stubs.*;
   import Logics.Items.*;
   import Logics.Spaces.*;
   
   use namespace LogicsSpace;
   
   public class TCampaign extends TEntity
   {
      
      public static const Type_None:int = -1;
      
      public static const Type_Noraml:int = 0;
      
      public static const Type_Hard:int = 1;
      
      protected var FStubReferences:TStubReferences;
      
      protected var FDiffculty:int;
      
      protected var FLayerIndex:int;
      
      protected var FEnemyIndex:int;
      
      protected var FOpenLevel:uint;
      
      protected var FEnterCount:int;
      
      protected var FResetCount:int;
      
      protected var FNormalCampId:uint;
      
      protected var FHardCampId:uint;
      
      protected var FNormalDropItems:TItems;
      
      protected var FHardDropItems:TItems;
      
      protected var FNormalEnemy:Vector.<Vector.<uint>>;
      
      protected var FHardEnemy:Vector.<Vector.<uint>>;
      
      protected var FIsInit:Boolean;
      
      public function TCampaign(param1:uint)
      {
         super(param1);
         this.FStubReferences = new TStubReferences(this);
         this.FNormalDropItems = new TItems();
         this.FHardDropItems = new TItems();
         this.FNormalEnemy = new Vector.<Vector.<uint>>();
         this.FHardEnemy = new Vector.<Vector.<uint>>();
         this.FIsInit = false;
      }
      
      LogicsSpace function Coerce(param1:uint) : void
      {
         FIdentifier = param1;
      }
      
      public function get StubReferences() : TStubReferences
      {
         return this.FStubReferences;
      }
      
      public function get Diffculty() : int
      {
         return this.FDiffculty;
      }
      
      public function set Diffculty(param1:int) : void
      {
         this.FDiffculty = param1;
      }
      
      public function get LayerIndex() : int
      {
         return this.FLayerIndex;
      }
      
      public function set LayerIndex(param1:int) : void
      {
         this.FLayerIndex = param1;
      }
      
      public function get EnemyIndex() : int
      {
         return this.FEnemyIndex;
      }
      
      public function set EnemyIndex(param1:int) : void
      {
         this.FEnemyIndex = param1;
      }
      
      public function get OpenLevel() : uint
      {
         return this.FOpenLevel;
      }
      
      public function set OpenLevel(param1:uint) : void
      {
         this.FOpenLevel = param1;
      }
      
      public function get EnterCount() : int
      {
         return this.FEnterCount;
      }
      
      public function set EnterCount(param1:int) : void
      {
         this.FEnterCount = param1;
      }
      
      public function get ResetCount() : int
      {
         return this.FResetCount;
      }
      
      public function set ResetCount(param1:int) : void
      {
         this.FResetCount = param1;
      }
      
      public function get NormalCampId() : int
      {
         return this.FNormalCampId;
      }
      
      public function set NormalCampId(param1:int) : void
      {
         this.FNormalCampId = param1;
      }
      
      public function get HardCampId() : int
      {
         return this.FHardCampId;
      }
      
      public function set HardCampId(param1:int) : void
      {
         this.FHardCampId = param1;
      }
      
      public function get NormalDropItems() : TItems
      {
         return this.FNormalDropItems;
      }
      
      public function set NormalDropItems(param1:TItems) : void
      {
         this.FNormalDropItems = param1;
      }
      
      public function get HardDropItems() : TItems
      {
         return this.FHardDropItems;
      }
      
      public function set HardDropItems(param1:TItems) : void
      {
         this.FHardDropItems = param1;
      }
      
      public function get NormalEnemy() : Vector.<Vector.<uint>>
      {
         return this.FNormalEnemy;
      }
      
      public function set NormalEnemy(param1:Vector.<Vector.<uint>>) : void
      {
         this.FNormalEnemy = param1;
      }
      
      public function get HardEnemy() : Vector.<Vector.<uint>>
      {
         return this.FHardEnemy;
      }
      
      public function set HardEnemy(param1:Vector.<Vector.<uint>>) : void
      {
         this.FHardEnemy = param1;
      }
      
      public function get IsInit() : Boolean
      {
         return this.FIsInit;
      }
      
      public function set IsInit(param1:Boolean) : void
      {
         this.FIsInit = param1;
      }
      
      public function GetEnemyByIndex(param1:uint, param2:Vector.<uint>) : int
      {
         var _loc3_:uint = 0;
         var _loc4_:Vector.<Vector.<uint>> = null;
         var _loc5_:Vector.<uint> = null;
         if(param1 == Type_Noraml)
         {
            _loc4_ = this.FNormalEnemy;
         }
         else
         {
            if(param1 != Type_Hard)
            {
               return -1;
            }
            _loc4_ = this.FHardEnemy;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_] == param2)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function GetCurEnemyCount(param1:uint) : int
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<Vector.<uint>> = null;
         if(param1 == this.Diffculty)
         {
            if(param1 == Type_Noraml)
            {
               _loc4_ = this.FNormalEnemy;
            }
            else if(param1 == Type_Hard)
            {
               _loc4_ = this.FHardEnemy;
            }
            _loc3_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc4_.length)
            {
               if(_loc2_ >= this.FLayerIndex)
               {
                  _loc3_ += this.FEnemyIndex;
                  break;
               }
               _loc3_ += _loc4_[_loc2_].length;
               _loc2_++;
            }
            return _loc3_;
         }
         return 0;
      }
      
      public function GetMaxEnemyCount(param1:uint) : int
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Vector.<Vector.<uint>> = null;
         if(param1 == Type_Noraml)
         {
            _loc4_ = this.FNormalEnemy;
         }
         else if(param1 == Type_Hard)
         {
            _loc4_ = this.FHardEnemy;
         }
         _loc3_ = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc3_ += _loc4_[_loc2_].length;
            _loc2_++;
         }
         return _loc3_;
      }
      
      public function GetLayerEnemyCount(param1:uint) : int
      {
         var _loc2_:Vector.<Vector.<uint>> = null;
         if(this.FDiffculty == Type_Noraml)
         {
            _loc2_ = this.FNormalEnemy;
         }
         else if(this.FDiffculty == Type_Hard)
         {
            _loc2_ = this.FHardEnemy;
         }
         return _loc2_[param1].length;
      }
      
      public function IsPass() : Boolean
      {
         var _loc1_:Vector.<Vector.<uint>> = null;
         if(this.FDiffculty == Type_Noraml)
         {
            _loc1_ = this.FNormalEnemy;
         }
         else
         {
            if(this.FDiffculty != Type_Hard)
            {
               return true;
            }
            _loc1_ = this.FHardEnemy;
         }
         if(this.FLayerIndex == _loc1_.length - 1 && this.FEnemyIndex >= _loc1_[this.FLayerIndex].length || this.FLayerIndex > _loc1_.length - 1)
         {
            return true;
         }
         return false;
      }
   }
}

