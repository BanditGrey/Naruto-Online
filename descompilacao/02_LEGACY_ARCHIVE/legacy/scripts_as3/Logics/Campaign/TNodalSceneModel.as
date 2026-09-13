package Logics.Campaign
{
   public class TNodalSceneModel
   {
      
      protected var FEnterType:int;
      
      protected var FCityId:int;
      
      protected var FMissionId:int;
      
      protected var FLayerIndex:int;
      
      protected var FEnemyIndex:int;
      
      protected var FDiffculty:int;
      
      protected var FResourceBgId:int;
      
      protected var FHeros:TMonsters;
      
      protected var FMonsters:Vector.<TMonsters>;
      
      protected var FEnemyArmyId:Vector.<uint>;
      
      public function TNodalSceneModel()
      {
         super();
         this.FHeros = new TMonsters();
         this.FMonsters = new Vector.<TMonsters>();
         this.FEnemyArmyId = new Vector.<uint>();
      }
      
      public function get EnterType() : int
      {
         return this.FEnterType;
      }
      
      public function set EnterType(param1:int) : void
      {
         this.FEnterType = param1;
      }
      
      public function get CityId() : int
      {
         return this.FCityId;
      }
      
      public function set CityId(param1:int) : void
      {
         this.FCityId = param1;
      }
      
      public function get MissionId() : int
      {
         return this.FMissionId;
      }
      
      public function set MissionId(param1:int) : void
      {
         this.FMissionId = param1;
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
      
      public function get Diffculty() : int
      {
         return this.FDiffculty;
      }
      
      public function set Diffculty(param1:int) : void
      {
         this.FDiffculty = param1;
      }
      
      public function get ResourceBgId() : int
      {
         return this.FResourceBgId;
      }
      
      public function set ResourceBgId(param1:int) : void
      {
         this.FResourceBgId = param1;
      }
      
      public function get Heros() : TMonsters
      {
         return this.FHeros;
      }
      
      public function set Heros(param1:TMonsters) : void
      {
         this.FHeros = param1;
      }
      
      public function get Monsters() : Vector.<TMonsters>
      {
         return this.FMonsters;
      }
      
      public function set Monsters(param1:Vector.<TMonsters>) : void
      {
         this.FMonsters = param1;
      }
      
      public function get MonstersCount() : int
      {
         return this.FMonsters.length;
      }
      
      public function get EnemyArmyId() : Vector.<uint>
      {
         return this.FEnemyArmyId;
      }
      
      public function set EnemyArmyId(param1:Vector.<uint>) : void
      {
         this.FEnemyArmyId = param1;
      }
      
      public function Reset() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         this.FLayerIndex = -1;
         this.FEnemyIndex = -1;
         this.FHeros.Clear();
         _loc2_ = this.FMonsters.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.FMonsters[_loc1_].Clear();
            _loc1_++;
         }
         this.FMonsters.length = 0;
         this.FEnemyArmyId.length = 0;
      }
   }
}

