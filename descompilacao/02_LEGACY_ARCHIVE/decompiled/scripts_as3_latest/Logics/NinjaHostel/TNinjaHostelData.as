package Logics.NinjaHostel
{
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   
   public class TNinjaHostelData
   {
      
      protected var FHerosBase:Vector.<THeroBaseData>;
      
      protected var FHostelHeros:THeros;
      
      protected var FMaxTabCount:uint;
      
      protected var FTabIndex:uint;
      
      public var CommonItem:int;
      
      public function TNinjaHostelData()
      {
         super();
         this.FHerosBase = new Vector.<THeroBaseData>();
         this.FHostelHeros = new THeros();
         this.FTabIndex = 0;
      }
      
      protected function SortByQuality(param1:THeroBaseData, param2:THeroBaseData) : int
      {
         if(param1.Quality != param2.Quality)
         {
            return param2.Quality - param1.Quality;
         }
         if(param2.HeroLevel != param1.HeroLevel)
         {
            return param2.HeroLevel - param1.HeroLevel;
         }
         return param2.Identifier - param1.Identifier;
      }
      
      public function get HostelHeroCount() : int
      {
         return this.FHerosBase.length;
      }
      
      public function get HerosBase() : Vector.<THeroBaseData>
      {
         return this.FHerosBase;
      }
      
      public function get HostelHeros() : THeros
      {
         return this.FHostelHeros;
      }
      
      public function get MaxTabCount() : uint
      {
         return this.FMaxTabCount;
      }
      
      public function set MaxTabCount(param1:uint) : void
      {
         this.FMaxTabCount = param1;
      }
      
      public function SortHeroBase() : void
      {
         this.FHerosBase.sort(this.SortByQuality);
      }
      
      public function AddHeroBase(param1:uint, param2:uint) : void
      {
         var _loc3_:int = 0;
         var _loc4_:uint = 0;
         _loc4_ = this.FHerosBase.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(this.FHerosBase[_loc3_].Identifier == param1)
            {
               return;
            }
            _loc3_++;
         }
         this.FHerosBase.push(new THeroBaseData(param1,param2));
      }
      
      public function DeleteHeroBase(param1:uint) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.FHerosBase.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FHerosBase[_loc2_].Identifier == param1)
            {
               this.FHerosBase.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function GetHerBaseById(param1:uint) : THeroBaseData
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         _loc3_ = this.FHerosBase.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this.FHerosBase[_loc2_].OrigionId == param1)
            {
               return this.FHerosBase[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetHeroInfoById(param1:uint) : THero
      {
         return this.FHostelHeros.GetHeroByIdentifier(param1);
      }
      
      public function AddHeroInfo(param1:THero) : void
      {
         this.FHostelHeros.Add(param1);
      }
      
      public function DeleteHeroInfo(param1:THero) : void
      {
         this.FHostelHeros.Delete(param1);
      }
      
      public function SetFilterStatus(param1:uint) : void
      {
         this.FTabIndex = param1;
      }
      
      public function FilterHeros() : Vector.<THeroBaseData>
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:THeroBaseData = null;
         var _loc4_:Vector.<THeroBaseData> = null;
         _loc4_ = new Vector.<THeroBaseData>();
         _loc2_ = this.FHerosBase.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FHerosBase[_loc1_];
            if(this.FTabIndex == 0 || _loc3_.StandPositionWithProfession == this.FTabIndex)
            {
               _loc4_.push(_loc3_);
            }
            _loc1_++;
         }
         return _loc4_;
      }
      
      public function GetHerBaseByIndex(param1:uint) : THeroBaseData
      {
         return this.FHerosBase[param1];
      }
   }
}

