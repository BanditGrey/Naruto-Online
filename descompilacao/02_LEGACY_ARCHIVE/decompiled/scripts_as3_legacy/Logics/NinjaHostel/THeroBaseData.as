package Logics.NinjaHostel
{
   import Foundation.Resources.SResourcesCore;
   import Logics.DatebaseVO.VO.TBaseHero;
   import Resources.Constants.CONST_CHARACTER;
   import Resources.Constants.CONST_DATEBASEVO;
   
   public class THeroBaseData
   {
      
      public static const PROFESSION_Agility:uint = CONST_CHARACTER.PROFESSION_Agility;
      
      public static const PROFESSION_Defending:uint = CONST_CHARACTER.PROFESSION_Defending;
      
      public static const PROFESSION_Intellect:uint = CONST_CHARACTER.PROFESSION_Intellect;
      
      public static const PROFESSION_Strength:uint = CONST_CHARACTER.PROFESSION_Strength;
      
      public static const INDEX_Station_Front:int = 1;
      
      public static const INDEX_Station_Middle:int = 2;
      
      public static const INDEX_Station_After:int = 3;
      
      protected var FIdentifier:uint;
      
      protected var FHeroLevel:uint;
      
      protected var FProfession:uint;
      
      protected var FQuality:uint;
      
      protected var FOrigionId:uint;
      
      protected var FReincarnationOneOrTwo:uint;
      
      protected var FIsMain:Boolean;
      
      protected var FName:String;
      
      public function THeroBaseData(param1:uint, param2:uint)
      {
         var _loc3_:TBaseHero = null;
         super();
         this.FIdentifier = param1;
         this.FHeroLevel = param2;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BaseHero,param1) as TBaseHero;
         this.FIsMain = _loc3_.IsMain;
         this.FProfession = _loc3_.Profession;
         this.FQuality = _loc3_.Quality;
         this.FOrigionId = _loc3_.OrigionId;
         this.FReincarnationOneOrTwo = _loc3_.TransState;
         this.FName = _loc3_.Name;
      }
      
      public function get Identifier() : uint
      {
         return this.FIdentifier;
      }
      
      public function set Identifier(param1:uint) : void
      {
         this.FIdentifier = param1;
      }
      
      public function get HeroLevel() : uint
      {
         return this.FHeroLevel;
      }
      
      public function set HeroLevel(param1:uint) : void
      {
         this.FHeroLevel = param1;
      }
      
      public function get Quality() : uint
      {
         return this.FQuality;
      }
      
      public function set Quality(param1:uint) : void
      {
         this.FHeroLevel = this.FQuality;
      }
      
      public function get OrigionId() : uint
      {
         return this.FOrigionId;
      }
      
      public function set OrigionId(param1:uint) : void
      {
         this.FOrigionId = this.FQuality;
      }
      
      public function get ReincarnationOneOrTwo() : uint
      {
         return this.FReincarnationOneOrTwo;
      }
      
      public function set ReincarnationOneOrTwo(param1:uint) : void
      {
         this.FReincarnationOneOrTwo = this.FQuality;
      }
      
      public function get Name() : String
      {
         return this.FName;
      }
      
      public function set Name(param1:String) : void
      {
         this.FName = param1;
      }
      
      public function get Profession() : uint
      {
         return this.FProfession;
      }
      
      public function set Profession(param1:uint) : void
      {
         this.FProfession = param1;
      }
      
      public function get StandPositionWithProfession() : uint
      {
         var _loc1_:uint = 0;
         switch(this.FProfession)
         {
            case PROFESSION_Agility:
            case PROFESSION_Strength:
               _loc1_ = uint(INDEX_Station_Middle);
               break;
            case PROFESSION_Defending:
               _loc1_ = uint(INDEX_Station_Front);
               break;
            case PROFESSION_Intellect:
               _loc1_ = uint(INDEX_Station_After);
               if(this.FIsMain)
               {
                  _loc1_ = uint(INDEX_Station_Middle);
               }
         }
         return _loc1_;
      }
   }
}

